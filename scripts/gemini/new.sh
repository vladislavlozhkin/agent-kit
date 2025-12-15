#!/bin/bash

# ==============================================================================
# Gemini Agent: New Session
# Starts a new dialogue context and initializes the log file.
# ==============================================================================

# --- Configuration ---
PROJECT_ROOT=$(git rev-parse --show-toplevel)
if [ -z "$PROJECT_ROOT" ]; then
  echo "❌ Error: Could not determine git repository root." >&2
  exit 1
fi

LOG_DIR="${PROJECT_ROOT}/.claude/logs/gemini"
LATEST_LOG_SYMLINK="${LOG_DIR}/latest.md"
MODEL="pro"

mkdir -p "$LOG_DIR"

# --- New Chat Setup ---
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="${LOG_DIR}/${TIMESTAMP}.md"
ln -sf "${LOG_FILE}" "${LATEST_LOG_SYMLINK}"
echo "# Gemini Chat Log: ${TIMESTAMP}" >"$LOG_FILE"

# --- Logging & Execution ---
PROMPT_ARGS="$*"
LOG_TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

{
  echo -e "\n---"
  echo "## Turn 1"
  echo "- **Timestamp:** ${LOG_TIMESTAMP}"
  echo "- **Model:** ${MODEL}"
  echo "- **Command:** gemini/new.sh"
  echo ""
  echo "### Prompt:"
  echo '```'
  echo "$PROMPT_ARGS"
  echo '```'
  echo ""
  echo "### Response:"
  echo '```'
} >>"$LOG_FILE"

# --- Execution ---
echo "🤖 Gemini (${MODEL}) processing..."
RESPONSE=$(gemini "$@" --model "$MODEL" --output-format text 2>&1 | grep -v "^\[STARTUP\]" | grep -v "^(node" | grep -v "^Loaded" | grep -v "^(Use")

{
  echo "$RESPONSE"
  echo '```'
} >>"$LOG_FILE"

# Output response for user/agent
echo "$RESPONSE"
echo ""
echo -e "\033[90m📝 New chat session started. Log: ${LOG_FILE}\033[0m"

