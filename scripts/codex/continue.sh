#!/bin/bash

# ==============================================================================
# Codex Agent: Continue Session
# Appends a new turn to the latest chat log and sends context to the model.
# ==============================================================================

# --- Configuration ---
PROJECT_ROOT=$(git rev-parse --show-toplevel)
if [ -z "$PROJECT_ROOT" ]; then
  echo "❌ Error: Could not determine git repository root." >&2
  exit 1
fi

LOG_DIR="${PROJECT_ROOT}/.claude/logs/codex"
LATEST_LOG_SYMLINK="${LOG_DIR}/latest.md"
MODEL="${CODEX_MODEL:-gpt-5.2}"

# --- Find Active Chat ---
if ! [ -e "$LATEST_LOG_SYMLINK" ]; then
  echo "⚠️  Error: No active chat found."
  echo "   Start a new one with 'codex/new.sh'." >&2
  exit 1
fi

LOG_FILE=$(readlink "${LATEST_LOG_SYMLINK}")
if ! [ -f "$LOG_FILE" ]; then
  echo "❌ Error: Symlink points to non-existent file: $LOG_FILE" >&2
  exit 1
fi

# --- Logging & Execution ---
TURN_COUNT=$(grep -c '## Turn' "$LOG_FILE")
TURN_NUMBER=$((TURN_COUNT + 1))
PROMPT_ARGS="$*"
LOG_TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

{
  echo -e "\n---"
  echo "## Turn ${TURN_NUMBER}"
  echo "- **Timestamp:** ${LOG_TIMESTAMP}"
  echo "- **Model:** ${MODEL}"
  echo "- **Command:** codex/continue.sh"
  echo ""
  echo "### Prompt:"
  echo '```'
  echo "$PROMPT_ARGS"
  echo '```'
  echo ""
  echo "### Response:"
  echo '```'
} >>"$LOG_FILE"

# --- Execution (with 'resume --last' subcommand added automatically) ---
# Note: resume uses the model from the original session
echo "🤖 Codex thinking (Turn ${TURN_NUMBER})..."
RESPONSE=$(codex exec resume --last "$@" 2>&1)

{
  echo "$RESPONSE"
  echo '```'
} >>"$LOG_FILE"

# Output response for user/agent
echo "$RESPONSE"
echo ""
echo -e "\033[90m📝 Log appended to: ${LOG_FILE}\033[0m"
