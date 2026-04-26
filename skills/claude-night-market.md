# claude-night-market
**Source:** https://github.com/athola/claude-night-market
**Type:** Plugin marketplace
**Install:** `claude plugin marketplace add athola/claude-night-market` then install individual plugins

## Active plugins
- **attune** — Project lifecycle guide: brainstorm → specify → plan → initialize → execute → war-room
- **sanctum** — Full git/PR automation: commits, branch naming, PR descriptions, changelog, versioning
- **leyline** — Cross-plugin foundations: auth, error patterns, markdown formatting, quota management
- **conserve** — Token and cost optimization for long sessions
- **abstract** — Shared abstractions used by other night-market plugins
- **minister** — GitHub issues and label taxonomy management
- **scribe** — Quality-controlled documentation with AI quality detection

## Disabled (cached, re-enable per project)
- **memory-palace** — Knowledge palace for storing decisions _(overlaps with built-in `~/.claude/memory/`)_
- **conjure** — Routes tasks to Gemini/Qwen CLIs for cost savings _(re-enable if you configure those CLIs)_
- **hookify** — Custom hook automation for repeated workflows _(power-user, install case-by-case)_

## How to trigger manual skills
- *"sanctum this"* — after finishing a feature, prepares full PR
- *"let's attune this project"* — at start of new feature/project
- *"minister: create issues for X"* — structured issue creation
- *"scribe the X module"* — write documentation for a module
