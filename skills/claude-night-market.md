# claude-night-market
**Source:** https://github.com/athola/claude-night-market
**Type:** Plugin marketplace
**Install:** `claude plugin marketplace add athola/claude-night-market` then install individual plugins
**Status (2026-05-13):** trimmed active set from 7 → 2. Only `sanctum` + `conserve` are actually used week-to-week; the others (`leyline`, `attune`, `abstract`, `minister`, `scribe`) overlapped with `sanctum` + `superpowers` + the built-in memory system and were paying their session-start cost without earning it.

## Active plugins
- **sanctum** — Full git/PR automation: commits, branch naming, PR descriptions, changelog, versioning
- **conserve** — Token and cost optimization for long sessions

## Installed-but-disabled (flip to true in settings.json to re-enable)
- **attune** — Project lifecycle guide: brainstorm → specify → plan → initialize → execute → war-room _(re-enable when starting a genuinely new project from scratch)_
- **leyline** — Cross-plugin foundations: auth, error patterns, markdown formatting, quota management _(only loaded as a dep by other night-market plugins, which are also off)_
- **abstract** — Shared abstractions used by other night-market plugins _(same — only useful if you re-enable the rest)_
- **minister** — GitHub issues and label taxonomy management _(re-enable when planning issue triage)_
- **scribe** — Quality-controlled documentation with AI quality detection _(re-enable for docs-heavy sessions)_

## Not installed (cached at marketplace level, install on demand)
- **memory-palace** — Knowledge palace for storing decisions _(overlaps with built-in `~/.claude/memory/`)_
- **conjure** — Routes tasks to Gemini/Qwen CLIs for cost savings _(re-enable if you configure those CLIs)_
- **hookify** — Custom hook automation for repeated workflows _(power-user, install case-by-case)_

## How to trigger active skills
- *"sanctum this"* — after finishing a feature, prepares full PR
- conserve auto-activates at the context thresholds defined in its skill

## How to trigger disabled skills (after re-enabling)
- *"let's attune this project"* — at start of new feature/project
- *"minister: create issues for X"* — structured issue creation
- *"scribe the X module"* — write documentation for a module
