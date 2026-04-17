# itsjustiago — Claude Code Setup

Everything needed to set up Claude Code exactly the way I have it: skills, plugins, MCP servers, global instructions, statusline, and usage guides. Clone this on any machine and be fully configured in minutes.

---

## What's Inside

| Folder | Contents |
|---|---|
| [`setup/`](setup/) | CLAUDE.md · settings.json · statusline.sh · install script |
| [`skills/`](skills/) | Every installed skill — what it does, sub-skills, how to use it |
| [`mcp/`](mcp/) | MCP servers — GitHub, Context7, Exa, Memory, Playwright, Markitdown, Supabase, Vercel, Magic |
| [`memory/`](memory/) | How Claude's memory system works |
| [`guides/`](guides/) | How to use everything — design, security, git, agents |

---

## Quick Start (New Machine)

```bash
# 1. Copy global instructions
cp setup/CLAUDE.md ~/.claude/CLAUDE.md

# 2. Copy statusline
cp setup/statusline.sh ~/.claude/statusline.sh

# 3. Install all plugins in one shot
bash setup/install-plugins.sh

# 4. Auth MCP servers — see mcp/README.md
```

> Full step-by-step: [setup/install.md](setup/install.md)

---

## Instructions for Claude Code

> If you're Claude Code reading this repo on a new machine — follow this.

**Your job:** Get this machine set up exactly like the original.

1. Copy `setup/CLAUDE.md` → `~/.claude/CLAUDE.md`
2. Copy `setup/statusline.sh` → `~/.claude/statusline.sh`
3. Run `bash setup/install-plugins.sh` to install all plugins globally
4. Tell the user which MCP servers need manual auth (see `mcp/README.md`) — you can't do that part, they need a browser
5. Confirm everything is installed with `claude plugin list`
6. Read `guides/` so you know how the user likes to work

Global rule from `setup/CLAUDE.md`: always install skills globally, never project-level. Always update this repo when a new skill is installed.

---

## How to Use Everything

### Design Workflow

**The pipeline: UI UX Pro Max → Frontend-Design → taste-skill → Impeccable**

**Step 1 — Start a new UI project**
Tell Claude your project type. UI UX Pro Max auto-selects the right design system for your industry.
> *"Build a landing page for a SaaS project management tool"*

**Step 2 — Set the aesthetic**
Pick a taste-skill variant before building:
> *"Use soft-skill aesthetic"* → spacious, premium
> *"Use minimalist-skill aesthetic"* → editorial, clean
> *"Use brutalist-skill aesthetic"* → raw, bold

**Step 3 — Direct the vision (Frontend-Design)**
Claude will pause and ask about tone, purpose, and what makes this different before writing code. Answer honestly — this is what prevents generic AI output.

**Step 4 — Refine with Impeccable**
After any component or page is built, run:
| Command | What it does |
|---|---|
| `/audit` | Full design review — flags all problems |
| `/critique` | Honest feedback on what's weak |
| `/polish` | Fixes spacing, padding, touch targets |
| `/animate` | Adds subtle, intentional motion |
| `/colorize` | Improves color usage |
| `/delight` | Adds small premium details |
| `/typeset` | Improves typography |
| `/bolder` | Makes design more confident |
| `/impeccable` | Runs the full suite |

---

### Security Workflow

**When to use:** Before shipping anything that touches user data, auth, or payments.

```
# Check your dependencies for known vulnerabilities
"Run a supply chain audit on this project"

# Deep code review on a specific module
"Security review the auth module"

# Check for dangerous defaults in config
"Check for insecure defaults in this config"

# Find similar vulnerabilities across the whole codebase
"Run variant analysis on the payment processing code"

# Second opinion before shipping
"Give me a second opinion on the security of this feature"
```

---

### Git & PR Workflow

**Sanctum** handles everything after you finish building:
> *"Sanctum this"* — writes commit message, names the branch, creates PR with full description, updates changelog, bumps version

**Attune** runs at the start of something new:
> *"Let's attune this project"* — walks through brainstorm → specify → plan → execute before touching code

**Minister** organizes GitHub issues:
> *"Minister: create issues for everything we need to build for the auth system"*

---

### Multi-Agent Workflow

Run multiple Claude terminals at once, each with a specific job:

```bash
# Terminal 1
claude  # "You're working on the backend API for the auth system"

# Terminal 2
claude  # "You're building the frontend login UI. The backend agent is handling the API."

# Terminal 3
claude  # "You're writing tests for the auth system"
```

Superpowers + everything-claude-code handle coordination in the background.

---

### Documentation

> *"Scribe the auth module"* — generates quality-controlled docs for any module

---

## Plugin Strategy

> **Why not install all plugins?** Every active plugin adds its skills to the list injected into Claude's context at session start. With 47 plugins enabled, that list consumed ~20k tokens before any work began. The active set (24 plugins) keeps startup lean while covering every real use case.
>
> Disabled plugins stay cached locally -- re-enabling is instant (no re-download). Just add the plugin back to  in .

---

## Installed Skills (24 active plugins)

### Design
- **frontend-design** -- Anthropic official, philosophy-first design
- **ui-ux-pro-max** -- Data-driven design system generator (96+ palettes, 67+ styles)
- **impeccable** -- 18 audit/refine commands
- **taste-skill** -- 7 aesthetic variants (taste, soft, minimalist, brutalist, redesign, output, stitch)

### Dev Workflow
- **superpowers** -- 14 skills: TDD, git worktrees, planning, debugging, code review
- **wshobson/agents (active)** -- backend-development, full-stack-orchestration, database-design, database-migrations, api-scaffolding, debugging-toolkit, tdd-workflows, agent-teams, git-pr-workflows, frontend-mobile-development, security-scanning
- **wshobson/agents (disabled)** -- unit-testing, deployment-strategies, documentation-generation, agent-orchestration

### Engineering
- **alirezarezvani/claude-skills (active)** -- engineering-skills, engineering-advanced-skills
- **alirezarezvani/claude-skills (disabled)** -- fullstack-engineer, docker-development, aws-architect, product-manager, skill-security-auditor

### Git & Project
- **claude-night-market (active)** -- attune, sanctum, conserve, abstract, leyline
- **claude-night-market (disabled)** -- minister, scribe, memory-palace, conjure, hookify

### Security
- **trailofbits/skills (active)** -- audit-context-building
- **trailofbits/skills (disabled)** -- supply-chain-risk-auditor, static-analysis, variant-analysis, semgrep-rule-creator, second-opinion, insecure-defaults, mutation-testing, property-based-testing

### AI & Agents
- **context-engineering** -- 13 skills: context-fundamentals, memory-systems, multi-agent-patterns, context-compression, and more

---

## MCP Servers

| Server | What it unlocks | Auth | Source |
|---|---|---|---|
| **GitHub** | Create issues, PRs, push files, search code, review comments | `GITHUB_TOKEN` env var | ecc plugin (auto) |
| **Context7** | Up-to-date library docs & code examples | None | ecc plugin (auto) |
| **Exa** | AI-powered web search & URL fetching | `EXA_API_KEY` env var | ecc plugin (auto) |
| **Memory** | Persistent knowledge graph across sessions | None | ecc plugin (auto) |
| **Playwright** | Full browser automation, screenshots, E2E tests | None | ecc plugin (auto) |
| **Sequential Thinking** | Structured step-by-step reasoning | None | ecc plugin (auto) |
| **Markitdown** | Convert PDF/Word/Excel/images to Markdown | None (needs `uvx`) | claude-night-market (auto) |
| **Supabase** | Query DB, manage tables, auth, storage, edge functions | OAuth (browser) | Manual |
| **Vercel** | Deploy, logs, domains, project management | OAuth (browser) | Manual |
| **Magic** | UI component generation from plain descriptions | API key | Manual |

See [mcp/README.md](mcp/README.md) for setup and auth details.

---

*Repo: github.com/itsjustiago/claude-skills — updated automatically on every skill install*
