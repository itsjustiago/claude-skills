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

  # Engineering skills
  "engineering-skills@claude-code-skills"
  "engineering-advanced-skills@claude-code-skills"

  # Security audit
  "audit-context-building@trailofbits"
)

for plugin in "${plugins[@]}"; do
  if claude plugin install "$plugin" --scope user 2>&1 | grep -q "Successfully"; then
    echo "  v $plugin"
  else
    echo "  x $plugin (may already be installed)"
  fi
done

echo ""
echo "Note: Some plugins are intentionally disabled to reduce context startup cost."
echo "Re-enable via enabledPlugins in ~/.claude/settings.json if needed:"
echo "  - wshobson/agents: unit-testing, deployment-strategies, documentation-generation, agent-orchestration"
echo "  - claude-night-market: minister, scribe, memory-palace, conjure, hookify"
echo "  - alirezarezvani/claude-skills: fullstack-engineer, docker-development, aws-architect, product-manager, skill-security-auditor"
echo "  - trailofbits/skills: supply-chain-risk-auditor, static-analysis, variant-analysis, semgrep-rule-creator, second-opinion, insecure-defaults, mutation-testing, property-based-testing"
echo "  - ecc (everything-claude-code)"

echo ""
echo "Installing taste-skill variants (manual)..."
for skill in taste-skill soft-skill minimalist-skill brutalist-skill redesign-skill output-skill stitch-skill; do
  mkdir -p ~/.claude/skills/$skill
  curl -sL "https://raw.githubusercontent.com/Leonxlnx/taste-skill/main/skills/$skill/SKILL.md"     -o ~/.claude/skills/$skill/SKILL.md && echo "  v $skill" || echo "  x $skill"
done

echo ""
echo "Done! Auth your MCP servers - see mcp/README.md"
