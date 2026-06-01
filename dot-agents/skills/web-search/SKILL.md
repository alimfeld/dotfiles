---
name: web-search
description: Web search and page content fetching. Use when you need to find current information, look up documentation, research a topic, or read the full content of specific URLs.
---

# Web Search

Search the web and fetch page content using [Exa AI](https://exa.ai)'s semantic search engine. No API key or account required (at time of writing) — connects directly to Exa's hosted MCP service.

## Setup

No setup required — the scripts use only Node.js built-ins (`node:https`). No `npm install` needed.

## Scripts

Paths are relative to this SKILL.md's directory. Construct absolute paths from the path of this file when running commands.

```bash
node scripts/search.js "<query>" [numResults]    # Search the web (default: 5 results)
node scripts/fetch.js "<url1>" ["<url2>" ...]    # Fetch full page content (batch multiple URLs)
```

## Search Query Tips

Exa uses **semantic search** — it matches the meaning of your query to the ideal page, not just keywords. Write queries as a description of the page you want, not as search keywords.

**Good queries:**
- `"official Next.js App Router documentation for server-side data fetching"`
- `"blog post explaining React Server Components with code examples 2025"`

**Bad queries (keyword-style — avoid):**
- `"Next.js fetch"` — too terse
- `"React RSC"` — abbreviations hurt semantic matching

**Useful modifiers:**
- Year for time-sensitive topics: `"...in 2025"`
- Format hints: `"blog post"`, `"official docs"`, `"GitHub repo"`, `"Stack Overflow answer"`, `"tutorial"`
- Audience hints: `"...for production"`, `"...with code examples"`, `"...step by step"`

**Multiple angles:** For complex topics, run 2–3 searches with varied phrasing rather than one broad query. Each search targets a different facet of the question.

## Research Workflow

1. **Search** — run `search.js` with 5–10 results using a semantically rich query.
2. **Assess highlights** — if a snippet fully answers the question, cite the URL and stop.
3. **Fetch when needed** — batch the 1–3 most promising URLs into one `fetch.js` call.
4. **Synthesize and cite** — always cite source URLs inline; prefer recent or official sources when results conflict.

## Failure Recovery

| Failure | Recovery |
|---|---|
| Empty or irrelevant results | Rephrase query more descriptively; add format or year hints; try a different angle |
| Highlights too thin to answer | Fetch the top 2–3 URLs with `fetch.js` |
| Fetched content sparse or garbled | Try a different URL from the search results |
| Network error / timeout | Scripts retry once automatically; if still failing, wait a moment and rerun the command |
| Results outdated | Add the current year to the query; check `published` fields and prefer recent sources |
| HTTP 4xx / auth error | Exa may have started requiring API authentication; check https://exa.ai for current access policy |
| All results empty after format change | Exa changed its response format; the parsers in `scripts/` will need updating |
