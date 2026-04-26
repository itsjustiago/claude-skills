# ship
**Source:** Custom (this repo)
**Type:** Standalone skill bundle (manually installed to `~/.claude/skills/`)
**Install:**
- Copy `skills/ship/SKILL.md` → `~/.claude/skills/ship/SKILL.md`
- Copy `skills/ship-merge/SKILL.md` → `~/.claude/skills/ship-merge/SKILL.md`

## What it does
A two-skill bundle for getting changes off your machine fast. Both skills share the same preflight, commit, push, and PR logic — `/ship` stops at the PR, `/ship-merge` carries it all the way to `main`. They delegate the "smart" parts (commit message, PR body) to `sanctum`, so you get the same quality as `sanctum:prepare-pr` without its heavy quality gates (tests, docs, full code review).

## Sub-skills

### ship
One-shot `stage → commit → push → open PR`. For when you trust the changes and just want them up on GitHub with a proper Conventional Commit message and a PR description generated from the diff. **No quality gates**: no tests, no docs, no code review.

**Trigger phrases:**
> *"/ship"* · *"ship it"* · *"dá push e abre PR"* · *"commit push e PR"*

**Flow:**
1. Preflight (branch not `main`, dirty tree, remote configured)
2. `git add -A` + commit via `sanctum:commit-messages`
3. `git push` (with `-u` if needed)
4. Check if PR exists — if not, create one via `gh pr create` with auto-generated body
5. Return the PR URL

### ship-merge
The **full one-shot release**: `/ship` + conflict check + CI wait + light review + squash-merge to `main` + branch cleanup. For when you trust the changes and want them landed in one go.

**Trigger phrases:**
> *"/ship-merge"* · *"ship and merge"* · *"dá ship e merge"* · *"ship até ao fim"* · *"ship merge it"*

**Flow (extends `/ship`):**
1–4. Same as `/ship` (preflight → commit → push → open PR)
5. Conflict check + CI wait (`gh pr view --json mergeable,statusCheckRollup`, poll `gh pr checks`)
6. Light inline review (scan diff for secrets, generated files, `console.log`/`TODO` noise — blocks on secrets, warns otherwise)
7. `gh pr merge --squash --delete-branch --auto`
8. Local cleanup (`git checkout main && git pull --ff-only && git branch -d <branch>`)

## When to use which

| Skill | Commit | Push | PR | Review | Merge |
|-------|--------|------|----|----|-------|
| `/ship` | yes | yes | yes | no | no |
| `/ship-merge` | yes | yes | yes | light (inline diff) | yes (squash + delete) |
| `sanctum:prepare-pr` | yes | yes | yes | full (tests + docs + review) | no |

- Just want the PR open → `/ship`
- Want it landed on `main` in one go → `/ship-merge`
- Want full tests/docs/deep review before shipping → `sanctum:prepare-pr`
- Just a commit without a PR → `sanctum:acp`

## Safety rails (both sub-skills)
- Stops on `main` / `master` — create a branch first
- Warns on secret-looking files (`.env`, `*.pem`, `credentials*`, `*.key`, `*.secret`, `id_rsa*`)
- Never uses `--amend`, `--no-verify`, or `--admin` to bypass checks
- Won't create a duplicate PR if one already exists for the branch

**`/ship-merge` adds:**
- Stops if PR is `CONFLICTING`, has failing CI, or has `CHANGES_REQUESTED` review
- Uses `gh pr merge --auto` so merge waits for checks even if a pending state was missed
- Uses `git branch -d` (not `-D`) — won't force-delete unmerged local branches; reports to user instead
