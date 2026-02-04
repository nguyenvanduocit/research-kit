<div align="center">
    <img src="./media/logo_small.webp" alt="Research Kit Logo"/>
    <h1>Research Kit</h1>
    <h3><em>Deep Research Toolkit for AI Agents</em></h3>
</div>

<p align="center">
    <strong>An open source toolkit for conducting structured, rigorous research with AI agents. Move beyond ad-hoc queries to systematic investigation with quality standards and reproducible methodologies.</strong>
</p>

<p align="center">
    <a href="https://github.com/nguyenvanduocit/research-kit/actions/workflows/release.yml"><img src="https://github.com/nguyenvanduocit/research-kit/actions/workflows/release.yml/badge.svg" alt="Release"/></a>
    <a href="https://github.com/nguyenvanduocit/research-kit/stargazers"><img src="https://img.shields.io/github/stars/nguyenvanduocit/research-kit?style=social" alt="GitHub stars"/></a>
    <a href="https://github.com/nguyenvanduocit/research-kit/blob/main/LICENSE"><img src="https://img.shields.io/github/license/nguyenvanduocit/research-kit" alt="License"/></a>
</p>

---

## Origin & Motivation

Research Kit is a fork of [Spec Kit](https://github.com/github/spec-kit) by GitHub, originally built as a personal project to adapt the Specification-Driven Development (SDD) workflow for systematic research.

The deeper motivation behind this project is to demonstrate a simple but powerful idea: **AI agents perform significantly better when guided by multiple structured phases and template constraints**. Instead of asking an AI to "do research" in a single open-ended prompt, Research Kit breaks the process into 10 distinct phases, each with its own template, quality standards, and output expectations. This structured approach:

- **Reduces hallucination** by constraining AI output to specific, well-defined templates at each phase
- **Improves consistency** by enforcing the same methodology across different research topics
- **Enables quality control** by making each phase reviewable before proceeding to the next
- **Produces better results** by giving the AI clear context boundaries instead of unbounded instructions

If you've ever noticed that AI gives better answers when you break a complex question into smaller parts, Research Kit applies that principle systematically to the entire research workflow.

For details on what changed from the upstream Spec Kit, see [The Fork](./docs/the-fork.md).

## Table of Contents

- [Origin & Motivation](#origin--motivation)
- [What is Research Kit?](#what-is-research-kit)
- [The Problem](#the-problem)
- [Who It's For](#who-its-for)
- [Key Features](#key-features)
- [Quick Start](#quick-start)
- [Research Workflow](#research-workflow)
- [Research Types](#research-types)
- [Supported AI Agents](#supported-ai-agents)
- [Installation](#installation)
- [Research CLI Reference](#research-cli-reference)
- [Example Output](#example-output)
- [Documentation](#documentation)
- [Prerequisites](#prerequisites)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## What is Research Kit?

Research Kit is a structured research framework designed for AI agents. It transforms ad-hoc prompting into systematic investigation by providing:

- **Multi-phase research workflow** - From defining research questions to executing comprehensive studies
- **Quality standards enforcement** - Built-in principles for source evaluation, methodology rigor, and bias mitigation
- **Research type specialization** - Tailored approaches for academic, market, technical, and general research
- **Reproducible methodologies** - Documented approaches that can be validated and replicated
- **Citation management** - Integrated BibTeX support for proper source attribution
- **AI agent integration** - Works with Claude Code and Codex CLI

## The Problem

Traditional AI interactions treat research as a single-shot query: you ask a question, get an answer, and hope it's accurate. This approach struggles with:

- **Lack of source transparency** - Where did this information come from?
- **No methodology documentation** - How was this answer derived?
- **Inconsistent quality** - Results vary wildly between queries
- **No bias mitigation** - Unexamined assumptions baked into responses
- **Poor reproducibility** - Can't validate or build on previous research

Research Kit solves this by making research a **structured, auditable process** rather than a black-box interaction.

## Who It's For

Research Kit is designed for anyone who needs rigorous, documented research:

- **Researchers & Academics** - Literature reviews, hypothesis exploration, methodology design
- **Business Analysts** - Market research, competitive analysis, trend investigation
- **Technical Writers** - Technology evaluations, framework comparisons, best practices documentation
- **Consultants** - Client research, industry analysis, strategic recommendations
- **Students** - Term papers, thesis research, learning new domains
- **Product Managers** - User research synthesis, feature validation, market positioning

If you need **defensible conclusions backed by documented sources and transparent methodology**, Research Kit is for you.

## Key Features

### Structured Research Workflow

Research Kit guides you through a systematic 10-phase process:

1. **Principles** - Establish research quality standards and ethical guidelines
2. **Define** - Articulate research questions, objectives, and scope
3. **Refine** - Clarify ambiguities and sharpen focus (optional)
4. **Methodology** - Design research approach and data collection strategy
5. **Validate** - Review feasibility and identify potential issues (optional)
6. **Tasks** - Break down research into executable activities
7. **Execute** - Conduct research and collect data
8. **Analyze** - Process data and generate statistical insights
9. **Synthesize** - Draw conclusions and answer research questions
10. **Publish** - Create publication-ready outputs (reports, papers, presentations)

### Multiple Research Types

Specialized templates and guidance for different research domains:

- **Academic Research** - Literature reviews, peer-reviewed sources, scholarly rigor
- **Market/Business Research** - Industry analysis, competitive intelligence, market trends
- **Technical Research** - Technology evaluations, architecture decisions, implementation strategies
- **General Investigation** - Open-ended exploration, cross-domain synthesis, curiosity-driven inquiry

### Research Quality Standards

Built-in enforcement of research best practices:

- **Source Quality** - Distinction between primary/secondary sources, peer review status, recency
- **Methodology Rigor** - Explicit research design, assumption documentation, limitation acknowledgment
- **Ethics & Bias** - Conflict of interest disclosure, bias mitigation, diverse perspective inclusion
- **Citation Standards** - Proper attribution with BibTeX format, source accessibility
- **Analysis Quality** - Transparent frameworks, data interpretation rationale, alternative explanations
- **Report Completeness** - Executive summaries, methodology sections, supported findings, justified conclusions

### AI Agent Compatibility

Works seamlessly with popular AI coding agents through slash commands and structured prompts.

### Research Agents

In addition to slash commands, Research Kit provides **custom agents** for autonomous multi-step workflows:

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| **agent-research-assistant** | Full SRD workflow orchestrator | Starting new research, guided workflow |
| **agent-research-reviewer** | Quality assurance specialist | Validating research, checking rigor |
| **agent-literature-specialist** | Literature review expert | Conducting systematic literature reviews, source evaluation |
| **agent-analysis-expert** | Data analysis specialist | Statistical analysis, visualization, pattern discovery |
| **agent-data-collector** | Data collection specialist | Web scraping, API integration, systematic data gathering |
| **agent-academic-writer** | Academic writing specialist | Creating publication-ready research outputs |

**Agent Invocation:**
- Use `@agent-name` syntax to invoke a specific agent (e.g., `@agent-research-reviewer`)
- Agents have specialized knowledge and tools for their domain
- Slash commands suggest relevant agents at completion (e.g., "ask `@agent-research-reviewer` to validate the definition")

**Agents vs Slash Commands:**
- **Agents** have isolated context and handle complex multi-step workflows autonomously
- **Slash commands** are lightweight utilities for single-step tasks within your main conversation

Agents are deployed to agent-specific locations (e.g., `.claude/agents/`) and can be invoked using `@agent-name` mentions.

## Quick Start

### 1. Install Research CLI

Choose your preferred installation method:

#### Option 1: Persistent Installation (Recommended)

Install once and use everywhere:

```bash
uv tool install research-cli --force --from git+https://github.com/nguyenvanduocit/research-kit.git
```

Then use the tool directly:

```bash
research init my-research-project
research check
```

To upgrade:

```bash
uv tool install research-cli --force --from git+https://github.com/nguyenvanduocit/research-kit.git
```

#### Option 2: One-time Usage

Run directly without installing:

```bash
uvx --from git+https://github.com/nguyenvanduocit/research-kit.git research init my-research-project
```

### 2. Establish Research Principles

Launch your AI assistant in the project directory. The `/research.*` commands are available.

Use the **`/research.principles`** command to establish your research quality standards:

```bash
/research.principles Create principles focused on academic rigor, peer-reviewed sources, bias mitigation, and transparent methodology. Include ethical guidelines for data handling and citation standards.
```

### 3. Define Research Question

Use the **`/research.define`** command to articulate what you want to investigate:

```bash
/research.define I need to understand the current state of AI agent frameworks for software development. What are the leading approaches, their strengths/weaknesses, adoption trends, and future directions? Target audience is engineering leadership making tooling decisions.
```

### 4. Design Research Methodology

Use the **`/research.methodology`** command to plan your research approach:

```bash
/research.methodology Conduct academic research focused on peer-reviewed papers, industry reports, and framework documentation. Include quantitative analysis of GitHub stars/activity and qualitative assessment of architectural patterns. Timeline: 2 weeks.
```

### 5. Break Down Research Tasks

Use **`/research.tasks`** to create an actionable research plan:

```bash
/research.tasks
```

### 6. Execute Research

Use the following commands to conduct and complete your research:

```bash
/research.execute    # Collect data and conduct research
/research.analyze    # Analyze collected data
/research.synthesize # Draw conclusions from findings
/research.publish    # Create final research outputs
```

## Research Workflow

Research Kit implements a structured 10-phase workflow designed to ensure quality, reproducibility, and defensibility:

### Phase 1: Principles - Establish Research Standards

Define the quality standards that will govern your research:

- Source evaluation criteria (peer review, primary vs secondary, recency)
- Methodology requirements (rigor, documentation, limitations)
- Ethical guidelines (bias mitigation, conflicts of interest, diverse perspectives)
- Citation standards (format, attribution, accessibility)
- Analysis frameworks (interpretation rules, confidence levels, alternative explanations)
- Report requirements (structure, completeness, justification standards)

**Output**: `/principles/research-principles.md`

### Phase 2: Define - Articulate Research Questions

Clearly state what you're investigating and why:

- Primary research question and sub-questions
- Research objectives and success criteria
- Scope and boundaries (what's included/excluded)
- Target audience and intended use
- Background context and motivation
- Key terms and definitions

**Output**: `/research/<research-id>/definition.md`

### Phase 3: Refine - Clarify Scope (Optional)

Interactive clarification to address ambiguities:

- Structured questioning to identify underspecified areas
- Scope refinement and boundary clarification
- Assumption surfacing and validation
- Stakeholder alignment on research direction

**Output**: Updates to `definition.md` with Clarifications section

### Phase 4: Methodology - Design Research Approach

Plan how you'll conduct the research:

- Research type selection (academic, market, technical, general)
- Data collection strategy (sources, search terms, inclusion/exclusion criteria)
- Analysis framework (how you'll synthesize findings)
- Timeline and milestones
- Resource requirements
- Quality assurance approach

**Output**: `/research/<research-id>/methodology.md`

### Phase 5: Validate - Review Feasibility (Optional)

Check for potential issues before investing effort:

- Source availability and accessibility
- Timeline realism
- Resource constraint validation
- Methodology soundness review
- Bias and blind spot identification

**Output**: Updates to `methodology.md` with Validation section

### Phase 6: Tasks - Break Down Activities

Convert methodology into executable steps:

- Literature search tasks (by domain, source type, time period)
- Data collection activities (interviews, surveys, experiments)
- Analysis tasks (coding, synthesis, pattern identification)
- Writing tasks (sections, drafts, reviews)
- Dependency mapping and parallel work identification

**Output**: `/research/<research-id>/tasks.md`

### Phase 7: Execute - Conduct Research & Collect Data

Execute the research methodology to gather data:

- Implement data collection protocols
- Conduct experiments or surveys as designed
- Gather literature and documentary evidence
- Record observations systematically
- Track execution progress and deviations
- Maintain data quality and integrity

**Output**: `/research/<research-id>/execution.md`, `/research/<research-id>/data/`, `/research/<research-id>/logs/`

### Phase 8: Analyze - Process Data & Generate Insights

Analyze collected data using appropriate methods:

- Clean and prepare data for analysis
- Apply statistical tests and models
- Generate visualizations and figures
- Identify patterns and relationships
- Compare findings with literature
- Document all analysis decisions

**Output**: `/research/<research-id>/analysis.md`, `/research/<research-id>/figures/`, `/research/<research-id>/tables/`

### Phase 9: Synthesize - Draw Conclusions

Integrate findings to answer research questions:

- Connect findings to research questions
- Identify emergent themes and patterns
- Build theoretical contributions
- Develop practical implications
- Assess confidence in conclusions
- Acknowledge limitations honestly

**Output**: `/research/<research-id>/synthesis.md`, `/research/<research-id>/models/`

### Phase 10: Publish - Create Publication Outputs

Transform research into publication-ready formats:

- Generate comprehensive research reports
- Create academic papers for journals
- Develop presentations for stakeholders
- Write executive briefs for decision-makers
- Format citations and bibliographies
- Prepare submission packages

**Output**: `/research/<research-id>/publications/`, `/research/<research-id>/bibliography.bib`

## Research Types

Research Kit supports four specialized research approaches:

### Academic Research

**Focus**: Scholarly rigor, peer-reviewed sources, theoretical frameworks

**Best For**:
- Literature reviews
- Theory development
- Hypothesis testing
- Academic paper preparation
- Systematic reviews

**Standards**:
- Prioritize peer-reviewed journals and academic presses
- Document search strategies (databases, terms, filters)
- Use established analytical frameworks (PRISMA, etc.)
- Comprehensive citation with DOIs
- Acknowledge limitations and future research directions

### Market/Business Research

**Focus**: Industry trends, competitive analysis, business intelligence

**Best For**:
- Market opportunity assessment
- Competitive landscape mapping
- Customer research synthesis
- Strategic decision support
- Investment due diligence

**Standards**:
- Balance authoritative sources (industry reports, financial data) with emerging signals (news, social media)
- Triangulate findings across multiple source types
- Distinguish fact from opinion/projection
- Consider source incentives and potential bias
- Include both quantitative metrics and qualitative insights

### Technical Research

**Focus**: Technology evaluation, implementation strategies, architecture decisions

**Best For**:
- Framework/library comparisons
- Architecture pattern evaluation
- Tool selection decisions
- Best practices documentation
- Technology trend analysis

**Standards**:
- Prioritize official documentation and maintainer guidance
- Include hands-on testing or proof-of-concept validation
- Document version specificity and compatibility
- Assess community health and long-term viability
- Consider maintenance burden and total cost of ownership

### General Investigation

**Focus**: Open-ended exploration, cross-domain synthesis, curiosity-driven inquiry

**Best For**:
- Learning new domains
- Exploratory research without fixed hypothesis
- Connecting disparate topics
- Building mental models
- Answering complex "why" or "how" questions

**Standards**:
- Start broad, narrow based on findings
- Document reasoning for source selection and synthesis
- Acknowledge uncertainty and confidence levels
- Seek diverse perspectives explicitly
- Build clear narrative from evidence to conclusions

## Supported AI Agents

Research Kit is optimized for CLI-based AI agents:

| Agent                                                | Support | Notes                                 |
|------------------------------------------------------|---------|---------------------------------------|
| [Claude Code](https://www.anthropic.com/claude-code) | ✅       | Full support with agents and commands |
| [Codex CLI](https://github.com/openai/codex)         | ✅       | Full research workflow support        |

## Installation

### Requirements

- **Linux/macOS/Windows**
- [uv](https://docs.astral.sh/uv/) for package management
- [Python 3.11+](https://www.python.org/downloads/)
- [Supported AI agent](#supported-ai-agents)
- [Git](https://git-scm.com/downloads) (optional, for version control)

### Install with uv (Recommended)

```bash
# Persistent installation
uv tool install research-cli --force --from git+https://github.com/nguyenvanduocit/research-kit.git

# Verify installation
research check
```

### Install with pip

```bash
pip install git+https://github.com/nguyenvanduocit/research-kit.git
```

### Upgrade

```bash
# With uv
uv tool install research-cli --force --from git+https://github.com/nguyenvanduocit/research-kit.git

# With pip
pip install --upgrade git+https://github.com/nguyenvanduocit/research-kit.git
```

## Research CLI Reference

The `research` command supports the following options:

### Commands

| Command     | Description                                                    |
|-------------|----------------------------------------------------------------|
| `init`      | Initialize a new Research Kit project from the latest template |
| `check`     | Check for installed tools and AI agents                        |

### `research init` Arguments & Options

| Argument/Option        | Type     | Description                                                                  |
|------------------------|----------|------------------------------------------------------------------------------|
| `<project-name>`       | Argument | Name for your new research project directory (optional if using `--here`, or use `.` for current directory) |
| `--ai`                 | Option   | AI assistant to use: `claude` or `codex`                                     |
| `--ignore-agent-tools` | Flag     | Skip checks for AI agent tools                                               |
| `--no-git`             | Flag     | Skip git repository initialization                                          |
| `--here`               | Flag     | Initialize project in the current directory instead of creating a new one   |
| `--force`              | Flag     | Force merge/overwrite when initializing in current directory (skip confirmation) |
| `--skip-tls`           | Flag     | Skip SSL/TLS verification (not recommended)                                 |
| `--debug`              | Flag     | Enable detailed debug output for troubleshooting                            |
| `--github-token`       | Option   | GitHub token for API requests (or set GH_TOKEN/GITHUB_TOKEN env variable)  |

### Examples

```bash
# Basic project initialization
research init literature-review

# Initialize with Claude Code
research init market-analysis --ai claude

# Initialize with Codex CLI
research init tech-evaluation --ai codex

# Initialize in current directory
research init . --ai claude
# or use the --here flag
research init --here --ai codex

# Force merge into current (non-empty) directory
research init . --force --ai claude

# Skip git initialization
research init my-research --ai codex --no-git

# Enable debug output
research init my-research --ai claude --debug

# Use GitHub token for API requests
research init my-research --ai claude --github-token ghp_your_token_here

# Check system requirements
research check
```

### Available Slash Commands

After running `research init`, your AI agent will have access to these research commands:

#### Core Research Commands

Essential commands for the Research Kit workflow:

| Command                    | Description                                                           |
|----------------------------|-----------------------------------------------------------------------|
| `/research.principles`     | Create or update research quality standards and ethical guidelines    |
| `/research.define`         | Define research question, objectives, and scope                       |
| `/research.methodology`    | Design research approach and data collection strategy                 |
| `/research.tasks`          | Generate actionable research task breakdown                           |
| `/research.execute`        | Conduct research and collect data systematically                     |
| `/research.analyze`        | Analyze collected data and generate insights                         |
| `/research.synthesize`     | Synthesize findings and draw conclusions                             |
| `/research.publish`        | Create publication-ready outputs (reports, papers, presentations)     |

#### Optional Research Commands

Additional commands for enhanced research quality:

| Command                | Description                                                           |
|------------------------|-----------------------------------------------------------------------|
| `/research.refine`     | Clarify underspecified areas (recommended before `/research.methodology`) |
| `/research.validate`   | Review methodology feasibility and identify potential issues (run after `/research.methodology`, before `/research.tasks`) |
| `/research.quality`    | Generate custom quality checklists for research validation            |

### Environment Variables

| Variable         | Description                                                                                    |
|------------------|------------------------------------------------------------------------------------------------|
| `RESEARCH_ID`    | Override research ID detection for non-Git repositories. Set to the research directory name (e.g., `001-ai-agent-frameworks`) to work on a specific research project when not using Git branches. |

## Example Output

A completed research project generates the following structure:

```text
my-research-project/
├── principles/
│   └── research-principles.md        # Quality standards and ethical guidelines
├── research/
│   └── 001-ai-agent-frameworks/      # Research project directory
│       ├── definition.md             # Research question and scope
│       ├── methodology.md            # Research approach and strategy
│       ├── tasks.md                  # Actionable research breakdown
│       ├── execution.md              # Research execution log
│       ├── analysis.md               # Data analysis and insights
│       ├── synthesis.md              # Conclusions and findings
│       ├── publications/             # Publication-ready outputs
│       │   ├── report.md             # Comprehensive research report
│       │   ├── paper.md              # Academic paper (if applicable)
│       │   └── presentation.md       # Executive presentation
│       ├── data/                     # Collected research data
│       ├── figures/                  # Charts and visualizations
│       ├── tables/                   # Data tables
│       └── bibliography.bib          # BibTeX citation database
└── templates/
    ├── definition-template.md        # Template for new research questions
    ├── methodology-template.md       # Template for research approaches
    ├── tasks-template.md             # Template for task breakdowns
    └── report-template.md            # Template for research reports
```

### Sample Report Structure

Research reports follow a standardized structure for clarity and reproducibility:

```markdown
# Research Report: AI Agent Frameworks for Software Development

## Executive Summary
High-level findings, key conclusions, actionable recommendations (2-3 paragraphs)

## Research Question & Objectives
- Primary question: What are the leading AI agent frameworks for software development?
- Sub-questions: Strengths/weaknesses, adoption trends, future directions
- Success criteria: Comprehensive landscape mapping with actionable recommendations

## Methodology
- Research type: Technical Research
- Sources: Academic papers (10), industry reports (5), framework docs (15), GitHub metrics
- Search strategy: Google Scholar, arXiv, GitHub trending, Stack Overflow surveys
- Analysis framework: Comparative evaluation matrix (features, adoption, maturity, ecosystem)
- Timeline: 2 weeks (Jan 15 - Jan 29, 2025)

## Findings
### Theme 1: Framework Architecture Patterns
- Evidence from sources [1], [3], [7]
- Key insight: Three dominant patterns (agentic, workflow-based, hybrid)
- Supporting data: GitHub star trends, adoption curves

### Theme 2: Adoption Drivers
- Evidence from sources [2], [5], [9]
- Key insight: Developer experience beats raw capability in adoption

[Additional themes...]

## Analysis
- Cross-theme patterns and tensions
- Alternative interpretations considered
- Confidence levels and uncertainty acknowledgment
- Implications for engineering leadership

## Conclusions
- Direct answers to research questions
- Actionable recommendations
- Limitations and caveats
- Future research directions

## References
[1] Smith, J. et al. (2024). "Agentic AI Frameworks: A Survey." Journal of Software Engineering...
[2] Chen, L. (2024). "State of AI Development Tools 2024." Industry Report...
[Full BibTeX in bibliography.bib]
```

## Documentation

- **[Complete Research-Driven Investigation Methodology](./research-driven.md)** - Deep dive into the research process
- **[Agent Integration Guide](./AGENTS.md)** - Integration instructions and agent development guide
- **[Contributing Guide](./CONTRIBUTING.md)** - How to contribute to Research Kit
- **[Support Resources](./SUPPORT.md)** - Getting help and reporting issues

## Prerequisites

Before using Research Kit, ensure you have:

- **Operating System**: Linux, macOS, or Windows
- **Python**: Version 3.11 or higher ([download](https://www.python.org/downloads/))
- **Package Manager**: [uv](https://docs.astral.sh/uv/) (recommended) or pip
- **AI Agent**: One of the [supported AI coding agents](#supported-ai-agents)
- **Git** (optional): For version control and branch-based research organization

Most users will have Python and pip already installed. To install uv:

```bash
# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

## Troubleshooting

### Git Credential Manager on Linux

If you're having issues with Git authentication on Linux, install Git Credential Manager:

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

### SSL/TLS Certificate Issues

If you encounter SSL certificate errors (common in corporate environments):

```bash
# Temporary workaround (not recommended for production)
research init my-project --skip-tls

# Better solution: Install certificates
# macOS
pip install certifi

# Linux
sudo apt-get install ca-certificates
```

### Command Not Found After Installation

If `research` command is not found after installation:

```bash
# Check uv tool installation
uv tool list

# Reinstall with explicit path
uv tool install research-cli --force --from git+https://github.com/nguyenvanduocit/research-kit.git

# Verify PATH includes uv tools directory
echo $PATH | grep -q ".local/bin" || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Agent Not Detected

If the CLI doesn't detect your AI agent:

```bash
# Check if agent is in PATH
which claude     # or codex

# Skip agent check and install anyway
research init my-project --ignore-agent-tools --ai claude
```

### For More Help

- Open an [issue on GitHub](https://github.com/nguyenvanduocit/research-kit/issues/new)
- Check the [SUPPORT.md](./SUPPORT.md) guide
- Review [agent-specific documentation](./AGENTS.md)

## Contributing

We welcome contributions to Research Kit! Here's how you can help:

### Ways to Contribute

- **Report bugs** - Found something broken? [Open an issue](https://github.com/nguyenvanduocit/research-kit/issues/new)
- **Suggest features** - Have ideas for new research types or workflow improvements? We'd love to hear them
- **Improve documentation** - Help make Research Kit easier to use
- **Add agent support** - Integrate new AI coding agents
- **Enhance templates** - Improve research templates and quality standards
- **Share research examples** - Contribute example research projects

### Getting Started

1. Read the [Contributing Guide](./CONTRIBUTING.md)
2. Check the [Code of Conduct](./CODE_OF_CONDUCT.md)
3. Look for ["good first issue"](https://github.com/nguyenvanduocit/research-kit/labels/good%20first%20issue) labels
4. Fork the repository and make your changes
5. Submit a pull request

### Development Setup

```bash
# Clone the repository
git clone https://github.com/nguyenvanduocit/research-kit.git
cd research-kit

# Install dependencies with uv
uv sync

# Run the CLI locally
uv run research --help

# Test your changes
uv run research init test-project --ai claude
```

For detailed development instructions, see [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

This project is licensed under the terms of the MIT open source license. Please refer to the [LICENSE](./LICENSE) file for the full terms.

## Acknowledgements

Research Kit is a fork of [Spec Kit](https://github.com/github/spec-kit) by GitHub. The original project focuses on Specification-Driven Development (SDD) for software engineering. Research Kit adapts the same multi-phase, template-constrained approach for systematic research workflows.

Special thanks to the GitHub team for creating Spec Kit and demonstrating that structured constraints make AI agents dramatically more effective.

---

<p align="center">
    <strong>Start conducting rigorous, reproducible research with AI agents today.</strong><br/>
    <code>uv tool install research-cli --force --from git+https://github.com/nguyenvanduocit/research-kit.git</code>
</p>
