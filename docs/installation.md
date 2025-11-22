# Installation Guide

## Prerequisites

- **Linux/macOS** (Windows users should use WSL2 or Git Bash)
- AI coding agent: [Claude Code](https://www.anthropic.com/claude-code) or [Codex CLI](https://github.com/openai/codex)
- [uv](https://docs.astral.sh/uv/) for package management
- [Python 3.11+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)

## Installation

### Initialize a New Project

The easiest way to get started is to initialize a new project:

```bash
uvx --from git+https://github.com/nguyenvanduocit/research-kit.git research init <PROJECT_NAME>
```

Or initialize in the current directory:

```bash
uvx --from git+https://github.com/nguyenvanduocit/research-kit.git research init .
# or use the --here flag
uvx --from git+https://github.com/nguyenvanduocit/research-kit.git research init --here
```

### Specify AI Agent

You can proactively specify your AI agent during initialization:

```bash
uvx --from git+https://github.com/nguyenvanduocit/research-kit.git research init <project_name> --ai claude
uvx --from git+https://github.com/nguyenvanduocit/research-kit.git research init <project_name> --ai codex
```

### Ignore Agent Tools Check

If you prefer to get the templates without checking for the right tools:

```bash
uvx --from git+https://github.com/nguyenvanduocit/research-kit.git research init <project_name> --ai claude --ignore-agent-tools
```

## Verification

After initialization, you should see the following commands available in your AI agent:

- `/research.define` - Define research topic and questions
- `/research.methodology` - Design research methodology
- `/research.tasks` - Break down into actionable tasks

The `.research/scripts/bash` directory will contain automation scripts.

## Troubleshooting

### Git Credential Manager on Linux

If you're having issues with Git authentication on Linux, you can install Git Credential Manager:

```bash
#!/usr/bin/env bash
set -e
echo "Downloading Git Credential Manager v2.6.1..."
wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.1/gcm-linux_amd64.2.6.1.deb
echo "Installing Git Credential Manager..."
sudo dpkg -i gcm-linux_amd64.2.6.1.deb
echo "Configuring Git to use GCM..."
git config --global credential.helper manager
echo "Cleaning up..."
rm gcm-linux_amd64.2.6.1.deb
```
