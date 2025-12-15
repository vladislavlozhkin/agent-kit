#!/bin/bash

# ==============================================================================
# Install Script for Agent Kit
# Installs AI CLI tools (gemini, etc.) into .claude/scripts/
# Usage: curl -fsSL https://raw.githubusercontent.com/vladislavlozhkin/agent-kit/main/install.sh | bash
# ==============================================================================

set -e

REPO_BASE_URL="https://raw.githubusercontent.com/vladislavlozhkin/agent-kit/main"
TARGET_DIR=".claude"

echo "🚀 Installing Agent Kit..."

# --- Check dependencies ---
if ! command -v git >/dev/null 2>&1; then
    echo "❌ Error: git is required but not installed." >&2
    exit 1
fi

if ! command -v gemini >/dev/null 2>&1; then
    echo "⚠️  Warning: 'gemini' CLI not found in PATH."
    echo "   Continuing installation..."
fi

if ! command -v codex >/dev/null 2>&1; then
    echo "⚠️  Warning: 'codex' CLI not found in PATH."
    echo "   Continuing installation..."
fi

# --- Download function ---
download_file() {
    local url="$1"
    local dest="$2"

    echo "⬇️  Downloading $(basename "$dest")..."

    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$url" -o "$dest"
    elif command -v wget >/dev/null 2>&1; then
        wget -qO "$dest" "$url"
    else
        echo "❌ Error: curl or wget is required." >&2
        exit 1
    fi
}

# --- Create directories ---
mkdir -p "$TARGET_DIR/scripts/gemini"
mkdir -p "$TARGET_DIR/scripts/codex"
mkdir -p "$TARGET_DIR/commands/gemini"
mkdir -p "$TARGET_DIR/commands/codex"
mkdir -p "$TARGET_DIR/logs/gemini"
mkdir -p "$TARGET_DIR/logs/codex"

# --- Download Gemini scripts ---
GEMINI_SCRIPTS=("new.sh" "continue.sh")
for script in "${GEMINI_SCRIPTS[@]}"; do
    download_file "$REPO_BASE_URL/scripts/gemini/$script" "$TARGET_DIR/scripts/gemini/$script"
    chmod +x "$TARGET_DIR/scripts/gemini/$script"
done

# --- Download Codex scripts ---
CODEX_SCRIPTS=("new.sh" "continue.sh")
for script in "${CODEX_SCRIPTS[@]}"; do
    download_file "$REPO_BASE_URL/scripts/codex/$script" "$TARGET_DIR/scripts/codex/$script"
    chmod +x "$TARGET_DIR/scripts/codex/$script"
done

# --- Download commands ---
download_file "$REPO_BASE_URL/commands/gemini/dialog.md" "$TARGET_DIR/commands/gemini/dialog.md"
download_file "$REPO_BASE_URL/commands/codex/dialog.md" "$TARGET_DIR/commands/codex/dialog.md"

# --- Summary ---
echo ""
echo "✅ Agent Kit installed successfully!"
echo ""
echo "📁 Installed to: $TARGET_DIR/"
echo "   scripts/gemini/new.sh"
echo "   scripts/gemini/continue.sh"
echo "   scripts/codex/new.sh"
echo "   scripts/codex/continue.sh"
echo "   commands/gemini/dialog.md"
echo "   commands/codex/dialog.md"
echo ""
echo "🔧 Configuration (optional):"
echo "   export GEMINI_MODEL=\"flash\"    # default: pro"
echo "   export CODEX_MODEL=\"gpt-4o\"    # default: gpt-5.2"
echo ""
echo "🚀 Usage:"
echo "   ./$TARGET_DIR/scripts/gemini/new.sh \"Your prompt here\""
echo "   ./$TARGET_DIR/scripts/codex/new.sh \"Your prompt here\""
