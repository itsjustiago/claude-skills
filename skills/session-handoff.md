# session-handoff
**Source:** Custom (this repo)
**Type:** Standalone skill (manually installed to `~/.claude/skills/`)
**Install:**
- Copy `skills/session-handoff/SKILL.md` -> `~/.claude/skills/session-handoff/SKILL.md`

## What it does
End-of-session handoff so you can `/clear` without losing context. Produces a structured chat-only summary covering decisions, shipped changes, key files (absolute paths), background processes (with shell IDs + kill commands), verification commands, dead-ends already tried, tone reminders for the next agent, and explicit first-action steps. The next fresh agent can resume from the summary alone.

The output is wrapped in a single fenced markdown block with explicit `>>> COPY EVERYTHING IN THIS BLOCK <<<` and `>>> END OF HANDOFF <<<` markers, so:
- The chat UI shows a one-click copy button on the block, and
- Even if you select manually, the markers remove all ambiguity about what to grab.

This is a **context-handoff artifact**, not a status report. The audience is the next instance of Claude, not a stakeholder.

## Trigger phrases
> *"session handoff"* * *"wrap up session"* * *"hand off"* * *"handoff summary"* * *"let's wrap up"* * *"summarize before I clear"*

Also fires proactively if the user says they're about to `/clear`.

## Output structure (fixed template)

The entire output is one fenced block, nothing before or after it:

```
>>> COPY EVERYTHING IN THIS BLOCK -- PASTE INTO YOUR NEW CLAUDE SESSION AFTER /clear <<<

# Session Handoff -- <title>

## For the next Claude (read this first)
## Where it started
## Why this matters
## Tone for this user
## Decisions locked + what shipped
## Key files for next session
## Running state
## Verification -- how to confirm things still work
## Tried and didn't work (dead-ends to skip)
## Deferred + open questions
## First action (do these in order)

>>> END OF HANDOFF <<<
```

Every section appears every time. Empty sections write `none` instead of being omitted -- structure stability is the point.

## Hard rules
- **Single fenced code block, nothing else.** No preamble like "Here's your handoff:". No closing remarks. The user copies the block; anything outside it is friction.
- **Both copy markers are mandatory and verbatim** -- top and bottom.
- **Chat-only output.** Never writes a file, never updates memory.
- **Absolute paths only** in "Key files" -- the next agent may have a different cwd.
- **Plan file goes first** in "Key files" if a plan drove the session.
- **Shell IDs are load-bearing.** Any `run_in_background` shells must appear in "Running state" with the kill command, or the next agent can't find them.
- **No retro / no hype.** Terse and concrete.
- **"First action" is three numbered steps minimum** -- read which file, run which command, ask which question.

## When to use vs. alternatives
| Need | Use |
|---|---|
| End the session and clear context cleanly | `session-handoff` |
| Save a checkpoint mid-session to disk | `ecc:save-session` |
| Resume a saved session later | `ecc:resume-session` |
| Just trim context without ceremony | `/clear` directly |

## Workflow
1. Say *"session handoff"* (or any trigger phrase) at the end of the session.
2. Claude prints the fenced handoff block in chat -- nothing else.
3. Click the copy button on the block (or select between the `>>>` markers manually).
4. Run `/clear`.
5. Paste the block into the fresh session as your first message. The new agent reads "First action" and picks up where the last one left off.
