# taste-skill
**Source:** https://github.com/Leonxlnx/taste-skill
**Type:** Standalone skills (manually installed to ~/.claude/skills/)
**Install:** Fetch each SKILL.md from the repo and copy to `~/.claude/skills/<variant>/SKILL.md`

## What it does
Aesthetic judgment layer with 7 variants. Prevents generic AI output by giving Claude a specific design aesthetic to follow. Pick one variant per project based on the vibe you want.

## Variants (sub-skills)
- **taste-skill** — Default modern/premium aesthetic
- **soft-skill** — Spacious, premium, breathing room
- **minimalist-skill** — Editorial, clean, typographic
- **brutalist-skill** — Raw, mechanical, unapologetic (beta)
- **redesign-skill** — For upgrading and restyling existing UIs
- **output-skill** — Prevents incomplete code generation
- **stitch-skill** — Google Stitch compatible rules

## How to use
Tell Claude which variant at the start of a project:
> "Use soft-skill aesthetic for this project"
