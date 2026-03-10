#!/bin/bash
# Install Gemini Skills for Claude Code

SKILLS_DIR="$HOME/.claude/skills"

echo "Installing Gemini Skills for Claude Code..."

mkdir -p "$SKILLS_DIR/gemini-research"
mkdir -p "$SKILLS_DIR/gemini-image"

cp skills/gemini-research/SKILL.md "$SKILLS_DIR/gemini-research/SKILL.md"
cp skills/gemini-image/SKILL.md "$SKILLS_DIR/gemini-image/SKILL.md"

echo ""
echo "✓ Skills installed:"
echo "  - /gemini-research"
echo "  - /gemini-image"
echo ""
echo "Next: Add your API key to ~/.zshrc or ~/.bashrc:"
echo '  export GEMINI_API_KEY="your-api-key-here"'
echo '  export GEMINI_BASE_URL="https://api.devdove.site/v1"  # or your own endpoint'
echo ""
echo "Then restart Claude Code and use:"
echo "  /gemini-research <query>"
echo "  /gemini-image <description>"
