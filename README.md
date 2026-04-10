# Claude Code Setup — itsjustiago

My complete Claude Code configuration: skills, plugins, MCP servers, global instructions, and statusline. Drop this on any new machine and be fully set up in minutes.

---

## Quick Setup (New Computer)

See **[setup/install.md](setup/install.md)** for the full step-by-step guide.

TL;DR:
```bash
# 1. Install Claude Code
npm install -g @anthropic-ai/claude-code

# 2. Copy config files
cp setup/CLAUDE.md ~/.claude/CLAUDE.md
cp setup/statusline.sh ~/.claude/statusline.sh

# 3. Install all plugins (paste into terminal)
bash setup/install-plugins.sh

# 4. Auth MCP servers (requires browser login)
# See mcp/README.md
```

---

## What's In Here

| Section | What it covers |
|---|---|
| [setup/](setup/) | CLAUDE.md, settings, statusline, install script |
| [mcp/](mcp/) | MCP servers — what they are and how to auth |
| [skills/](skills/) | Every installed skill/plugin, detailed |
| [memory/](memory/) | How Claude's memory system works |

---

## Skills & Plugins

### Design
| Plugin | Sub-skills | Source |
|---|---|---|
| **frontend-design** | 1 | [anthropics/claude-code](https://github.com/anthropics/claude-code) |
| **ui-ux-pro-max** | 1 | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |
| **impeccable** | 18 | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) |
| **taste-skill** | 7 variants | [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) |

### Dev Workflow
| Plugin | Sub-skills | Source |
|---|---|---|
| **superpowers** | 14 | [obra/superpowers](https://github.com/obra/superpowers) |
| **backend-development** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **full-stack-orchestration** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **database-design** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **database-migrations** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **api-scaffolding** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **debugging-toolkit** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **unit-testing** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **tdd-workflows** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **deployment-strategies** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **documentation-generation** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **agent-orchestration** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **agent-teams** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **git-pr-workflows** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **frontend-mobile-development** | — | [wshobson/agents](https://github.com/wshobson/agents) |
| **fullstack-engineer** | — | [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) |
| **engineering-skills** | — | [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) |
| **engineering-advanced-skills** | — | [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) |
| **docker-development** | — | [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) |
| **aws-architect** | — | [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) |

### Git & Project Management
| Plugin | What it does | Source |
|---|---|---|
| **sanctum** | Full PR lifecycle automation | [claude-night-market](https://github.com/athola/claude-night-market) |
| **attune** | Project lifecycle guide | [claude-night-market](https://github.com/athola/claude-night-market) |
| **minister** | GitHub issues & label management | [claude-night-market](https://github.com/athola/claude-night-market) |
| **scribe** | Quality-controlled documentation | [claude-night-market](https://github.com/athola/claude-night-market) |
| **memory-palace** | Knowledge & decision history | [claude-night-market](https://github.com/athola/claude-night-market) |
| **hookify** | Custom hook automation | [claude-night-market](https://github.com/athola/claude-night-market) |

### Security
| Plugin | What it does | Source |
|---|---|---|
| **supply-chain-risk-auditor** | Scans dependencies for vulnerabilities | [trailofbits/skills](https://github.com/trailofbits/skills) |
| **static-analysis** | Deep static code analysis | [trailofbits/skills](https://github.com/trailofbits/skills) |
| **variant-analysis** | Finds similar vulns across codebase | [trailofbits/skills](https://github.com/trailofbits/skills) |
| **second-opinion** | Secondary security review | [trailofbits/skills](https://github.com/trailofbits/skills) |
| **insecure-defaults** | Catches dangerous default configs | [trailofbits/skills](https://github.com/trailofbits/skills) |
| **mutation-testing** | Tests your tests for completeness | [trailofbits/skills](https://github.com/trailofbits/skills) |
| **property-based-testing** | Auto-generates edge case inputs | [trailofbits/skills](https://github.com/trailofbits/skills) |
| **semgrep-rule-creator** | Custom security rules for your codebase | [trailofbits/skills](https://github.com/trailofbits/skills) |
| **skill-security-auditor** | Code security audit | [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) |
| **security-scanning** | Code-level security review | [wshobson/agents](https://github.com/wshobson/agents) |

### AI & Agents
| Plugin | What it does | Source |
|---|---|---|
| **context-engineering** | 13 context/memory/multi-agent skills | [muratcankoylan/Agent-Skills-for-Context-Engineering](https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering) |
| **ecc** | Multi-agent orchestration & memory mgmt | [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) |
| **conjure** | Routes tasks to cheaper external LLMs | [claude-night-market](https://github.com/athola/claude-night-market) |
| **conserve** | Token & cost optimization | [claude-night-market](https://github.com/athola/claude-night-market) |

### Product
| Plugin | What it does | Source |
|---|---|---|
| **product-manager** | Product thinking, PRDs, prioritization | [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) |

---

## MCP Servers

| Server | What it does | Auth |
|---|---|---|
| **Supabase** | Database, auth, storage, edge functions | OAuth — `mcp.supabase.com` |
| **Vercel** | Deploy, manage projects, logs, domains | OAuth — `mcp.vercel.com` |
| **Magic (21st.dev)** | UI component generation from descriptions | API key |

See [mcp/README.md](mcp/README.md) for setup instructions.

---

## Global Instructions (CLAUDE.md)

See [setup/CLAUDE.md](setup/CLAUDE.md) — loaded automatically in every conversation.

Current rules:
- Always install skills globally, not project-level
- Group bundled sub-skills under parent name
- Update this repo on every skill install

---

## Statusline

Custom statusline with progress bars for context window, rate limits, and turn count.

See [setup/statusline.sh](setup/statusline.sh) — shows:
- Model name
- Context window usage (color-coded bar: green → yellow → red)
- 5-hour rate limit usage + countdown to reset
- Conversation turn count

---

*Last updated: 2026-04-11*
