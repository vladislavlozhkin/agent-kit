# AI-Utils Agent Kit

A collection of CLI wrappers and scripts for AI tools, designed to be integrated into project workflows (e.g., via `.claude` or `.gemini` folders).

## Components

### 1. Gemini Wrapper (`scripts/gemini`)
Scripts to maintain a persistent chat context with Gemini, logging interactions to Markdown files.

- **`new.sh`**: Starts a new chat session.
- **`continue.sh`**: Continues the latest chat session.

**Dependencies:**
- `gemini` CLI tool installed and available in PATH.
- `git` (to locate project root).

## Installation

To add these tools to your current project:

```bash
# Assuming you are in the root of 'ai-utils' or have it cloned
cp -R path/to/ai-utils/agent-kit/scripts/gemini .claude/scripts/
cp path/to/ai-utils/agent-kit/commands/gemini.md .claude/commands/
```

*(An automated `install.sh` will be available once the repository is hosted publicly)*

## Usage

### Gemini

Inside your project (after installation):

```bash
# Start a new chat
./.claude/scripts/gemini/new.sh "Hello, world!"

# Continue the conversation
./.claude/scripts/gemini/continue.sh "Refine the previous answer."
```

Logs are stored in `.claude/logs/gemini/`.
