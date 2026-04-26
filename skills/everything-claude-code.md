# everything-claude-code
**Source:** https://github.com/affaan-m/everything-claude-code
**Type:** Plugin (single `ecc` plugin bundling 300+ skills + 6 MCP servers)
**Install:** `claude plugin marketplace add affaan-m/everything-claude-code && claude plugin install ecc@ecc --scope user`

## What it does
Comprehensive skill + MCP bundle. Two distinct value propositions:

1. **MCP servers (auto-installed)** — the main reason this setup uses it. Bundles 6 MCP servers that would otherwise need manual config:
   - **GitHub** — issues, PRs, code search, review comments
   - **Context7** — up-to-date library docs
   - **Exa** — semantic web search
   - **Memory** — persistent knowledge graph
   - **Playwright** — browser automation
   - **Sequential Thinking** — structured reasoning

2. **300+ skills** — patterns, reviewers, testing flows, security checklists, framework guides, ops workflows. Auto-trigger by description match — most you'll never invoke explicitly.

## High-value sub-skill clusters
Out of the 300+, these are the ones most likely to fire in real work:

- **PRP workflow** — `ecc:prp-prd`, `ecc:prp-plan`, `ecc:prp-implement`, `ecc:prp-pr`, `ecc:prp-commit` (PRD → plan → implementation → PR)
- **Stack patterns** — `ecc:python-patterns`, `ecc:typescript-*`, `ecc:django-*`, `ecc:laravel-*`, `ecc:springboot-*`, `ecc:swiftui-patterns`, `ecc:nextjs-turbopack`, `ecc:nuxt4-patterns`
- **Code review** — `ecc:python-review`, `ecc:cpp-review`, `ecc:go-review`, `ecc:rust-review`, `ecc:kotlin-review`, `ecc:flutter-dart-code-review`
- **Testing** — `ecc:tdd-workflow`, `ecc:python-testing`, `ecc:cpp-testing`, `ecc:rust-testing`, `ecc:e2e-testing`
- **Build/verify** — `ecc:cpp-build`, `ecc:rust-build`, `ecc:go-build`, `ecc:gradle-build`, `ecc:flutter-build`, `ecc:springboot-verification`
- **Security** — `ecc:security-review`, `ecc:hipaa-compliance`, `ecc:defi-amm-security`, `ecc:llm-trading-agent-security`
- **Search/research** — `ecc:exa-search`, `ecc:documentation-lookup` (Context7), `ecc:deep-research`, `ecc:research-ops`
- **Sessions** — `ecc:save-session`, `ecc:resume-session`, `ecc:plan`, `ecc:context-budget`

## Trade-off
Heavy at session start (300+ skill descriptions loaded), but you can't reasonably extract just the MCPs without losing the bundled config — they ship together. If you want the MCPs without the skill bloat, configure each MCP server manually in `~/.claude/settings.json` and disable the plugin.
