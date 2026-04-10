# MCP Servers

MCP (Model Context Protocol) servers give Claude direct access to external services — databases, deployments, UI generation, etc. These are configured per-machine via browser OAuth or API key.

---

## Installed Servers

### Supabase
**What it does:** Gives Claude direct access to your Supabase projects — query databases, manage tables, handle auth, storage, and edge functions — all without leaving the conversation.

**How to auth:**
1. Open Claude Code
2. Run any Supabase-related prompt (e.g. *"show me my Supabase projects"*)
3. Claude will prompt you to authenticate — click the link and log in via browser
4. Token is saved automatically

**URL:** `https://mcp.supabase.com/mcp`

---

### Vercel
**What it does:** Deploy projects, check deployment status, view build logs, manage domains, and get runtime logs — directly from Claude.

**How to auth:**
1. Open Claude Code
2. Run any Vercel-related prompt (e.g. *"list my Vercel projects"*)
3. Claude will prompt you to authenticate — click the link and log in via browser
4. Token is saved automatically

**URL:** `https://mcp.vercel.com`

---

### Magic (21st.dev)
**What it does:** Generates polished UI components from plain descriptions. Describe what you want, Magic builds it. Integrates with your design system.

**How to auth:**
API key based. Get your key from [21st.dev](https://21st.dev) and set it up:
```bash
claude mcp add magic -- npx -y @21st-dev/magic@latest
# Then set your API key when prompted
```

**Command:** `npx -y @21st-dev/magic@latest`

---

## Notes

- MCP tokens are stored in `~/.claude/.credentials.json` — **never commit this file**
- Tokens expire and will prompt you to re-auth automatically
- MCP servers only activate when relevant to the conversation
