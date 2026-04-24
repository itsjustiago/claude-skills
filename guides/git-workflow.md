# Git & PR Workflow Guide

## ship — one-shot commit + push + PR
> *"/ship"* · *"ship it"* · *"dá push e abre PR"*

The **fast lane**. Use when you trust the changes and just want them on GitHub — no tests, no docs, no review.

Automatically handles:
- `git add -A`
- Conventional Commit message (delegated to `sanctum:commit-messages`)
- `git push` (with `-u` if needed)
- `gh pr create` with a proper title + body generated from the diff
- Returns the PR URL

Safety: stops on `main`/`master`, warns on secret-looking files, never `--amend` / `--no-verify`, won't duplicate an existing PR.

Prefer `ship` over `sanctum this` for small/medium changes. Use `sanctum` when you want changelog + version bump too.

## Sanctum — after you finish building
> *"Sanctum this"*

Automatically handles:
- Commit message (descriptive, conventional format)
- Branch naming
- PR title and description
- Changelog entry
- Semantic version bump (patch / minor / major)

You finish coding → say sanctum → it handles the rest.

## Attune — before you start building
> *"Let's attune this project"*

Walks you through:
1. **Brainstorm** — what are we actually building?
2. **Specify** — what are the exact requirements?
3. **Plan** — what are the steps?
4. **Initialize** — set up the structure
5. **Execute** — build it
6. **War-room** — handle blockers

Use this at the start of any non-trivial feature.

## Minister — issue management
> *"Minister: create issues for everything we need to build for [feature]"*

Creates structured GitHub issues with proper labels, milestones, and descriptions. Keeps your board organized automatically.

## Scribe — documentation
> *"Scribe the [module name]"*

Writes quality-controlled documentation for any module, function, or feature. Has AI quality detection — won't produce generic boilerplate.
