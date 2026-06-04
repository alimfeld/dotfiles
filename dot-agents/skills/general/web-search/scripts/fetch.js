#!/usr/bin/env node
// fetch.js — Fetch page content via Exa MCP (no API key required)
// Usage: node fetch.js <url1> [url2 ...]

import { initSession, callTool } from './mcp.js';

const urls = process.argv.slice(2);

const MAX_URLS = 10;

if (!urls.length) {
  console.error(JSON.stringify({ error: 'Usage: node fetch.js <url1> [url2 ...]' }));
  process.exit(1);
}

if (urls.length > MAX_URLS) {
  console.error(JSON.stringify({ error: `Too many URLs: max ${MAX_URLS}, got ${urls.length}` }));
  process.exit(1);
}

// Validate all URLs before calling the API to surface typos early.
for (const u of urls) {
  try { new URL(u); }
  catch {
    console.error(JSON.stringify({ error: `Invalid URL: ${u}` }));
    process.exit(1);
  }
}

function parseResult(text) {
  const lines = text.split('\n');

  const result = { title: 'N/A', url: 'N/A', author: 'N/A', content: '' };

  // First line: "# Title" (markdown heading)
  result.title = lines[0].startsWith('# ') ? lines[0].slice(2).trim() : lines[0].trim();

  // Scan only the header lines (before the first blank line, or up to line 4 as a cap)
  // to avoid false matches from body text like "Author: ..." or "URL: ...".
  const blankIndex = lines.findIndex((l, i) => i > 0 && l.trim() === '');
  const headerEnd = blankIndex > 0 ? blankIndex : Math.min(4, lines.length);
  for (const line of lines.slice(1, headerEnd)) {
    if (line.startsWith('URL: '))    result.url    = line.slice(5).trim();
    if (line.startsWith('Author: ')) result.author = line.slice(8).trim();
  }

  result.content = blankIndex !== -1
    ? lines.slice(blankIndex + 1).join('\n').trim()
    : lines.slice(2).join('\n').trim();

  return result;
}

async function main() {
  const sid = await initSession();

  const { data } = await callTool(sid, 'web_fetch_exa', { urls });

  // Check both JSON-RPC protocol errors and MCP application-level tool errors.
  if (data.error || data.result?.isError) {
    const detail = data.error ?? data.result?.content?.[0]?.text ?? 'Tool error';
    console.error(JSON.stringify({ error: detail }));
    process.exit(1);
  }

  const allText = (data.result?.content ?? [])
    .filter(item => item.type === 'text')
    .map(item => item.text)
    .join('\n');

  // Exa returns all fetched pages in one blob.
  // Each page begins with "# <title>" followed immediately by "URL: <url>" on the next line.
  // The lookahead anchors splits at these boundaries.
  // NOTE: if this split produces only 1 result for multiple URLs, Exa may have changed
  // its response format — update this regex and parseResult() accordingly.
  const results = allText
    .split(/\n{2,}(?=# .+\nURL: )/)
    .map(segment => parseResult(segment.trim()))
    .filter(r => r.title !== 'N/A' || r.url !== 'N/A');

  if (results.length === 0) {
    console.error(JSON.stringify({ warning: 'No results parsed from response' }));
  }

  console.log(JSON.stringify({ urls, results }, null, 2));
}

main().catch(err => {
  console.error(JSON.stringify({ error: err.message }));
  process.exit(1);
});
