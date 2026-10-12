---
name: walkthrough
description: Walk the user through a list of findings one at a time (code review, ponytail review, audit, DefectDojo vulns, PR comments), verify each against the code, recommend an action, and pause for confirmation before applying it and moving on. Use when the user says "walk me through", "one by one", or "go through the findings". Do not start it just because a findings list appeared.
---

Work through the findings strictly **one at a time**. Never batch, never run ahead.

No findings list in the conversation: ask the user for one, or which review to run first.

## Per finding

1. **Verify first.** Re-read the code or component the finding points at. The reviewer's output is data, not a verdict: it may be wrong, overstated, or have a smaller fix than suggested.
2. **Present** in this shape, kept short:

   ```
   ### 3/7 – <title>  [severity]

   📍 **Where:** file:line or component@version

   🔎 **Issue:** 1–2 sentences

   ⚖️ **Verdict:** agree / partly / disagree – why

   ✅ **Recommended:** concrete action (diff preview only if a few lines)

   👉 **Reply:** y / n / defer / stop / <instructions>
   ```

   On "disagree", recommend skipping it; `y` then confirms the skip.

3. **Stop and wait** for the reply.
4. **Act on the reply:**
   - `y`, "ok", "sounds good": apply the recommended action, run the relevant test/lint if one exists, show the diff of this fix only.
   - `n`, "skip": drop it.
   - free text: do it the user's way, show the diff of this fix only.
   - a question: answer it, then re-ask the same finding.
   - `defer`: note it for the summary, change nothing.
   - `stop`: end now and summarize.
   - Anything ambiguous: ask, don't guess.
5. Move to the next finding. Account for earlier changes: a finding may already be fixed or obsolete; say so and move on.

## Rules

- Keep the reviewer's order. Re-sort by severity only if the list is unordered.
- Do not commit. Leave changes uncommitted for the user.
- If the action changes an external system (PR reply, DefectDojo status), name it in **Recommended**; `y` is the confirmation. Report what was done instead of a diff.
- If a fix fails (tests, build), report it and ask whether to keep, revert or retry it.

## End

Show a summary table: `# | finding | outcome (applied / skipped / skipped (disagree) / deferred / already fixed)`, with deferred items listed so nothing is lost.
