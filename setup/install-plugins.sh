#!/usr/bin/env bash
# Lean bootstrap for itsjustiago's Claude Code setup.
#
# Philosophy: keep global tiny (~5 plugins + the matchmaker), let each project
# pull its own skills from github.com/itsjustiago/skillsbase via /skills-suggest.
#
# Run: bash install-plugins.sh

set -e

echo "==> Adding marketplaces (essential only)..."
claude plugin marketplace add obra/superpowers
claude plugin marketplace add pbakaus/impeccable
claude plugin marketplace add athola/claude-night-market
claude plugin marketplace add bradautomates/claude-video

echo ""
echo "==> Installing core plugins..."
core_plugins=(
  "superpowers@superpowers-dev"        # brainstorming, TDD, debug, plans, git worktrees
  "sanctum@claude-night-market"        # ship-merge PR workflow
  "conserve@claude-night-market"       # context-optimization, clear-context
  "impeccable@impeccable"              # design polish (critique/polish/audit/clarify)
  "watch@claude-video"                 # video clips (yt-dlp + ffmpeg + Whisper)
)

for plugin in "${core_plugins[@]}"; do
  if claude plugin install "$plugin" --scope user 2>&1 | grep -q "Successfully"; then
    echo "  v $plugin"
  else
    echo "  - $plugin (may already be installed)"
  fi
done

echo ""
echo "==> Installing skill-matchmaker (the engine of per-project skill loading)..."
mkdir -p ~/.claude/skills/skill-matchmaker
curl -sL https://raw.githubusercontent.com/itsjustiago/skillsbase/main/scripts/skill-matchmaker.md \
  -o ~/.claude/skills/skill-matchmaker/SKILL.md \
  && echo "  v skill-matchmaker" \
  || echo "  x skill-matchmaker (download failed — check internet)"

echo ""
echo "==> Installing /skills-suggest slash command..."
mkdir -p ~/.claude/commands
curl -sL https://raw.githubusercontent.com/itsjustiago/skillsbase/main/scripts/skills-suggest.md \
  -o ~/.claude/commands/skills-suggest.md \
  && echo "  v /skills-suggest" \
  || echo "  x /skills-suggest"

echo ""
echo "==> Next steps:"
echo "  1. Copy global config:    cp setup/settings.json ~/.claude/"
echo "  2. Copy global CLAUDE.md: cp setup/CLAUDE.md ~/.claude/"
echo "  3. Copy statusline:       cp setup/statusline.sh ~/.claude/"
echo "  4. Auth MCP servers:      see mcp/README.md"
echo "  5. Start any project:     claude code"
echo "  6. In each new project:   /skills-suggest"
echo "     → matchmaker reads package.json/etc, proposes relevant skills from"
echo "       github.com/itsjustiago/skillsbase, installs into <project>/.claude/skills/"
echo ""
echo "Optional plugins (NOT installed by default — enable on demand if a project asks for it):"
echo "  - ecc@ecc                          (Claude API/agent harness, exa-search, deep-research)"
echo "  - engineering-skills@claude-code-skills          (HTML PPT decks, dashboards)"
echo "  - engineering-advanced-skills@claude-code-skills"
echo "  - context-engineering@context-engineering-marketplace"
echo "  - ui-ux-pro-max@ui-ux-pro-max-skill"
echo "  - frontend-design@claude-code-plugins"
echo "  - trailofbits/* (security audit suite — semgrep, codeql, supply-chain, etc.)"
echo ""
echo "Most of these have their skills already mirrored in skillsbase/ at the per-skill"
echo "level — installing the plugin is only needed if you want them auto-loaded globally."
echo ""
echo "Done."
