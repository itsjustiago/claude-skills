# everything-claude-code
**Source:** https://github.com/affaan-m/everything-claude-code
**Type:** Plugin (built at Claude Code Hackathon, Feb 2026)
**Install:** `claude plugin marketplace add affaan-m/everything-claude-code && claude plugin install ecc@ecc --scope user`

## What it does
Multi-agent orchestration layer. Handles coordination between multiple Claude instances, performance profiling for long sessions, and memory management so Claude doesn't lose context over extended work.

## Sub-skills
- **ecc** — Main orchestration skill, activates automatically during multi-agent and long sessions

## When it matters
- Running multiple Claude terminals in parallel
- Long sessions (1+ hours) where context starts degrading
- Complex tasks split across multiple agents
