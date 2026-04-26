# Global Claude Code Instructions

## Skill Installation
Whenever the user says "install a skill", "add a skill", or similar — always install it **globally** to `~/.claude/settings.json` (not project-level, not session-only), unless the user explicitly says "install this just for this project" or "install just for this session."

After installing globally, confirm to the user that the skill is now available across all their projects.

## Skill Organization
When a single skill installation brings in multiple sub-skills (e.g. a bundle or package), document them grouped under the parent skill name — not as a flat list. Use this format in any skill inventory or documentation:

```
## <parent-skill-name>
- sub-skill-1
- sub-skill-2
- sub-skill-3
...
```

This way it's always clear which skills came from which parent, and the user can remove or reference a whole group by its parent name.

## GitHub Skills Repository
After every skill installation, update the GitHub repo at https://github.com/itsjustiago/claude-skills by cloning/pulling it to a temp directory, making changes, and pushing:

1. **README.md** — add the skill to the relevant section in the Installed Skills table.
2. **skills/<parent-skill-name>.md** — create or update with: source repo, install command, what it does, sub-skills list, and how to use it.
3. **guides/** — if the skill has a non-obvious workflow (e.g. a design pipeline, security audit steps, multi-step commands), create or update the relevant guide in `guides/`. Simple utility skills don't need a guide entry.
4. **setup/install-plugins.sh** — add the new plugin install command to the script so new machines get it automatically.
5. **setup/settings.json** — add the new plugin and its marketplace source.
6. Commit and push with message: `Add skill: <parent-skill-name>`.

### What counts as "needs a usage guide"
Write or update a guide in `guides/` when the skill:
- Has specific commands the user needs to know (e.g. `/audit`, `/polish`)
- Works as part of a multi-step workflow
- Has multiple modes or variants
- Requires the user to trigger it manually at the right moment

Simple auto-activating skills (background enhancers) don't need a guide entry.

## Task approach
Before non-trivial coding tasks, briefly check installed skills for one that applies — invoke it via the `Skill` tool if there's a clear match. Skip the check for one-liners and trivial edits.

For grunt work (file searches, reading large outputs, simple lookups, parallel checks), dispatch to subagents via the `Agent` tool with a smaller model: `model: "haiku"` for searches/reads, `model: "sonnet"` for mid-complexity work. Stay in Opus for orchestration, planning, and complex reasoning. Don't analyze every task to pick a model — just default to Opus and override only when grunt work is well-bounded.
