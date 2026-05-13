# wshobson-agents
**Source:** https://github.com/wshobson/agents
**Type:** Plugin marketplace (70+ plugins, installed 15 core ones)
**Install:** `claude plugin marketplace add wshobson/agents` then install individual plugins
**Status (2026-05-13):** all 11 installed plugins are currently **disabled** in `enabledPlugins`. They duplicate coverage already provided by `impeccable` + `sanctum` + `trailofbits`, and being inactive shaves a chunk off the session-start pause. Flip any to `true` in `~/.claude/settings.json` per-project.

## Installed-but-disabled (flip to re-enable)
- **backend-development** — Backend architecture, server design, service layers
- **full-stack-orchestration** — Coordinates frontend + backend work together
- **frontend-mobile-development** — React Native, Flutter, mobile-first patterns
- **database-design** — Schema design, ERD analysis, indexing strategy
- **database-migrations** — Safe migration planning and execution
- **api-scaffolding** — REST/GraphQL API generation with proper contracts
- **git-pr-workflows** — Git branching strategy, PR templates, review flows _(use `sanctum` instead)_
- **debugging-toolkit** — Systematic debugging with root cause analysis
- **tdd-workflows** — Full test-driven development flow _(superpowers already covers TDD)_
- **security-scanning** — Code-level security review _(trailofbits set covers this)_
- **agent-teams** — Multi-agent team coordination

## Not installed (cached at marketplace level, install on demand)
- **unit-testing** — Unit test generation _(overlaps with `tdd-workflows`)_
- **agent-orchestration** — Multi-agent task delegation _(overlaps with `agent-teams` + `conserve`)_
- **deployment-strategies** — Docker, CI/CD, cloud deployment _(re-enable when shipping infrastructure)_
- **documentation-generation** — Auto-generated docs _(`scribe` covers this with better quality control)_
