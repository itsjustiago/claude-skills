# ship
**Source:** Custom (this repo)
**Type:** Standalone skill (manually installed to `~/.claude/skills/`)
**Install:** Copy `skills/ship/SKILL.md` from this repo into `~/.claude/skills/ship/SKILL.md`

## What it does
One-shot `stage → commit → push → open PR` for when you trust the changes and just want them up on GitHub with a proper Conventional Commit message and a PR description generated from the diff. **No quality gates**: no tests, no docs, no code review. Just ship.

The skill is deliberately thin — it delegates the "smart" parts to existing skills:
- **Commit message** → `sanctum:commit-messages` (or `sanctum:commit-msg`)
- **PR title + body** → reuses the body-generation logic from `sanctum:pr-prep`, skipping its quality gates

This gives you the same commit/PR quality as `sanctum:prepare-pr` without the slow steps.

## How to use
Say any of these when you have local changes on a feature branch:
> *"/ship"*
> *"ship it"*
> *"dá push e abre PR"*
> *"commit push e PR"*

Claude will:
1. Preflight check (branch not `main`, dirty tree, remote configured)
2. `git add -A` + commit via `sanctum:commit-messages`
3. `git push` (with `-u` if needed)
4. Check if PR exists — if not, create one via `gh pr create` with an auto-generated body
5. Return the PR URL

## When NOT to use
- You want tests/docs/code-review before shipping → use `sanctum:prepare-pr` instead
- You're on `main` / `master` → skill will stop; create a branch first
- You just want a commit without a PR → use `sanctum:acp` instead

## Safety rails
- Stops on `main` / `master`
- Warns on secret-looking files (`.env`, `*.pem`, `credentials*`)
- Never uses `--amend` or `--no-verify`
- Won't create a duplicate PR if one already exists for the branch
