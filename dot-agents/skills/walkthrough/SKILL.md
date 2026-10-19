---
name: walkthrough
description: Walk the user through a list of items (review findings, vulns, PR comments, open questions, TODOs) one at a time, verifying each and recommending an action or answer before applying it. Use when the user says "walk me through", "one by one", or "go through the findings/questions". Do not start it just because a list appeared.
---

Handle items strictly **one at a time**, in the list's order. No list in the conversation: ask for one.

## Per item

1. **Verify.** Re-read the code, docs or earlier answers it touches. The list may be wrong, already resolved, or have a smaller fix than suggested; if resolved, say so and move on.
2. **Present**, short, omitting lines that don't apply:

   ```
   ### 3/7 – <title or question>  [severity, if any]

   📍 **Where:** file:line or component@version

   🔎 **Context:** the issue, or why the question matters

   ⚖️ **Assessment:** agree / partly / disagree – why; or the options

   ✅ **Recommended:** action or answer; "skip" if you disagree; name any external change (small diff preview ok)

   👉 **Reply:** y / n / defer / stop / <instructions>
   ```

3. **Wait** for the reply, then:
   - `y` / free text: do it (the user's way if given). Code change: run relevant tests/lint, show this change's diff. External change (PR reply, ticket status): report what was done. Pure decision: just record it.
   - `n`: skip. `defer`: note it, change nothing. `stop`: summarize now.
   - a question: answer, then re-ask. Ambiguous: ask, don't guess.
   - A failed fix: report it, ask keep / revert / retry.

Never commit.

## End

Summary table `# | item | outcome` (applied / decided: … / skipped / deferred / already resolved), deferred items called out.
