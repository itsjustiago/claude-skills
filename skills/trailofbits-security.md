# trailofbits-security
**Source:** https://github.com/trailofbits/skills
**Type:** Plugin marketplace (professional security research firm)
**Install:** `claude plugin marketplace add trailofbits/skills` then install individual plugins

## Active plugins (broadly useful security tooling)
- **audit-context-building** — Builds full context before a security audit
- **supply-chain-risk-auditor** — Scans dependencies for known vulnerabilities (every project has dependencies)
- **insecure-defaults** — Catches fail-open defaults: hardcoded secrets, weak crypto, missing rate limits
- **second-opinion** — External-LLM (OpenAI/Gemini) code review — useful beyond security too
- **static-analysis** — CodeQL/Semgrep wrappers for deep code review
- **variant-analysis** — Finds similar vulnerabilities across the codebase

## Disabled (cached, re-enable for specialized work)
- **semgrep-rule-creator** — Creates custom Semgrep rules _(only needed for authoring custom rules; existing rules cover most cases)_
- **mutation-testing** — Tests your tests by introducing bugs _(only valuable on mature test suites with high coverage)_
- **property-based-testing** — Generates edge case inputs automatically _(educational guidance; overlap with general TDD)_

## When to use
- Before shipping any feature that handles user data, auth, or payments
- *"Run a supply chain audit"* — checks all dependencies
- *"Security review the auth module"* — deep code review
- *"Check for insecure defaults in this config"*
