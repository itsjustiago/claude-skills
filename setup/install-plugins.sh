#!/usr/bin/env bash
# One-shot plugin installer for itsjustiago'\''s Claude Code setup
# Run: bash install-plugins.sh

set -e

echo "Adding marketplaces..."
claude plugin marketplace add obra/superpowers
claude plugin marketplace add muratcankoylan/Agent-Skills-for-Context-Engineering
claude plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill
claude plugin marketplace add pbakaus/impeccable
claude plugin marketplace add anthropics/claude-code
claude plugin marketplace add wshobson/agents
claude plugin marketplace add athola/claude-night-market
claude plugin marketplace add alirezarezvani/claude-skills
claude plugin marketplace add trailofbits/skills
claude plugin marketplace add affaan-m/everything-claude-code
claude plugin marketplace add bradautomates/claude-video

echo "Installing plugins..."
plugins=(
  # Core
  "superpowers@superpowers-dev"
  "context-engineering@context-engineering-marketplace"
  "ui-ux-pro-max@ui-ux-pro-max-skill"
  "impeccable@impeccable"

  # Frontend
  "frontend-design@claude-code-plugins"
  "frontend-mobile-development@claude-code-workflows"

  # Backend / Full-stack
  "backend-development@claude-code-workflows"
  "full-stack-orchestration@claude-code-workflows"
  "api-scaffolding@claude-code-workflows"

  # Database
  "database-design@claude-code-workflows"
  "database-migrations@claude-code-workflows"

  # Dev workflow
  "git-pr-workflows@claude-code-workflows"
  "debugging-toolkit@claude-code-workflows"
  "tdd-workflows@claude-code-workflows"
  "security-scanning@claude-code-workflows"
  "agent-teams@claude-code-workflows"

  # Night Market
  "leyline@claude-night-market"
  "attune@claude-night-market"
  "sanctum@claude-night-market"
  "conserve@claude-night-market"
  "abstract@claude-night-market"
  "minister@claude-night-market"
  "scribe@claude-night-market"

  # Engineering skills
  "engineering-skills@claude-code-skills"
  "engineering-advanced-skills@claude-code-skills"

  # Security
  "audit-context-building@trailofbits"
  "supply-chain-risk-auditor@trailofbits"
  "insecure-defaults@trailofbits"
  "second-opinion@trailofbits"
  "static-analysis@trailofbits"
  "variant-analysis@trailofbits"

  # Everything Claude Code (bundles GitHub/Exa/Context7/Memory/Playwright/Sequential-Thinking MCPs)
  "ecc@ecc"

  # Media — give Claude a video input via /watch (yt-dlp + ffmpeg + Whisper fallback)
  "watch@claude-video"
)

for plugin in "${plugins[@]}"; do
  if claude plugin install "$plugin" --scope user 2>&1 | grep -q "Successfully"; then
    echo "  v $plugin"
  else
    echo "  x $plugin (may already be installed)"
  fi
done

echo ""
echo "Note: 33 plugins installed, 17 active by default. 16 are installed-but-disabled in setup/settings.json,"
echo "and 15 more from the same marketplaces are not installed at all."
echo "Re-enable any via enabledPlugins in ~/.claude/settings.json if a workflow demands it:"
echo ""
echo "Installed-but-disabled (16) — flip to true in settings.json to re-enable:"
echo "  - wshobson/agents (11): backend-development, full-stack-orchestration, database-design, database-migrations,"
echo "      api-scaffolding, git-pr-workflows, debugging-toolkit, tdd-workflows, security-scanning, agent-teams,"
echo "      frontend-mobile-development (duplicated impeccable + sanctum + trailofbits coverage)"
echo "  - claude-night-market (5): leyline, attune, abstract, minister, scribe"
echo "      (duplicated sanctum + superpowers)"
echo ""
echo "Not installed (15) — pruned at install time for niche / overlap reasons:"
echo "  - wshobson/agents (4): unit-testing, agent-orchestration, deployment-strategies, documentation-generation"
echo "  - claude-night-market (3): memory-palace, conjure, hookify"
echo "  - alirezarezvani/claude-skills (5): fullstack-engineer, docker-development, aws-architect, product-manager, skill-security-auditor"
echo "  - trailofbits/skills (3): semgrep-rule-creator, mutation-testing, property-based-testing"

echo ""
echo "Installing taste-skill variants (manual)..."
for skill in taste-skill soft-skill minimalist-skill brutalist-skill redesign-skill output-skill stitch-skill; do
  mkdir -p ~/.claude/skills/$skill
  curl -sL "https://raw.githubusercontent.com/Leonxlnx/taste-skill/main/skills/$skill/SKILL.md"     -o ~/.claude/skills/$skill/SKILL.md && echo "  v $skill" || echo "  x $skill"
done

echo ""
echo "Installing open-design skill bundle (74 skills, manual)..."
OD_TMP="$(mktemp -d 2>/dev/null || mktemp -d -t opendesign)"
git clone --depth 1 --filter=blob:none --sparse https://github.com/nexu-io/open-design.git "$OD_TMP/open-design" >/dev/null 2>&1 \
  && (cd "$OD_TMP/open-design" && git sparse-checkout set skills design-systems >/dev/null 2>&1) \
  && mkdir -p ~/.claude/skills ~/.claude/skills-source/open-design \
  && cp -r "$OD_TMP/open-design/skills/"* ~/.claude/skills/ \
  && cp -r "$OD_TMP/open-design/design-systems" ~/.claude/skills-source/open-design/ \
  && cp -r "$OD_TMP/open-design/skills" ~/.claude/skills-source/open-design/ \
  && cp "$OD_TMP/open-design/LICENSE" ~/.claude/skills-source/open-design/ 2>/dev/null \
  && cp "$OD_TMP/open-design/README.md" ~/.claude/skills-source/open-design/README-open-design.md 2>/dev/null \
  && echo "  v open-design (74 skills + 139 design-systems source)" \
  || echo "  x open-design (clone failed)"
rm -rf "$OD_TMP"

echo ""
echo "Done! Auth your MCP servers - see mcp/README.md"
