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
After every skill installation, update the GitHub repo at https://github.com/itsjustiago/claude-skills:

1. **README.md** — add the parent skill as a new section with its sub-skills listed underneath, and add a row to the Quick Reference table with the install date.
2. **skills/** folder — add a file named `<parent-skill-name>.md` containing the full skill content/description and a list of all sub-skills it includes.
3. Commit and push with a message like `Add skill: <parent-skill-name>`.

This keeps the repo always up to date so the user can reference it from any computer or share it with others.
