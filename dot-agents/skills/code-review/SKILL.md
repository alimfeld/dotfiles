---
name: code-review
description: Review code using standard lenses (design, functionality, complexity, tests, naming, comments, security, performance, error handling, maintainability). Use when the user asks for a code review, PR review, or wants feedback on code quality.
---

# Code Review

Review code systematically using 10 universally accepted lenses drawn from:

- [Google Engineering Practices — What to look for in a code review](https://google.github.io/eng-practices/review/reviewer/looking-for.html)
- Robert C. Martin, *Clean Code* (2008)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/) (for the Security lens)
- Martin Fowler, *Refactoring* (2018) (for the Complexity and Maintainability lenses) Produce structured, actionable findings with severity tags, followed by a summary and top priorities.

## Step 1 — Clarify Scope

If the user has not specified what to review, ask:

> "What would you like me to review — the whole codebase, specific files or directories, or a git diff / PR?"

Proceed immediately when the scope is clear from context.

## Step 2 — Orient (for codebase and module scope)

Before applying the lenses, do a lightweight orientation pass:

- Read the README and any top-level docs
- Survey the directory structure
- Identify entry points, key modules, and architectural boundaries
- Note the primary language(s) and any frameworks in use

Skip this step for git diff / PR reviews — go straight to the changed files.

## Step 3 — Detect Language(s)

Identify the primary language(s) and frameworks in scope. Apply language-specific idioms and conventions when reviewing — e.g.:

- **Go**: error handling conventions, interface design, goroutine safety
- **Python**: Pythonic style, type hints, exception handling
- **TypeScript/JavaScript**: type safety, async patterns, module boundaries
- **Rust**: ownership, lifetimes, `unwrap` usage
- **Java/Kotlin**: OOP design, checked exceptions, null safety
- Adapt similarly for any other language encountered

## Step 4 — Apply the 10 Lenses

Review the code in scope through each lens. Not every lens will yield findings — omit a section if there is nothing to report.

### Severity Tags

- 🔴 **Critical** — bug, security vulnerability, or serious design flaw; must be fixed
- 🟡 **Suggestion** — meaningful improvement worth making; should be addressed
- ⚪ **Nit** — minor style, naming, or polish issue; optional but good practice. Nit is for minor issues only — use the Highlights section for positive observations.

---

### 1. Design
Is the code well-structured? Does it fit the existing architecture? Are responsibilities clearly separated? Are abstractions at the right level? (Apply SOLID principles where relevant.)

### 2. Functionality
Does the code do what it is supposed to do? Are edge cases, boundary conditions, and unexpected inputs handled? Is the logic correct?

### 3. Complexity
Is the code unnecessarily complex? Could it be simpler without losing clarity? Are functions/methods doing too much? Is there over-engineering or premature abstraction?

### 4. Tests
Are there adequate tests? Do tests cover the important cases, including edge cases? Are the tests meaningful and not just testing implementation details? Is testability considered in the design?

### 5. Naming
Are names — variables, functions, classes, files — clear, precise, and consistent? Do names reflect intent rather than implementation?

### 6. Comments
Are comments present where needed and absent where the code is self-explanatory? Are comments accurate and up to date? Is there missing documentation for public APIs?

### 7. Security
Are there injection vulnerabilities, authentication/authorization gaps, trust-boundary violations, sensitive data exposures, or insecure defaults? Apply OWASP Top 10 as a mental checklist where relevant.

### 8. Performance
Are there obvious inefficiencies — N+1 queries, unnecessary allocations, blocking I/O on hot paths, missing indexes, unbounded loops? Flag only clear issues, not micro-optimisations.

### 9. Error Handling
Are errors caught, surfaced, and recovered from gracefully? Are error messages informative? Are failures silent where they should be loud? Is resource cleanup (files, connections) handled correctly?

### 10. Maintainability
Will this code be easy to change safely in the future? Is there duplication that would need to be updated in multiple places? Are there magic numbers, hardcoded values, or tight coupling that will cause friction?

---

## Step 5 — Report Findings

Structure the output as follows:

```
## Code Review — <scope description>
**Language(s):** <detected languages and frameworks>

### 1. Design
- 🔴 ...
- 🟡 ...

### 2. Functionality
- 🟡 ...

[... only include lenses with findings ...]

---
## Highlights
- ✅ ...
- ✅ ...

## Summary
<2–4 sentence synthesis of the overall code quality and the main themes across findings>

## Top Priorities
1. <most important thing to fix, with brief rationale>
2. <second most important>
3. <third most important>
```

Keep findings concise and specific — reference file names and line numbers where possible. Prefer actionable language ("Extract X into Y" over "X is bad").
