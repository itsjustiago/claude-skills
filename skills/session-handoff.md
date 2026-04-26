# session-handoff
**Source:** Custom (this repo)
**Type:** Standalone skill (manually installed to `~/.claude/skills/`)
**Install:**
- Copy `skills/session-handoff/SKILL.md` → `~/.claude/skills/session-handoff/SKILL.md`

## What it does
End-of-session handoff so you can `/clear` without losing context. Produces a structured chat-only summary covering decisions, shipped changes, key files (absolute paths), background processes (with shell IDs + kill commands), verification commands, and open questions. The next fresh agent can resume from the summary alone.

This is a **context-handoff artifact**, not a status report. The audience is the next instance of Claude, not a stakeholder.

## Trigger phrases
> *"session handoff"* · *"wrap up session"* · *"hand off"* · *"handoff summary"* · *"let's wrap up"* · *"summarize before I clear"*

Also fires proactively if the user says they're about to `/clear`.

## Output structure (fixed template)

```
# Session Handoff — <title>

## Where it started
## Decisions locked + what shipped
## Key files for next session
## Running state
## Verification — how to confirm things still work
## Deferred + open questions
## Pick up here
```

Every section appears every time. Empty sections write `none` instead of being omitted — structure stability is the point.

## Hard rules
- **Chat-only output.** Never writes a file, never updates memory.
- **Absolute paths only** in "Key files" — the next agent may have a different cwd.
- **Plan file goes first** in "Key files" if a plan drove the session.
- **Shell IDs are load-bearing.** Any `run_in_background` shells must appear in "Running state" with the kill command, or the next agent can't find them.
- **No retro / no hype.** Terse and concrete.

## When to use vs. alternatives
| Need | Use |
|---|---|
| End the session and clear context cleanly | `session-handoff` |
| Save a checkpoint mid-session to disk | `ecc:save-session` |
| Resume a saved session later | `ecc:resume-session` |
| Just trim context without ceremony | `/clear` directly |

## Workflow
1. Say *"session handoff"* (or any trigger phrase) at the end of the session.
2. Claude prints the summary in chat.
3. Run `/clear`.
4. Start a fresh session and paste the summary back, or refer to it via the listed plan/memory paths. Continue work.
