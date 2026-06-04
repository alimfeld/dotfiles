// mcp.js — Shared MCP client helpers for web-search skill scripts
// Both search.js and fetch.js import from here to avoid duplication.

import { request } from 'node:https';

const MCP_HOST = 'mcp.exa.ai';
const MCP_PATH = '/mcp';

// Guard against runaway responses (e.g. a very large page or a misbehaving server).
const MAX_RESPONSE_BYTES = 10 * 1024 * 1024; // 10 MB

// Allow slow networks or large fetches to override the default via env var.
const TIMEOUT_MS = parseInt(process.env.WEB_SEARCH_TIMEOUT_MS ?? '15000', 10);

/** Send a JSON-RPC request over HTTP, parse SSE response, resolve with { sid, data }. */
export function post(sessionId, body) {
  return new Promise((resolve, reject) => {
    const payload = JSON.stringify(body);
    const headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json, text/event-stream',
      'Content-Length': Buffer.byteLength(payload),
    };
    if (sessionId) headers['Mcp-Session-Id'] = sessionId;

    const req = request({ hostname: MCP_HOST, path: MCP_PATH, method: 'POST', headers }, (res) => {
      const sid = res.headers['mcp-session-id'] ?? sessionId;
      // Explicit UTF-8 encoding prevents multi-byte characters being split across chunks.
      res.setEncoding('utf8');
      let raw = '';
      let rawBytes = 0;
      res.on('data', chunk => {
        rawBytes += Buffer.byteLength(chunk, 'utf8');
        if (rawBytes > MAX_RESPONSE_BYTES) {
          req.destroy(new Error(`Response too large (> ${MAX_RESPONSE_BYTES / 1024 / 1024} MB)`));
          return;
        }
        raw += chunk;
      });
      res.on('end', () => {
        if (res.statusCode >= 400) {
          return reject(new Error(`HTTP ${res.statusCode}: ${raw.slice(0, 200)}`));
        }
        const events = [];
        for (const line of raw.split('\n')) {
          if (line.startsWith('data: ')) {
            try { events.push(JSON.parse(line.slice(6))); } catch { /* malformed SSE line — skip */ }
          }
        }
        // Require a result/error event; events[0] could be a ping or partial frame.
        const event = events.find(e => e.result !== undefined || e.error !== undefined);
        if (event) {
          resolve({ sid, data: event });
        } else {
          reject(new Error('No result or error found in SSE response'));
        }
      });
    });

    req.on('error', reject);
    req.setTimeout(TIMEOUT_MS, () => req.destroy(new Error(`Request timed out after ${TIMEOUT_MS}ms`)));
    req.write(payload);
    req.end();
  });
}

/**
 * Perform the MCP initialisation handshake and return the session ID.
 * The protocol version '2024-11-05' is the version supported by Exa's hosted
 * MCP service. See https://spec.modelcontextprotocol.io for the specification.
 */
export async function initSession() {
  const { sid } = await post(null, {
    jsonrpc: '2.0', id: 1, method: 'initialize',
    params: {
      protocolVersion: '2024-11-05',
      capabilities: {},
      clientInfo: { name: 'web-search-skill', version: '1.0' },
    },
  });

  // Required by MCP spec: one-way notification that the client is ready.
  // Fire-and-forget; the server may not send a response.
  post(sid, { jsonrpc: '2.0', method: 'notifications/initialized' }).catch(() => {});

  return sid;
}

/**
 * Call an MCP tool and return the response data.
 * Retries once on transient network/timeout errors; does not retry on HTTP 4xx
 * because those indicate a client-side problem (bad input, auth, etc.).
 */
export async function callTool(sid, toolName, toolArgs) {
  const body = {
    jsonrpc: '2.0', id: 2, method: 'tools/call',
    params: { name: toolName, arguments: toolArgs },
  };
  try {
    return await post(sid, body);
  } catch (err) {
    if (err.message.startsWith('HTTP 4')) throw err; // client error — don't retry
    return await post(sid, body);                    // retry once on timeout / network error
  }
}
