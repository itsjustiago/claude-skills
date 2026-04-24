# ship-merge
**Source:** Custom (this repo)
**Type:** Standalone skill (manually installed to `~/.claude/skills/`)
**Install:** Copy `skills/ship-merge/SKILL.md` from this repo into `~/.claude/skills/ship-merge/SKILL.md`

## What it does
The **full one-shot release**: `stage → commit → push → open PR → check conflicts → wait for CI → light review → squash-merge to main → delete branch`. For when you trust the changes and want them landed on `main` in one go.

Extends the `/ship` skill with the post-PR merge workflow:
- **Steps 1–4:** same as `/ship` (preflight, commit via `sanctum:commit-messages`, push, open PR via `sanctum:pr-prep` body logic)
- **Step 5:** conflict check + CI wait (`gh pr view --json mergeable,statusCheckRollup`, poll `gh pr checks`)
- **Step 6:** light inline review (scan diff for secrets, generated files, `console.log`/`TODO` noise — blocks on secrets, warns otherwise)
- **Step 7:** `gh pr merge --squash --delete-branch --auto`
- **Step 8:** local cleanup (`git checkout main && git pull --ff-only && git branch -d <branch>`)

Does **not** run the heavy quality gates (no test suite execution, no docs updates, no full `sanctum:pr-review`). For those, use `sanctum:prepare-pr`.

## How to use
Say any of these when you have local changes on a feature branch and want them landed:
> *"/ship-merge"*
> *"ship and merge"*
> *"dá ship e merge"*
> *"ship até ao fim"*
> *"ship merge it"*

Claude will run the full 8-step flow and stop if anything looks off (conflicts, failing CI, secrets in diff, requested changes on the PR).

## When NOT to use
- You just want the PR open, not merged → use `/ship` (fast lane)
- You want tests/docs/deep review before merging → use `sanctum:prepare-pr`
- You're on `main` / `master` → skill will stop; create a branch first
- You want a merge commit or rebase instead of squash → this skill is squash-only by design

## Relationship to other skills

| Skill | Commit | Push | PR | Review | Merge |
|-------|--------|------|----|----|-------|
| `/ship` | yes | yes | yes | no | no |
| `/ship-merge` | yes | yes | yes | light (inline diff) | yes (squash + delete) |
| `sanctum:prepare-pr` | yes | yes | yes | full (tests + docs + review) | no |

## Safety rails
- Stops on `main` / `master`
- Warns on secret-looking files in staged changes (`.env`, `*.pem`, `credentials*`, `*.key`, `*.secret`, `id_rsa*`)
- Stops if PR is `CONFLICTING`, has failing CI, or has `CHANGES_REQUESTED` review
- Never uses `--amend`, `--no-verify`, or `--admin` to bypass checks
- Uses `gh pr merge --auto` so merge waits for checks even if we missed a pending state
- Uses `git branch -d` (not `-D`) — won't force-delete unmerged local branches; reports to user instead
