# MCP Servers

MCP (Model Context Protocol) servers give Claude direct access to external services — databases, deployments, UI generation, etc. These are configured per-machine via browser OAuth or API key.

Servers marked **auto** are installed automatically via plugins — no manual setup needed beyond auth.

---

## Installed Servers

### GitHub *(auto via ecc)*
**What it does:** Read and write to GitHub — create issues, open PRs, push files, search code, comment on reviews — all from within the conversation.

**How to auth:**
Requires a `GITHUB_TOKEN` environment variable.
1. Go to [github.com/settings/tokens](https://github.com/settings/tokens) and generate a Personal Access Token
2. Add it to `~/.claude/settings.json` under `env`:
```json
"env": {
  "GITHUB_TOKEN": "ghp_yourtoken"
}
```

**Source:** `@modelcontextprotocol/server-github` (via ecc plugin)

---

### Context7 *(auto via ecc)*
**What it does:** Fetches up-to-date documentation and code examples for any library or framework — so Claude always has current API references instead of stale training data.

**How to auth:** No auth required.

**Source:** `@upstash/context7-mcp` (via ecc plugin)

---

### Exa *(auto via ecc)*
**What it does:** AI-powered web search — semantic search, research, URL fetching. Much better than keyword search for technical queries.

**How to auth:**
Requires an `EXA_API_KEY`. Get one at [exa.ai](https://exa.ai) and add it to `~/.claude/settings.json`:
```json
"env": {
  "EXA_API_KEY": "your_key"
}
```

**URL:** `https://mcp.exa.ai/mcp` (via ecc plugin)

---

### Memory *(auto via ecc)*
**What it does:** Persistent knowledge graph memory — Claude can store and recall entities, relationships, and observations across sessions.

**How to auth:** No auth required.

**Source:** `@modelcontextprotocol/server-memory` (via ecc plugin)

---

### Playwright *(auto via ecc)*
**What it does:** Full browser automation — Claude can navigate pages, click, fill forms, take screenshots, and run end-to-end tests.

**How to auth:** No auth required.

**Source:** `@playwright/mcp` (via ecc plugin)

---

### Sequential Thinking *(auto via ecc)*
**What it does:** Structured step-by-step reasoning tool — helps Claude break down complex problems into explicit thought chains before responding.

**How to auth:** No auth required.

**Source:** `@modelcontextprotocol/server-sequential-thinking` (via ecc plugin)

---

### Markitdown *(auto via claude-night-market)*
**What it does:** Converts any file (PDF, Word, Excel, PowerPoint, images) to Markdown — so Claude can read and work with them.

**How to auth:** No auth required. Requires `uvx` (install via `pip install uv`).

**Source:** `uvx markitdown-mcp` (via claude-night-market plugin)

---

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
- Servers marked **auto** are installed when you run `install-plugins.sh` — you only need to handle auth
