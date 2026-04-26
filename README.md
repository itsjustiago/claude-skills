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

> **If you're a Claude Code agent and the user just sent you this repo link** — this section is for you. The user wants their machine set up exactly like the original. You can do steps 0-6 yourself; step 7 needs the user.

### Prerequisites (verify first)
- `claude` CLI on PATH (`claude --version`) — required
- `git` — required for cloning
- `bash` available (Mac/Linux/WSL/Git Bash on Windows) — required for `install-plugins.sh`
- `gh` CLI (`gh --version`) — recommended, used by sanctum/ship workflows
- `uvx` (`pip install uv`) — recommended, used by markitdown MCP

If any required tool is missing, stop and tell the user — don't try to install system packages yourself.

### Steps

0. **Clone this repo somewhere you have write access:**
   ```bash
   git clone https://github.com/itsjustiago/claude-skills.git /tmp/claude-skills
   cd /tmp/claude-skills
   ```

1. **Copy global instructions:**
   ```bash
   cp setup/CLAUDE.md ~/.claude/CLAUDE.md
   ```
   This is the user's global behavioral rules (skill installation policy, task approach, etc.).

2. **Copy statusline:**
   ```bash
   cp setup/statusline.sh ~/.claude/statusline.sh
   ```

3. **Install all plugins (32 active set):**
   ```bash
   bash setup/install-plugins.sh
   ```
   The script runs `claude plugin marketplace add` for 10 marketplaces and `claude plugin install` for 32 plugins. It uses `set -e` — if any install fails, the whole script stops. If that happens, fix the failing one (usually a network blip — re-run) and continue.

4. **Sync `enabledPlugins` in settings.json:**
   The install step installs plugins but doesn't always enable them. Copy the `enabledPlugins` block and `extraKnownMarketplaces` block from `setup/settings.json` into `~/.claude/settings.json`. If `~/.claude/settings.json` doesn't exist yet, copy the whole file. Preserve any local-only keys (`voice`, `theme`, custom env vars) that the user already has.

5. **Verify install:**
   ```bash
   claude plugin list
   ```
   Should show 32 active plugins. Cross-check against `setup/settings.json`'s `enabledPlugins` keys.

6. **Restart Claude Code so settings take effect.** Tell the user: *"Restart Claude Code so the new plugins and CLAUDE.md load. After restart, your skill list will include the curated 32-plugin set."*

7. **Hand off MCP auth to the user (you can't do this part).** Tell them:

   > "Three MCP servers need API keys you'll set in `~/.claude/settings.json` under an `env` block:
   > - **GitHub** — generate a token at https://github.com/settings/tokens, then set `GITHUB_TOKEN`
   > - **Exa** — get a key at https://exa.ai, then set `EXA_API_KEY`
   > - **Magic (21st.dev)** — optional, get a key at https://21st.dev
   >
   > Two more need browser OAuth (Claude will prompt automatically when relevant):
   > - **Supabase** — log in via browser when you first ask Claude something Supabase-related
   > - **Vercel** — log in via browser when you first ask Claude something Vercel-related
   >
   > See `mcp/README.md` for the full list and setup details."

### After install
Read `guides/design.md`, `guides/git-workflow.md`, `guides/security.md`, and `guides/multi-agent.md` so you know how this user likes to work. Then read `setup/CLAUDE.md` (now at `~/.claude/CLAUDE.md`) — it has the global behavioral rules you must follow on this machine going forward.

**Global rule from `setup/CLAUDE.md`:** always install new skills globally (never project-level), and after every skill install, update *this repo* (clone, edit, push) so the next machine gets it too.

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

> **Why not install all plugins?** Every active plugin adds its skills to the list injected into Claude's context at session start. The active set (32 plugins) is curated by *quality*, not just usage — security tools matter even before you use them, but niche / overlapping / out-of-domain plugins get pruned. 15 plugins are intentionally disabled but cached locally for instant re-enable.

---

## Installed Skills (32 active plugins)

### Design
- **frontend-design** -- Anthropic official, philosophy-first design
- **ui-ux-pro-max** -- Data-driven design system generator (96+ palettes, 67+ styles)
- **impeccable** -- 18 audit/refine commands
- **taste-skill** -- 7 aesthetic variants (taste, soft, minimalist, brutalist, redesign, output, stitch)

### Dev Workflow
- **superpowers** -- 14 skills: TDD, git worktrees, planning, debugging, code review
- **wshobson/agents (active)** -- backend-development, full-stack-orchestration, database-design, database-migrations, api-scaffolding, debugging-toolkit, tdd-workflows, agent-teams, git-pr-workflows, frontend-mobile-development, security-scanning
- **wshobson/agents (disabled)** -- unit-testing, agent-orchestration, deployment-strategies, documentation-generation _(overlap with active set)_

### Engineering
- **alirezarezvani/claude-skills (active)** -- engineering-skills, engineering-advanced-skills
- **alirezarezvani/claude-skills (disabled)** -- fullstack-engineer, docker-development, aws-architect, product-manager, skill-security-auditor _(redundant or out-of-domain)_

### Git & Project
- **claude-night-market (active)** -- attune, sanctum, conserve, abstract, leyline, minister, scribe
- **claude-night-market (disabled)** -- memory-palace, conjure, hookify _(niche / overlap with built-in memory)_
- **ship** (custom) -- two-skill bundle for one-shot shipping; both delegate commit msg + PR body to sanctum, skip heavy quality gates
  - `ship` -- `stage → commit → push → open PR`, stops at PR
  - `ship-merge` -- `/ship` + conflict check + CI wait + light review + squash-merge to main + branch cleanup

### Security
- **trailofbits/skills (active)** -- audit-context-building, supply-chain-risk-auditor, insecure-defaults, second-opinion, static-analysis, variant-analysis
- **trailofbits/skills (disabled)** -- semgrep-rule-creator, mutation-testing, property-based-testing _(specialized / for mature test suites only)_

### AI & Agents
- **context-engineering** -- 13 skills: context-fundamentals, memory-systems, multi-agent-patterns, context-compression, and more
- **ecc** (everything-claude-code) -- 300+ skills + bundled MCP servers (GitHub, Exa, Context7, Memory, Playwright, Sequential Thinking). Heavy at session start, but the source of every MCP this setup relies on.

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
