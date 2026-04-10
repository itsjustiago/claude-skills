# Multi-Agent Workflow Guide

## What it is
Running multiple Claude Code instances in parallel, each with a specific job. Instead of one Claude doing everything sequentially, you split the work.

## Basic setup

Open multiple terminals:
```bash
# Terminal 1 — backend
claude
# Tell it: "Build the backend API for the auth system. The frontend agent is working in parallel."

# Terminal 2 — frontend
claude
# Tell it: "Build the login/signup UI. The backend agent is handling the API — coordinate endpoints."

# Terminal 3 — tests
claude
# Tell it: "Write tests for the auth system as the other agents build it."
```

## With git worktrees (recommended)
Each agent gets its own isolated branch — no conflicts:
> *"Set up git worktrees for this task"* — Superpowers handles it

## Coordination
- **everything-claude-code (ecc)** — manages shared context between agents
- **agent-orchestration** — coordinates task delegation
- **agent-teams** — multi-agent team patterns

## When to use it
- Large features that have clearly separable parts (backend + frontend + tests)
- Long tasks where you want to parallelize
- When one part is blocked and you want to keep moving on another
