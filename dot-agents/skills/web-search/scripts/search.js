#!/usr/bin/env node
// search.js — Web search via Exa MCP (no API key required)
// Usage: node search.js "<query>" [numResults]

import { initSession, callTool } from './mcp.js';

const query = process.argv[2];
const numResults = parseInt(process.argv[3] ?? '5', 10);

if (!query) {
  console.error(JSON.stringify({ error: 'Usage: node search.js "<query>" [numResults]' }));
  process.exit(1);
}

// Exa's hosted MCP service caps numResults at 20.
if (isNaN(numResults) || numResults < 1 || numResults > 20) {
  console.error(JSON.stringify({ error: 'numResults must be a positive integer no greater than 20' }));
  process.exit(1);
}

function parseResult(text) {
  const result = { title: 'N/A', url: 'N/A', published: 'N/A', author: 'N/A', highlights: '' };
  const highlightLines = [];
  let inHighlights = false;

  for (const line of text.split('\n')) {
    if (line.startsWith('Title: '))         result.title     = line.slice(7).trim();
    else if (line.startsWith('URL: '))       result.url       = line.slice(5).trim();
    else if (line.startsWith('Published: ')) result.published = line.slice(11).trim();
    else if (line.startsWith('Author: '))    result.author    = line.slice(8).trim();
    else if (line === 'Highlights:')         inHighlights = true;
    else if (inHighlights)                   highlightLines.push(line);
  }

  if (highlightLines.length) {
    result.highlights = highlightLines
      .filter(l => l.trim() && l.trim() !== '[...]')
      .join(' ');
  }

  return result;
}

async function main() {
  const sid = await initSession();

  const { data } = await callTool(sid, 'web_search_exa', { query, numResults });

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

  // Exa returns all results in one blob, separated by "---" lines.
  // Allow optional trailing whitespace on separator lines to be lenient about formatting.
  const results = allText
    .split(/\n---[ \t]*\n/)
    .map(segment => parseResult(segment))
    .filter(r => r.title !== 'N/A' || r.url !== 'N/A');

  if (results.length === 0) {
    console.error(JSON.stringify({ warning: 'No results parsed from response' }));
  }

  console.log(JSON.stringify({ query, numResults, results }, null, 2));
}

main().catch(err => {
  console.error(JSON.stringify({ error: err.message }));
  process.exit(1);
});
