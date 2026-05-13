# itsjustiago — Claude Code Setup

Everything needed to set up Claude Code exactly the way I have it: skills, plugins, MCP servers, global instructions, statusline, and usage guides. Clone this on any machine and be fully configured in minutes.

---

## What's Inside

| Folder | Contents |
|---|---|
| [`setup/`](setup/) | CLAUDE.md · settings.json · statusline.sh · install script |
| [`skills/`](skills/) | Every installed skill — what it does, sub-skills, how to use it |
| [`mcp/`](mcp/) | MCP servers — GitHub, Context7, Exa, Memory, Playwright, Markitdown, Supabase, Vercel, Magic, Higgsfield |
| [`memory/`](memory/) | How Claude's memory system works |
| [`guides/`](guides/) | How to use everything — design, security, git, agents |

---

## Architecture (2026-05)

This repo bootstraps a **lean global Claude Code setup** that pairs with a separate per-project skill catalog:

| Repo | Purpose |
|---|---|
| **`claude-skills`** (this repo) | Bootstrap a new machine — installs ~5 core plugins, copies global configs, sets up MCP auth |
| **[`skillsbase`](https://github.com/itsjustiago/skillsbase)** | Per-project skill catalog (~60 curated skills) — installed selectively by the `skill-matchmaker` skill when you open a project |

Why split: skills loaded globally are eager (consume tokens on every session). Keeping global tiny + pulling per-project skills on demand cuts startup from ~75k to ~15k tokens, with no loss of capability.

The 5 plugins kept globally are: **superpowers** (brainstorm/TDD/debug/plans/git), **sanctum** (PRs), **conserve** (context optimization), **impeccable** (design polish), **watch** (video).

---

## Quick Start (New Machine)

```bash
# 1. Clone this repo
git clone https://github.com/itsjustiago/claude-skills.git
cd claude-skills

# 2. Install core plugins + skill-matchmaker + /skills-suggest
bash setup/install-plugins.sh

# 3. Copy global configs
cp setup/CLAUDE.md ~/.claude/CLAUDE.md
cp setup/settings.json ~/.claude/settings.json
cp setup/statusline.sh ~/.claude/statusline.sh

# 4. Auth MCP servers — see mcp/README.md

# 5. (Optional but recommended) Install extras: design MCPs, graphify, browser-harness
#    See setup/install-extras.md — runs each command separately so you can pick what you want

# 6. Open any project and run /skills-suggest
#    The skill-matchmaker reads your package.json/Cargo.toml/etc,
#    proposes relevant skills from skillsbase, installs into
#    <project>/.claude/skills/. Restart Claude after install.
```

> Full step-by-step: [setup/install.md](setup/install.md)  
> Extras (design MCPs, graphify, browser-harness): [setup/install-extras.md](setup/install-extras.md)

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

3. **Install core plugins + skill-matchmaker (5 plugins, 1 user skill, 1 slash command):**
   ```bash
   bash setup/install-plugins.sh
   ```
   The script runs `claude plugin marketplace add` for 4 marketplaces and `claude plugin install` for 5 core plugins (superpowers, sanctum, conserve, impeccable, watch). It also downloads the `skill-matchmaker` SKILL.md and `/skills-suggest` slash command from the skillsbase repo into `~/.claude/skills/` and `~/.claude/commands/`. If a download fails (offline / network), re-run the script.

4. **Copy `settings.json`:**
   ```bash
   cp setup/settings.json ~/.claude/settings.json
   ```
   This sets `enabledPlugins` to the 5-core set. If `~/.claude/settings.json` already exists with local-only keys (`voice`, `theme`, custom env vars), merge by hand — the `enabledPlugins` and `extraKnownMarketplaces` blocks from `setup/settings.json` are what matters.

5. **Verify install:**
   ```bash
   claude plugin list
   ```
   Should show 5 installed plugins, all active. Cross-check against `setup/settings.json`.

6. **Restart Claude Code so settings take effect.** Tell the user: *"Restart Claude Code. After restart your global skill list will be small. In any new project, run `/skills-suggest` and the matchmaker will propose project-relevant skills from the [skillsbase catalog](https://github.com/itsjustiago/skillsbase) — install, restart once, and that project has them permanently in `.claude/skills/`."*

7. **Hand off MCP auth to the user (you can't do this part).** Tell them:

   > "Three MCP servers need API keys you'll set in `~/.claude/settings.json` under an `env` block:
   > - **GitHub** — generate a token at https://github.com/settings/tokens, then set `GITHUB_TOKEN`
   > - **Exa** — get a key at https://exa.ai, then set `EXA_API_KEY`
   > - **Magic (21st.dev)** — optional, get a key at https://21st.dev
   >
   > Three more need browser OAuth (Claude will prompt automatically when relevant, or trigger via `/mcp`):
   > - **Supabase** — log in via browser when you first ask Claude something Supabase-related
   > - **Vercel** — log in via browser when you first ask Claude something Vercel-related
   > - **Higgsfield** — add with `claude mcp add --transport http --scope user higgsfield https://mcp.higgsfield.ai/mcp`, then run `/mcp` to authenticate
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

> *Note:* **attune** (brainstorm → specify → plan → execute) and **minister** (GitHub issue triage) are installed-but-disabled in the current curated set — flip them to `true` in `setup/settings.json` if you want to use them on a project.

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

> **Why not enable all installed plugins?** Every active plugin injects its skill list into Claude's context at session start — adding latency and burning tokens before you've even typed. The active set is curated for **what gets used week-to-week**, not what's nice to have on paper. 16 plugins are installed-but-disabled (one flag flip away from re-enabling) and 15 more from the same marketplaces are not installed at all (niche / overlapping). Together: 33 installed, 17 active, 16 dormant.

**Pruning rationale (2026-05-13):** the wshobson workflow bundle (backend/db/api/tdd/security/agent-teams) duplicated capabilities already covered by `impeccable` + `sanctum` + `trailofbits`, and the night-market extras (leyline, attune, abstract, minister, scribe) overlapped with sanctum + superpowers. Disabling them shaved a noticeable chunk off the session-start pause without losing any actually-used workflow.

---

## Installed Skills (17 active plugins)

### Design
- **frontend-design** -- Anthropic official, philosophy-first design
- **ui-ux-pro-max** -- Data-driven design system generator (96+ palettes, 67+ styles)
- **impeccable** -- 18 audit/refine commands
- **taste-skill** -- 7 aesthetic variants (taste, soft, minimalist, brutalist, redesign, output, stitch)
- **open-design** -- 74-skill bundle (web/mobile/decks/docs/posters/critique) sourced from [nexu-io/open-design](https://github.com/nexu-io/open-design). Pair with taste-skill aesthetic. See [skills/open-design.md](skills/open-design.md).

### Dev Workflow
- **superpowers** -- 14 skills: TDD, git worktrees, planning, debugging, code review
- **session-handoff** (custom) -- end-of-session handoff in a single fenced block with explicit `>>> COPY <<<` / `>>> END <<<` markers (one-click copy in chat UI). Covers decisions, key files, running shells, dead-ends tried, tone reminders, and a numbered first-action list so a fresh agent resumes cleanly after `/clear`. Triggers on *"session handoff"*, *"wrap up session"*, *"summarize before I clear"*.
- **wshobson/agents (installed-but-disabled)** -- backend-development, full-stack-orchestration, database-design, database-migrations, api-scaffolding, git-pr-workflows, debugging-toolkit, tdd-workflows, security-scanning, agent-teams, frontend-mobile-development _(duplicated impeccable + sanctum + trailofbits coverage; re-enable per-project if needed)_
- **wshobson/agents (not installed)** -- unit-testing, agent-orchestration, deployment-strategies, documentation-generation

### Engineering
- **alirezarezvani/claude-skills (active)** -- engineering-skills, engineering-advanced-skills
- **alirezarezvani/claude-skills (not installed)** -- fullstack-engineer, docker-development, aws-architect, product-manager, skill-security-auditor _(redundant or out-of-domain)_

### Git & Project
- **claude-night-market (active)** -- sanctum, conserve
- **claude-night-market (installed-but-disabled)** -- leyline, attune, abstract, minister, scribe _(duplicated sanctum + superpowers; re-enable for issue triage / docs generation if needed)_
- **claude-night-market (not installed)** -- memory-palace, conjure, hookify
- **ship** (custom) -- two-skill bundle for one-shot shipping; both delegate commit msg + PR body to sanctum, skip heavy quality gates
  - `ship` -- `stage → commit → push → open PR`, stops at PR
  - `ship-merge` -- `/ship` + conflict check + CI wait + light review + squash-merge to main + branch cleanup

### Security
- **trailofbits/skills (active)** -- audit-context-building, supply-chain-risk-auditor, insecure-defaults, second-opinion, static-analysis, variant-analysis
- **trailofbits/skills (not installed)** -- semgrep-rule-creator, mutation-testing, property-based-testing _(specialized / for mature test suites only)_

### AI & Agents
- **context-engineering** -- 13 skills: context-fundamentals, memory-systems, multi-agent-patterns, context-compression, and more
- **ecc** (everything-claude-code) -- 300+ skills + bundled MCP servers (GitHub, Exa, Context7, Memory, Playwright, Sequential Thinking). Heavy at session start, but the source of every MCP this setup relies on.

### Media
- **claude-video** (`/watch`) -- give Claude a video input. Paste a URL (yt-dlp supports YouTube, TikTok, Loom, X, Instagram, Vimeo, +hundreds) or local path; it downloads with yt-dlp, extracts frames with ffmpeg, transcribes via captions or Whisper, and `Read`s every frame as an image. `--start`/`--end` for focused passes on long videos.

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
| **Higgsfield** | AI image + video generation, character consistency, virality predictor | OAuth (browser) | Manual |

See [mcp/README.md](mcp/README.md) for setup and auth details.

---

*Repo: github.com/itsjustiago/claude-skills — updated automatically on every skill install*
