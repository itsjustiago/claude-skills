#!/usr/bin/env bash
# One-shot plugin installer for itsjustiago's Claude Code setup
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

echo "Installing plugins..."
plugins=(
  "frontend-design@claude-code-plugins"
  "ui-ux-pro-max@ui-ux-pro-max-skill"
  "impeccable@impeccable"
  "superpowers@superpowers-dev"
  "backend-development@claude-code-workflows"
  "full-stack-orchestration@claude-code-workflows"
  "database-design@claude-code-workflows"
  "database-migrations@claude-code-workflows"
  "api-scaffolding@claude-code-workflows"
  "git-pr-workflows@claude-code-workflows"
  "agent-orchestration@claude-code-workflows"
  "debugging-toolkit@claude-code-workflows"
  "unit-testing@claude-code-workflows"
  "tdd-workflows@claude-code-workflows"
  "deployment-strategies@claude-code-workflows"
  "documentation-generation@claude-code-workflows"
  "security-scanning@claude-code-workflows"
  "agent-teams@claude-code-workflows"
  "frontend-mobile-development@claude-code-workflows"
  "attune@claude-night-market"
  "sanctum@claude-night-market"
  "minister@claude-night-market"
  "scribe@claude-night-market"
  "memory-palace@claude-night-market"
  "conjure@claude-night-market"
  "conserve@claude-night-market"
  "hookify@claude-night-market"
  "engineering-skills@claude-code-skills"
  "engineering-advanced-skills@claude-code-skills"
  "fullstack-engineer@claude-code-skills"
  "skill-security-auditor@claude-code-skills"
  "docker-development@claude-code-skills"
  "aws-architect@claude-code-skills"
  "product-manager@claude-code-skills"
  "supply-chain-risk-auditor@trailofbits"
  "static-analysis@trailofbits"
  "variant-analysis@trailofbits"
  "semgrep-rule-creator@trailofbits"
  "second-opinion@trailofbits"
  "insecure-defaults@trailofbits"
  "mutation-testing@trailofbits"
  "property-based-testing@trailofbits"
  "audit-context-building@trailofbits"
  "context-engineering@context-engineering-marketplace"
  "ecc@ecc"
)

for plugin in "${plugins[@]}"; do
  if claude plugin install "$plugin" --scope user 2>&1 | grep -q "Successfully"; then
    echo "  ✔ $plugin"
  else
    echo "  ✘ $plugin (may already be installed)"
  fi
done

echo ""
echo "Installing taste-skill variants (manual)..."
for skill in taste-skill soft-skill minimalist-skill brutalist-skill redesign-skill output-skill stitch-skill; do
  mkdir -p ~/.claude/skills/$skill
  curl -sL "https://raw.githubusercontent.com/Leonxlnx/taste-skill/main/skills/$skill/SKILL.md" \
    -o ~/.claude/skills/$skill/SKILL.md && echo "  ✔ $skill" || echo "  ✘ $skill"
done

echo ""
echo "Done! Auth your MCP servers — see mcp/README.md"
