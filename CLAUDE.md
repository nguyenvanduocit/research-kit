# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Research Kit** is an open source toolkit for Systematic Research Development (SRD). It provides a `research` CLI tool that bootstraps research projects with templates, scripts, and slash commands that enable AI research assistants to follow a structured workflow: define research topics, design methodologies, conduct analysis, and prepare publications.

## Common Commands

### Development & Testing

```bash
# Install dependencies and create virtual environment
uv sync

# Run the CLI tool
uv run research --help
uv run research init <research-project-name>
uv run research check

# Test CLI functionality
uv run research init test-research-project --ai claude
```

### Testing Local Changes

When developing templates, commands, or scripts:

```bash
# Generate local release packages (replace v1.0.0 with desired version)
./.github/workflows/scripts/create-release-packages.sh v1.0.0

# Copy package to test research project
cp -r .genreleases/research-claude-package/. <path-to-test-research-project>/

# Example for Claude
cp -r .genreleases/research-claude-package/. ~/test-research-project/

# Example for Codex
cp -r .genreleases/research-codex-package/. ~/test-research-project/
```

## Repository Structure

### Core Components

- **`src/research_cli/__init__.py`**: Main CLI implementation (Python 3.11+)
  - Handles research project initialization, agent detection, template deployment
  - Supports Claude Code and Codex CLI
  - Features: topic management, template customization, prerequisite checking

- **`templates/`**: Source templates for all generated files
  - `commands/*.md`: Slash command definitions (`/research.define`, `/research.methodology`, `/research.analyze`, `/research.publish`, etc.)
  - `agents/*.md`: Agent definitions (all use `agent-` prefix):
    - `agent-research-assistant.md`: Full SRD workflow orchestrator
    - `agent-research-reviewer.md`: Quality assurance specialist
    - `agent-literature-specialist.md`: Literature review expert
    - `agent-analysis-expert.md`: Data analysis specialist
    - `agent-data-collector.md`: Data collection specialist
    - `agent-academic-writer.md`: Academic writing specialist
  - `research-definition-template.md`, `methodology-template.md`, `analysis-template.md`: Document templates
  - `agent-file-template.md`: Agent-specific context file template

- **`scripts/bash/`**: Automation scripts deployed to research projects
  - `common.sh`: Shared utilities (repo root detection, branch detection, topic number extraction)
  - `create-new-research.sh`: Creates research topic branches, manages numbering, prevents duplicates
  - `setup-methodology.sh`: Prepares directories and templates for research methodology planning
  - `check-prerequisites.sh`: Validates required tools and environment
  - `update-agent-context.sh`: Updates agent-specific CLAUDE.md/context files

- **`principles/research-principles.md`**: Template for research governance principles
  - Defines research standards, ethical requirements, methodological constraints
  - Guides all AI decision-making during research definition and execution

### Documentation

- **`README.md`**: User-facing documentation, installation, and quick start
- **`research-driven.md`**: Deep dive into Systematic Research Development methodology
- **`AGENTS.md`**: Agent-specific integration details for research workflows
- **`CONTRIBUTING.md`**: Contribution workflow, testing local changes, PR guidelines

## Architecture

### The SRD Workflow

1. **Principles** (`/research.principles`): Establish research governance principles
2. **Definition** (`/research.define`): Define research topics and questions in natural language
   - Auto-generates topic numbers (001, 002, etc.) by scanning remote branches, local branches, and research directories
   - Creates research topic branches (`###-topic-name`)
   - Generates structured definitions from user descriptions
3. **Refine** (`/research.refine`): Interactive Q&A to clarify underspecified areas (optional)
4. **Methodology** (`/research.methodology`): Design research methodologies and approaches
   - Produces `methodology.md`, `literature-review.md`, `data-sources.md`, `ethics.md`
5. **Validate** (`/research.validate`): Review feasibility and identify potential issues (optional)
6. **Tasks** (`/research.tasks`): Break down research into executable activities
7. **Execute** (`/research.execute`): Conduct research and collect data
8. **Analyze** (`/research.analyze`): Process data and generate statistical insights
9. **Synthesize** (`/research.synthesize`): Draw conclusions and answer research questions
10. **Publish** (`/research.publish`): Create publication-ready outputs (reports, papers, presentations)

### Key Design Patterns

- **Branch-based Research Topics**: Each research topic lives on a numbered branch (`001-literature-review`, `002-methodology-design`)
- **Definition as Source of Truth**: Research outputs serve definitions, not the other way around
- **Template-driven Generation**: All documents follow consistent templates for AI parsing
- **Script Hooks**: Slash commands invoke bash scripts that manage git operations, file creation, and validation
- **Agent Support**: Templates and scripts support Claude Code and Codex CLI

### Branching & Numbering

The `create-new-research.sh` script ensures unique topic numbers by:
1. Fetching all remote branches (`git fetch --all --prune`)
2. Searching remote branches, local branches, and `research/` directories
3. Finding the highest existing number for the topic-name
4. Assigning `N+1` for the new branch

This prevents duplicate branch numbers when multiple researchers work on similar topics.

## Important Development Notes

### Python Project Structure

- Uses `pyproject.toml` with hatchling build backend
- Entry point: `research = "research_cli:main"`
- Dependencies: typer, rich, httpx, platformdirs, readchar, truststore
- Python 3.11+ required

### Testing Changes

Always test template/command changes locally before committing:
1. Generate release packages with the create-release-packages script
2. Copy to a test research project directory
3. Open the AI research assistant in the test project
4. Verify slash commands work correctly with research workflows

### Release Process

- Automated via `.github/workflows/release.yml`
- Triggers on pushes to `main` affecting `principles/`, `scripts/`, or `templates/`
- Auto-increments version, generates release notes, creates GitHub release
- Version stored in `pyproject.toml` (updated during release, not in main branch)

### Agent Support

The CLI supports Claude Code and Codex CLI. Configuration in `AGENT_CONFIG` dict:
- `folder`: Where agent files live (`.claude/`, `.codex/`)
- `requires_cli`: Whether CLI tool is needed
- `install_url`: Documentation link for CLI installation

## Non-Git Repository Support

Scripts support non-git environments via `RESEARCH_TOPIC` environment variable:
```bash
export RESEARCH_TOPIC="001-my-research-topic"
```

This allows SRD workflow in repositories without git (e.g., institutional environments with alternative VCS).

## File Conventions

- Slash commands: `.claude/commands/*.md`, `.codex/prompts/*.md`
- Agents: `.claude/agents/*.md` (all agent files use `agent-` prefix, e.g., `agent-research-assistant.md`)
- Research definitions: `research/###-topic-name/definition.md`
- Research methodologies: `research/###-topic-name/methodology.md`
- Literature reviews: `research/###-topic-name/literature-review.md`
- Data sources: `research/###-topic-name/data-sources.md`
- Execution logs: `research/###-topic-name/execution.md`
- Analysis results: `research/###-topic-name/analysis.md`
- Synthesis: `research/###-topic-name/synthesis.md`
- Publications: `research/###-topic-name/publications/` (papers, presentations, etc.)

## Agent Invocation

Agents are invoked using the `@agent-name` syntax within slash commands or conversation:
- `@agent-research-assistant` - For guided research workflow
- `@agent-research-reviewer` - For quality validation
- `@agent-literature-specialist` - For literature review tasks
- `@agent-analysis-expert` - For data analysis
- `@agent-data-collector` - For data collection
- `@agent-academic-writer` - For publication writing

## Key Configuration Files

- `pyproject.toml`: Package metadata, dependencies, entry points
- `templates/vscode-settings.json`: Recommended VS Code settings for research projects
- `.markdownlint-cli2.jsonc`: Markdown linting rules
- `.devcontainer/`: Dev container for contributors (Python, uv, git pre-installed)

## Development Philosophy

- **Simplicity Over Cleverness**: Code should be obvious and maintainable
- **Template Quality**: Templates directly affect thousands of AI-assisted research projects
- **Researcher Empowerment**: Researchers control the workflow, AI assists systematically
- **Research Rigor**: Maintain high standards for research methodology and academic integrity
- **Citation Accuracy**: Ensure proper attribution and source tracking
- **Ethical Compliance**: Support ethical research practices and institutional requirements
