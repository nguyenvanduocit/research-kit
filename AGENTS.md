# AGENTS.md

## About Research Kit and Research CLI

**Research Kit** is a comprehensive toolkit for implementing Systematic Research Development (SRD) - a methodology that emphasizes structured research processes from definition through publication. The toolkit includes templates, scripts, and workflows that guide research teams through a systematic approach to conducting academic and professional research.

**Research CLI** is the command-line interface that bootstraps research projects with the Research Kit framework. It sets up the necessary directory structures, templates, and AI agent integrations to support the Systematic Research Development workflow.

The toolkit supports multiple AI research assistants, allowing teams to use their preferred tools while maintaining consistent project structure and research practices.

---

## Research Kit Agents

Research Kit now includes **custom agents** that provide autonomous, multi-step research workflows. These agents work alongside slash commands to offer different interaction patterns.

### Agents vs Slash Commands

| Aspect | Agents | Slash Commands |
|--------|--------|----------------|
| **Location** | `.claude/agents/`, `.github/agents/` | `.claude/commands/`, `.github/prompts/` |
| **Context** | Isolated (own conversation) | Shared (main conversation) |
| **Invocation** | Auto-delegated or explicit | Manual with `/` prefix |
| **Use Case** | Complex multi-step workflows | Single-step utilities |
| **State** | Maintains own context | Inline in main thread |

### Available Agents

| Agent | Description | Best For |
|-------|-------------|----------|
| **research-assistant** | Full SRD workflow orchestrator | Starting new research, guided workflow |
| **research-reviewer** | Quality assurance specialist | Validating definitions, checking rigor |

### Agent Locations by AI Assistant

| Assistant | Agents Location | Extension |
|-----------|-----------------|-----------|
| Claude Code | `.claude/agents/` | `.md` |
| GitHub Copilot | `.github/agents/` | `.agent.md` |
| Cursor | `.cursor/agents/` | `.md` |

### Using Agents

**Claude Code:**
```
User: "I want to research AI productivity impacts"
→ Claude auto-delegates to research-assistant agent
→ Agent guides through full SRD workflow
```

**GitHub Copilot (VS Code):**
```
User: Selects "research-assistant" from agent picker
→ Agent activates with isolated context
→ Handoff buttons appear for workflow transitions
```

---

## The SRD Workflow with Hand-offs

Research Kit uses an agentic workflow where each command can hand off to the next phase. This creates a natural research progression:

```
define → refine → methodology → validate → tasks → execute → analyze → synthesize → publish
        (opt)                   (opt)
```

### Command Hand-offs

Each research command includes hand-off metadata that defines natural next steps:

| Command | Hand-offs To | Description |
|---------|--------------|-------------|
| `/research.define` | refine, methodology | Define research topic and questions |
| `/research.refine` | methodology | Clarify ambiguous scope (optional) |
| `/research.methodology` | validate, tasks | Design research methodology |
| `/research.validate` | tasks | Validate methodology rigor (optional) |
| `/research.tasks` | execute | Generate actionable task breakdown |
| `/research.execute` | analyze | Collect data and run research |
| `/research.analyze` | synthesize | Analyze collected data |
| `/research.synthesize` | publish | Draw conclusions |
| `/research.publish` | - | Create publication outputs |

### Hand-off Format

Hand-offs are defined in command frontmatter:

```yaml
---
description: Command description
handoffs:
  - label: Next Step Label
    agent: research.next-command
    prompt: Initial prompt for next phase
    send: true  # Auto-send to next agent
  - label: Alternative Step
    agent: research.alternative
    prompt: Alternative path prompt
scripts:
  sh: scripts/bash/script-name.sh
  ps: scripts/powershell/script-name.ps1
---
```

**Hand-off Fields**:
- `label`: Button/link text shown to user
- `agent`: Target command (e.g., `research.methodology`)
- `prompt`: Initial prompt passed to next agent
- `send`: If `true`, automatically transitions (default: `false`, shows as option)

### Research Flow Examples

**Minimal Flow** (4 steps):
```
/research.define → /research.methodology → /research.execute → /research.publish
```

**Full Academic Flow** (9 steps):
```
/research.define → /research.refine → /research.methodology → /research.validate →
/research.tasks → /research.execute → /research.analyze → /research.synthesize → /research.publish
```

---

## General practices

- Any changes to `__init__.py` for the Research CLI require a version rev in `pyproject.toml` and addition of entries to `CHANGELOG.md`.

## Adding New Agent Support

This section explains how to add support for new AI agents/assistants to the Research CLI. Use this guide as a reference when integrating new AI tools into the Systematic Research Development workflow.

### Overview

Research CLI supports multiple AI agents by generating agent-specific command files and directory structures when initializing research projects. Each agent has its own conventions for:

- **Command file formats** (Markdown, TOML, etc.)
- **Directory structures** (`.claude/commands/`, `.windsurf/workflows/`, etc.)
- **Command invocation patterns** (slash commands, CLI tools, etc.)
- **Argument passing conventions** (`$ARGUMENTS`, `{{args}}`, etc.)

### Current Supported Agents

| Agent | Directory | Format | CLI Tool | Description |
|-------|-----------|---------|----------|-------------|
| **Claude Code** | `.claude/commands/` | Markdown | `claude` | Anthropic's Claude Code CLI |
| **Gemini CLI** | `.gemini/commands/` | TOML | `gemini` | Google's Gemini CLI |
| **GitHub Copilot** | `.github/prompts/` | Markdown | N/A (IDE-based) | GitHub Copilot in VS Code |
| **Cursor** | `.cursor/commands/` | Markdown | `cursor-agent` | Cursor CLI |
| **Qwen Code** | `.qwen/commands/` | TOML | `qwen` | Alibaba's Qwen Code CLI |
| **opencode** | `.opencode/command/` | Markdown | `opencode` | opencode CLI |
| **Codex CLI** | `.codex/commands/` | Markdown | `codex` | Codex CLI |
| **Windsurf** | `.windsurf/workflows/` | Markdown | N/A (IDE-based) | Windsurf IDE workflows |
| **Kilo Code** | `.kilocode/rules/` | Markdown | N/A (IDE-based) | Kilo Code IDE |
| **Auggie CLI** | `.augment/rules/` | Markdown | `auggie` | Auggie CLI |
| **Roo Code** | `.roo/rules/` | Markdown | N/A (IDE-based) | Roo Code IDE |
| **CodeBuddy CLI** | `.codebuddy/commands/` | Markdown | `codebuddy` | CodeBuddy CLI |
| **Amazon Q Developer CLI** | `.amazonq/prompts/` | Markdown | `q` | Amazon Q Developer CLI |
| **Amp** | `.agents/commands/` | Markdown | `amp` | Amp CLI |

### Step-by-Step Integration Guide

Follow these steps to add a new agent (using a hypothetical new agent as an example):

#### 1. Add to AGENT_CONFIG

**IMPORTANT**: Use the actual CLI tool name as the key, not a shortened version.

Add the new agent to the `AGENT_CONFIG` dictionary in `src/research_cli/__init__.py`. This is the **single source of truth** for all agent metadata:

```python
AGENT_CONFIG = {
    # ... existing agents ...
    "new-agent-cli": {  # Use the ACTUAL CLI tool name (what users type in terminal)
        "name": "New Agent Display Name",
        "folder": ".newagent/",  # Directory for agent files
        "install_url": "https://example.com/install",  # URL for installation docs (or None if IDE-based)
        "requires_cli": True,  # True if CLI tool required, False for IDE-based agents
    },
}
```

**Key Design Principle**: The dictionary key should match the actual executable name that users install. For example:

- ✅ Use `"cursor-agent"` because the CLI tool is literally called `cursor-agent`
- ❌ Don't use `"cursor"` as a shortcut if the tool is `cursor-agent`

This eliminates the need for special-case mappings throughout the codebase.

**Field Explanations**:

- `name`: Human-readable display name shown to users
- `folder`: Directory where agent-specific files are stored (relative to project root)
- `install_url`: Installation documentation URL (set to `None` for IDE-based agents)
- `requires_cli`: Whether the agent requires a CLI tool check during initialization

#### 2. Update CLI Help Text

Update the `--ai` parameter help text in the `init()` command to include the new agent:

```python
ai_assistant: str = typer.Option(None, "--ai", help="AI assistant to use: claude, gemini, copilot, cursor-agent, qwen, opencode, codex, windsurf, kilocode, auggie, codebuddy, new-agent-cli, or q"),
```

Also update any function docstrings, examples, and error messages that list available agents.

#### 3. Update README Documentation

Update the **Supported AI Research Assistants** section in `README.md` to include the new agent:

- Add the new agent to the table with appropriate support level (Full/Partial)
- Include the agent's official website link
- Add any relevant notes about the agent's implementation for research workflows
- Ensure the table formatting remains aligned and consistent

#### 4. Update Release Package Script

Modify `.github/workflows/scripts/create-release-packages.sh`:

##### Add to ALL_AGENTS array

```bash
ALL_AGENTS=(claude gemini copilot cursor-agent qwen opencode windsurf q)
```

##### Add case statement for directory structure

```bash
case $agent in
  # ... existing cases ...
  windsurf)
    mkdir -p "$base_dir/.windsurf/workflows"
    generate_commands windsurf md "\$ARGUMENTS" "$base_dir/.windsurf/workflows" "$script" ;;
esac
```

**Note**: For Research Kit, ensure generated commands use research workflow names (`/research.define`, `/research.methodology`, etc.) instead of code-focused commands.

#### 4. Update GitHub Release Script

Modify `.github/workflows/scripts/create-github-release.sh` to include the new agent's packages:

```bash
gh release create "$VERSION" \
  # ... existing packages ...
  .genreleases/research-kit-template-windsurf-sh-"$VERSION".zip \
  .genreleases/research-kit-template-windsurf-ps-"$VERSION".zip \
  # Add new agent packages here
```

#### 5. Update Agent Context Scripts

##### Bash script (`scripts/bash/update-agent-context.sh`)

Add file variable:

```bash
WINDSURF_FILE="$REPO_ROOT/.windsurf/rules/research-rules.md"
```

Add to case statement:

```bash
case "$AGENT_TYPE" in
  # ... existing cases ...
  windsurf) update_agent_file "$WINDSURF_FILE" "Windsurf" ;;
  "")
    # ... existing checks ...
    [ -f "$WINDSURF_FILE" ] && update_agent_file "$WINDSURF_FILE" "Windsurf";
    # Update default creation condition
    ;;
esac
```

##### PowerShell script (`scripts/powershell/update-agent-context.ps1`)

Add file variable:

```powershell
$windsurfFile = Join-Path $repoRoot '.windsurf/rules/research-rules.md'
```

Add to switch statement:

```powershell
switch ($AgentType) {
    # ... existing cases ...
    'windsurf' { Update-AgentFile $windsurfFile 'Windsurf' }
    '' {
        foreach ($pair in @(
            # ... existing pairs ...
            @{file=$windsurfFile; name='Windsurf'}
        )) {
            if (Test-Path $pair.file) { Update-AgentFile $pair.file $pair.name }
        }
        # Update default creation condition
    }
}
```

#### 6. Update CLI Tool Checks (Optional)

For agents that require CLI tools, add checks in the `check()` command and agent validation:

```python
# In check() command
tracker.add("windsurf", "Windsurf IDE (optional)")
windsurf_ok = check_tool_for_tracker("windsurf", "https://windsurf.com/", tracker)

# In init validation (only if CLI tool required)
elif selected_ai == "windsurf":
    if not check_tool("windsurf", "Install from: https://windsurf.com/"):
        console.print("[red]Error:[/red] Windsurf CLI is required for Windsurf research projects")
        agent_tool_missing = True
```

**Note**: CLI tool checks are now handled automatically based on the `requires_cli` field in AGENT_CONFIG. No additional code changes needed in the `check()` or `init()` commands - they automatically loop through AGENT_CONFIG and check tools as needed.

## Important Design Decisions

### Using Actual CLI Tool Names as Keys

**CRITICAL**: When adding a new agent to AGENT_CONFIG, always use the **actual executable name** as the dictionary key, not a shortened or convenient version.

**Why this matters:**

- The `check_tool()` function uses `shutil.which(tool)` to find executables in the system PATH
- If the key doesn't match the actual CLI tool name, you'll need special-case mappings throughout the codebase
- This creates unnecessary complexity and maintenance burden

**Example - The Cursor Lesson:**

❌ **Wrong approach** (requires special-case mapping):

```python
AGENT_CONFIG = {
    "cursor": {  # Shorthand that doesn't match the actual tool
        "name": "Cursor",
        # ...
    }
}

# Then you need special cases everywhere:
cli_tool = agent_key
if agent_key == "cursor":
    cli_tool = "cursor-agent"  # Map to the real tool name
```

✅ **Correct approach** (no mapping needed):

```python
AGENT_CONFIG = {
    "cursor-agent": {  # Matches the actual executable name
        "name": "Cursor",
        # ...
    }
}

# No special cases needed - just use agent_key directly!
```

**Benefits of this approach:**

- Eliminates special-case logic scattered throughout the codebase
- Makes the code more maintainable and easier to understand
- Reduces the chance of bugs when adding new agents
- Tool checking "just works" without additional mappings

#### 7. Update Devcontainer files (Optional)

For agents that have VS Code extensions or require CLI installation, update the devcontainer configuration files:

##### VS Code Extension-based Agents

For agents available as VS Code extensions, add them to `.devcontainer/devcontainer.json`:

```json
{
  "customizations": {
    "vscode": {
      "extensions": [
        // ... existing extensions ...
        // [New Agent Name]
        "[New Agent Extension ID]"
      ]
    }
  }
}
```

##### CLI-based Agents

For agents that require CLI tools, add installation commands to `.devcontainer/post-create.sh`:

```bash
#!/bin/bash

# Existing installations...

echo -e "\n🤖 Installing [New Agent Name] CLI..."
# run_command "npm install -g [agent-cli-package]@latest" # Example for node-based CLI
# or other installation instructions (must be non-interactive and compatible with Linux Debian "Trixie" or later)...
echo "✅ Done"

```

**Quick Tips:**

- **Extension-based agents**: Add to the `extensions` array in `devcontainer.json`
- **CLI-based agents**: Add installation scripts to `post-create.sh`
- **Hybrid agents**: May require both extension and CLI installation
- **Test thoroughly**: Ensure installations work in the devcontainer environment

## Agent Categories

### CLI-Based Agents

Require a command-line tool to be installed:

- **Claude Code**: `claude` CLI
- **Gemini CLI**: `gemini` CLI  
- **Cursor**: `cursor-agent` CLI
- **Qwen Code**: `qwen` CLI
- **opencode**: `opencode` CLI
- **Amazon Q Developer CLI**: `q` CLI
- **CodeBuddy CLI**: `codebuddy` CLI
- **Amp**: `amp` CLI

### IDE-Based Agents

Work within integrated development environments:

- **GitHub Copilot**: Built into VS Code/compatible editors
- **Windsurf**: Built into Windsurf IDE

## Command File Formats

### Markdown Format

Used by: Claude, Cursor, opencode, Windsurf, Amazon Q Developer, Amp

```markdown
---
description: "Command description"
---

Research command content with {SCRIPT} and $ARGUMENTS placeholders.
Example: /research.define, /research.methodology, /research.analyze
```

### TOML Format

Used by: Gemini, Qwen

```toml
description = "Command description"

prompt = """
Research command content with {SCRIPT} and {{args}} placeholders.
Example: /research.define, /research.methodology, /research.analyze
"""
```

## Directory Conventions

- **CLI agents**: Usually `.<agent-name>/commands/`
- **IDE agents**: Follow IDE-specific patterns:
  - Copilot: `.github/prompts/`
  - Cursor: `.cursor/commands/`
  - Windsurf: `.windsurf/workflows/`

## Argument Patterns

Different agents use different argument placeholders:

- **Markdown/prompt-based**: `$ARGUMENTS`
- **TOML-based**: `{{args}}`
- **Script placeholders**: `{SCRIPT}` (replaced with actual script path)
- **Agent placeholders**: `__AGENT__` (replaced with agent name)

## Testing New Agent Integration

1. **Build test**: Run package creation script locally
2. **CLI test**: Test `research init --ai <agent>` command
3. **File generation**: Verify correct directory structure and files for research projects
4. **Command validation**: Ensure generated research commands work with the agent (`/research.define`, `/research.methodology`, etc.)
5. **Context update**: Test agent context update scripts
6. **Research workflow**: Verify the complete research workflow functions correctly (definition → methodology → analysis → publication)

## Common Pitfalls

1. **Using shorthand keys instead of actual CLI tool names**: Always use the actual executable name as the AGENT_CONFIG key (e.g., `"cursor-agent"` not `"cursor"`). This prevents the need for special-case mappings throughout the codebase.
2. **Forgetting update scripts**: Both bash and PowerShell scripts must be updated when adding new agents.
3. **Incorrect `requires_cli` value**: Set to `True` only for agents that actually have CLI tools to check; set to `False` for IDE-based agents.
4. **Wrong argument format**: Use correct placeholder format for each agent type (`$ARGUMENTS` for Markdown, `{{args}}` for TOML).
5. **Directory naming**: Follow agent-specific conventions exactly (check existing agents for patterns).
6. **Help text inconsistency**: Update all user-facing text consistently (help strings, docstrings, README, error messages).

## Future Considerations

When adding new agents:

- Consider the agent's native command/workflow patterns
- Ensure compatibility with the Systematic Research Development process
- Verify the agent can handle research-specific tasks (literature review, citation management, methodology design)
- Consider research ethics and data quality requirements
- Document any special requirements or limitations
- Update this guide with lessons learned
- Verify the actual CLI tool name before adding to AGENT_CONFIG

## Research-Specific Guidance for AI Agents

When working with research projects, AI agents should be configured to:

### Citation Management
- Properly format citations according to specified style guides (APA, MLA, Chicago, etc.)
- Track and validate source URLs and DOIs
- Maintain bibliographic data integrity

### Source Quality
- Evaluate source credibility (peer-reviewed journals, conference proceedings, reputable institutions)
- Flag potential predatory journals or unreliable sources
- Verify publication dates and relevance
- Check for retracted papers or disputed findings

### Research Ethics
- Identify potential ethical concerns in research design
- Flag issues with data privacy, informed consent, or research integrity
- Ensure compliance with institutional review requirements
- Recognize potential conflicts of interest

### Methodology Rigor
- Validate research methodologies are appropriate for research questions
- Check statistical approaches and sample size justifications
- Ensure reproducibility through detailed documentation
- Identify potential biases or confounding factors

### Academic Writing
- Maintain formal academic tone and structure
- Ensure logical flow from research question through conclusions
- Verify claims are supported by evidence
- Check for plagiarism risks and proper attribution

---

*This documentation should be updated whenever new agents are added to maintain accuracy and completeness.*
