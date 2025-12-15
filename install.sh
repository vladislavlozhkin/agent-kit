#!/bin/bash

# ==============================================================================
# Install Script for AI-Utils Agent Kit
# Installs AI CLI tools (gemini, etc.) into .claude/scripts/
# Usage: curl -fsSL https://raw.githubusercontent.com/vladislavlozhkin/ai-utils-agent-kit/main/install.sh | bash
# ==============================================================================

set -e

# TODO: Update this URL once the repo is public/moved
REPO_BASE_URL="https://raw.githubusercontent.com/vladislavlozhkin/worktree-utils/main" 
# NOTE: Since this is a local pet project, the URL above is a placeholder. 
# In a real scenario, this would point to where the raw files are hosted.
# For local usage, we might assume the user copies files or runs this from the repo root.

TARGET_DIR=".claude"

echo "🚀 Installing AI-Utils CLI..."

# 1. Create the target directories
mkdir -p "$TARGET_DIR/scripts"
mkdir -p "$TARGET_DIR/commands"

# Function to download file
download_file() {
    local url="$1"
    local dest="$2"
    
    echo "⬇️  Downloading $(basename "$dest")..."
    # Mocking download for local development context if REPO_BASE_URL is not reachable
    # In a real install script, use curl/wget
    
    # For now, we will just echo what would happen because we don't have a public URL yet.
    # But to make this script functional for *you* locally, let's assume you run it
    # where the source is available or just setup the structure.
    
    if command -v curl >/dev/null 2>&1; then
         # curl -fsSL "$url" -o "$dest"
         echo "   (Simulation) curl $url -> $dest"
    else
         # wget -qO "$dest" "$url"
         echo "   (Simulation) wget $url -> $dest"
    fi
}

# 2. Install Gemini Scripts
GEMINI_SCRIPTS_DIR="$TARGET_DIR/scripts/gemini"
mkdir -p "$GEMINI_SCRIPTS_DIR"

# Since we can't easily "download directory" via simple curl/wget without a zip or recursive logic,
# The standard way is to download specific files.

# List of files to install
GEMINI_FILES=("new.sh" "continue.sh")
GEMINI_CMD="gemini.md"

# ... (Download logic would go here) ...

echo "⚠️  NOTE: This install script is a template. Since the repository URL is not yet established,"
echo "    automatic downloading is disabled. Please copy the files manually for now:"
echo "    cp -R ai-utils/cli/scripts/gemini $TARGET_DIR/scripts/"
echo "    cp ai-utils/cli/commands/gemini.md $TARGET_DIR/commands/"

echo ""
echo "✅ Installation structure created in $TARGET_DIR"
