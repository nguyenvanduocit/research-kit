# The Fork: From Spec Kit to Research Kit

**Last Updated**: 2025-11-22

---

## Table of Contents

1. [Overview](#overview)
2. [Why We Forked](#why-we-forked)
3. [Purpose and Goals](#purpose-and-goals)
4. [What Changed](#what-changed)
5. [Philosophy Differences](#philosophy-differences)
6. [Staying in Sync with Spec Kit](#staying-in-sync-with-spec-kit)
7. [For Contributors](#for-contributors)

---

## Overview

**Research Kit** is a fork of [Spec Kit](https://github.com/anthropics/spec-kit) by Anthropic, transformed from a **Specification-Driven Development (SDD)** toolkit into a **Systematic Research Development (SRD)** toolkit.

While Spec Kit helps developers build software applications through structured specifications, Research Kit helps researchers conduct systematic research through structured methodologies.

### Quick Comparison

| Aspect | Spec Kit | Research Kit |
|--------|----------|--------------|
| **Purpose** | Build software applications | Conduct systematic research |
| **Methodology** | Specification-Driven Development (SDD) | Systematic Research Development (SRD) |
| **Output** | Code, tests, implementations | Research findings, publications, analyses |
| **Workflow** | Define → Implement → Test → Verify | Define → Methodology → Analyze → Synthesize → Publish |
| **Users** | Software developers, engineers | Researchers, analysts, academics |
| **Success Criteria** | Tests pass, requirements met | Research questions answered, findings validated |

### Relationship

- **Upstream**: [anthropics/spec-kit](https://github.com/anthropics/spec-kit)
- **Fork**: [nguyenvanduocit/research-kit](https://github.com/nguyenvanduocit/research-kit)
- **Maintained By**: Community (independent from Anthropic/Spec Kit team)
- **License**: Same as Spec Kit (check LICENSE file)

---

## Why We Forked

### The Problem

Many researchers were interested in systematic, AI-assisted workflows similar to what Spec Kit provides for software development, but:

1. **Mismatch in Focus**: Spec Kit is explicitly for software implementation
2. **Different Workflows**: Research follows exploratory/analytical patterns, not implementation patterns
3. **Different Outputs**: Researchers need literature reviews, methodologies, and publications—not code
4. **Different Terminology**: "Specifications," "implementation," "tests" don't translate to research contexts

### The Solution

Rather than trying to adapt software development tools to research (awkward fit), we forked Spec Kit and transformed it into a research-native toolkit that:

1. **Speaks the language of research**: Research questions, methodologies, analysis, synthesis
2. **Follows research workflows**: Literature review → Data collection → Analysis → Publication
3. **Produces research outputs**: Methodology documents, literature reviews, findings, papers
4. **Maintains research rigor**: Ethical review, bias mitigation, validation, peer review

### Why Fork Instead of Extend?

We considered extending Spec Kit with research features, but decided to fork because:

- **Core conceptual differences**: Research is exploratory; software is prescriptive
- **Different user bases**: Researchers vs. developers have different mental models
- **Cleaner separation**: Prevents confusion between software and research workflows
- **Independent evolution**: Research Kit can evolve to serve researchers without compromising Spec Kit's software focus

---

## Purpose and Goals

### Primary Purpose

**Enable researchers to conduct high-quality, systematic research with AI assistance while maintaining research rigor, ethics, and reproducibility.**

### Core Goals

1. **Systematic Research Workflows**
   - Structured process from research question to publication
   - Templates and guardrails for research quality
   - Multi-phase research methodology (definition → methodology → analysis → synthesis → publication)

2. **AI-Assisted Research**
   - Work with multiple AI research assistants (Claude Code, GitHub Copilot, Gemini, etc.)
   - Consistent quality across different AI tools
   - Maintain human oversight and critical thinking

3. **Research Rigor**
   - Enforce research principles (ethics, bias mitigation, validation)
   - Support reproducibility through documentation
   - Follow research best practices (PRISMA, qualitative rigor criteria, etc.)

4. **Diverse Research Types**
   - Academic research (qualitative, quantitative, mixed methods)
   - Market research (competitive analysis, trend identification)
   - Technical research (technology evaluation, decision support)
   - Exploratory research (scoping, learning, discovery)

### Non-Goals

- ❌ Software development or code generation (use Spec Kit for that)
- ❌ Replacing human judgment in research
- ❌ Automating research without oversight
- ❌ Supporting low-quality or unethical research practices

---

## What Changed

### 1. Core Concepts

| Spec Kit Concept | Research Kit Concept | Why Changed |
|------------------|---------------------|-------------|
| Specifications | Research Topics | Research explores questions, not requirements |
| Implementation | Methodology | Research designs approaches, not code |
| Tests | Analysis | Research analyzes data, not software |
| Verification | Synthesis | Research synthesizes findings, not validates specs |
| Deployment | Publication | Research publishes findings, not applications |

### 2. Slash Commands

> **Note**: Research Kit recently simplified its command prefix from `/researchkit.` to `/research.` for better usability (November 2025).

| Spec Kit | Research Kit | Purpose |
|----------|--------------|---------|
| `/speckit.define` | `/research.define` | Define research questions and scope |
| `/speckit.clarify` | `/research.clarify` | Clarify underspecified research areas |
| `/speckit.implement` | `/research.methodology` | Design research methodology |
| `/speckit.test` | `/research.analyze` | Conduct analysis and validate findings |
| `/speckit.verify` | `/research.synthesize` | Synthesize findings and conclusions |
| (none) | `/research.publish` | Prepare research outputs for publication |
| `/speckit.principles` | `/research.principles` | Define research governance principles |

### 3. Directory Structure

```bash
# Spec Kit
specs/###-spec-name/
├── definition.md          # Feature requirements
├── implementation.md      # Technical implementation
└── tests.md              # Test scenarios

# Research Kit
research/###-topic-name/
├── definition.md          # Research questions
├── methodology.md         # Research design
├── literature-review.md   # Literature synthesis
├── data-sources.md       # Data collection plan
├── analysis.md           # Findings and analysis
└── publications/         # Papers, reports, presentations
```

### 4. CLI Changes

```bash
# Spec Kit
spec init my-project
spec check

# Research Kit
research init my-research-project
research check
```

### 5. Template Changes

**Removed** (implementation-focused):
- `plan-template.md` - Technical implementation planning
- `spec-template.md` - Software feature specifications

**Added** (research-focused):
- `research-definition-template.md` - Research questions and scope
- `methodology-template.md` - Comprehensive research design
- `literature-review-template.md` - Systematic literature review
- `analysis-template.md` - Data analysis and findings

**Adapted**:
- `tasks-template.md` - Now supports research phases, not just implementation tasks
- `agent-file-template.md` - Context for AI research assistants

### 6. Script Changes

All scripts support both Spec Kit (backward compatibility) and Research Kit concepts:

```bash
# Script variables
SPEC_BRANCH → RESEARCH_TOPIC
SPEC_NUMBER → RESEARCH_NUMBER
specs/ → research/

# Script functions
get_feature_paths() → get_research_paths()  # (alias maintained for compat)
check_feature_branch() → check_research_branch()  # (alias maintained for compat)
```

### 7. Documentation Changes

All documentation rewritten to focus on research:

- **docs/index.md**: Spec Kit → Research Kit, SDD → SRD
- **docs/quickstart.md**: Software examples → Research examples (AI Safety literature review)
- **docs/local-development.md**: `specify` CLI → `research` CLI
- **SUPPORT.md**: Correct GitHub URLs and methodology references

---

## Philosophy Differences

Understanding these differences helps explain design decisions:

### Nature of Work

| Aspect | Spec Kit (SDD) | Research Kit (SRD) |
|--------|----------------|---------------------|
| **Work Type** | Prescriptive | Exploratory |
| **Starting Point** | Requirements | Questions |
| **Process** | Define → Build → Test | Define → Investigate → Analyze |
| **Iteration** | Refine specifications | Refine methodology |
| **Outcome** | Working software | Validated findings |
| **Success** | Requirements fulfilled | Questions answered |
| **Certainty** | High (specs are definitive) | Uncertain (findings emerge) |

### Workflow Mindset

**Spec Kit**: "We know what we want; let's build it systematically"
**Research Kit**: "We have questions; let's investigate them systematically"

**Spec Kit**: Implementation drives the process
**Research Kit**: Inquiry drives the process

**Spec Kit**: Tests validate that specs are met
**Research Kit**: Analysis reveals what the data shows

### Quality Criteria

| Quality Aspect | Spec Kit | Research Kit |
|----------------|----------|--------------|
| **Correctness** | Code matches specs | Findings match data |
| **Completeness** | All requirements met | All questions addressed |
| **Validity** | Tests pass | Findings validated, bias addressed |
| **Reproducibility** | Same specs → same code | Same methodology → replicable process |
| **Ethics** | Code of conduct | Research ethics, IRB approval |

---

## Staying in Sync with Spec Kit

### Why Sync with Upstream?

Spec Kit and Research Kit share common infrastructure:
- CLI architecture and tooling
- Multi-agent support (Claude Code, GitHub Copilot, etc.)
- Git-based workflows and branching
- Script automation (bash/PowerShell)
- Template systems

**Benefits of syncing**:
- Bug fixes in script logic
- Support for new AI agents
- Improved CLI features
- Better error handling
- Cross-platform improvements

### What to Sync vs. What to Ignore

#### ✅ SYNC These Changes

- **Script improvements**: Branch numbering logic, file operations, error handling
- **CLI enhancements**: Better validation, UX improvements, new flags
- **Agent support**: New AI assistants (Gemini, Cursor, Qwen, etc.)
- **Build process**: Release automation, packaging, distribution
- **Bug fixes**: Anything that improves reliability (e.g., CDPATH fix)
- **Agentic features**: Handoffs, custom agents, workflow transitions

#### ❌ DON'T Sync These Changes

- **Specification templates**: We use research templates instead
- **Implementation workflow**: We use methodology workflow instead
- **Software-specific features**: Code generation, test frameworks, etc.
- **SDD methodology docs**: We use SRD methodology instead

### How to Sync: Step-by-Step

#### 1. Setup Upstream Remote (One-Time)

```bash
cd research-kit
git remote add upstream https://github.com/anthropics/spec-kit.git
git fetch upstream
```

#### 2. Review Upstream Changes

```bash
# View commits in upstream since last sync
git log HEAD..upstream/main --oneline

# View specific file changes
git diff HEAD..upstream/main -- scripts/bash/common.sh
git diff HEAD..upstream/main -- src/spec_cli/__init__.py
```

#### 3. Identify Valuable Changes

Look for:
- Bug fixes in `scripts/bash/` and `scripts/powershell/`
- Improvements in `src/spec_cli/__init__.py` (CLI logic)
- New agents in `AGENT_CONFIG` dictionary
- Updates to `.github/workflows/` (release automation)

#### 4. Apply Changes with Translation

Use this translation guide when applying changes:

| Spec Kit | Research Kit | Notes |
|----------|--------------|-------|
| `spec` (command) | `research` | CLI command name |
| `spec_cli` (package) | `research_cli` | Python package |
| `specs/` (directory) | `research/` | Research topics directory |
| `SPEC_BRANCH` | `RESEARCH_TOPIC` | Environment variable |
| `spec-name` | `topic-name` | Branch naming |
| `implementation.md` | `methodology.md` | Different purpose |
| `tests.md` | `analysis.md` | Different purpose |
| `/speckit.define` | `/research.define` | Slash command (simplified prefix) |
| `spec-driven` | `research-driven` | Methodology name |
| `SDD` | `SRD` | Acronym |

#### 5. Example: Applying a Bug Fix (Real Example: CDPATH Fix)

**Scenario**: Spec Kit fixed a CDPATH bug that broke script execution when users had `CDPATH` set.

```bash
# 1. Identified the upstream change in PR #1039
# Old: SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# New: SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 2. Applied to all 9 bash scripts in Research Kit:
# - scripts/bash/common.sh
# - scripts/bash/create-new-research.sh
# - scripts/bash/setup-methodology.sh
# - scripts/bash/setup-execution.sh
# - scripts/bash/setup-analysis.sh
# - scripts/bash/setup-synthesis.sh
# - scripts/bash/setup-publish.sh
# - scripts/bash/check-prerequisites.sh
# - scripts/bash/update-agent-context.sh

# 3. Test the fix
.github/workflows/scripts/create-release-packages.sh v1.0.10-test
# Verify scripts work with CDPATH set

# 4. Commit with reference
git commit -m "fix: CDPATH bug in shell scripts (from spec-kit PR #1039)"
```

#### 6. Example: Adding New Agent Support

**Scenario**: Spec Kit adds support for "Nova Code" agent

```bash
# 1. Review their changes
git diff upstream/main HEAD -- src/spec_cli/__init__.py

# 2. Find the AGENT_CONFIG changes
# They added:
# "nova": {
#     "name": "Nova Code",
#     "folder": ".nova",
#     "requires_cli": True,
#     "install_url": "https://nova.ai/cli"
# }

# 3. Apply to our research_cli with same structure
vim src/research_cli/__init__.py
# Add the nova config to AGENT_CONFIG

# 4. Update templates if needed (check for nova-specific templates)
ls templates/commands/

# 5. Test
uv run research init test-nova --ai nova

# 6. Commit
git commit -m "feat: add Nova Code agent support (from spec-kit upstream)"
```

#### 7. Example: Adding Agentic Features (Real Example: Handoffs & Agents)

**Scenario**: Spec Kit added agentic modes with handoffs and custom agents for VS Code/Copilot.

```bash
# 1. Reviewed spec-kit's changes in v0.0.21-v0.0.22
# - Handoffs in command frontmatter
# - Custom agents in .github/agents/
# - Companion prompt files

# 2. Created research-focused agents (not direct copy):
# templates/agents/research-assistant.md - SRD workflow orchestrator
# templates/agents/research-reviewer.md - Quality specialist

# 3. Added handoffs to slash commands:
# Each command now includes handoffs: metadata pointing to next workflow step
# Example in templates/commands/define.md:
# handoffs:
#   - label: Refine Research Scope
#     agent: research.refine
#     prompt: Clarify and refine research requirements
#     send: true

# 4. Updated release script to deploy agents:
# - copy_agents() function
# - generate_copilot_prompts() function
# - Agent paths: .claude/agents/, .github/agents/, .cursor/agents/

# 5. Test
AGENTS=claude,copilot SCRIPTS=sh .github/workflows/scripts/create-release-packages.sh v1.0.10-test
# Verify agents deployed to correct locations

# 6. Commit
git commit -m "feat: add research agents and handoffs (adapted from spec-kit)"
```

### Testing After Sync

Always test these workflows after syncing:

```bash
# 1. CLI Installation
uv sync
uv run research --help

# 2. Project Initialization
uv run research init test-sync-project --ai claude
cd test-sync-project

# 3. Research Definition
# Use the AI assistant to run /research.define
# Verify branch creation, numbering, file generation

# 4. Methodology Setup
# Use the AI assistant to run /research.methodology
# Verify templates generated correctly

# 5. Script Functionality
.claude/commands/scripts/create-new-research.sh "test-research"
# Verify branch numbering still works

# 6. Multi-Agent Support
cd ..
uv run research init test-copilot --ai copilot
# Verify agent-specific files generated

# 7. Release Package Generation
.github/workflows/scripts/create-release-packages.sh v1.0.0-test
# Verify packages created for all agents
```

### Monitoring Upstream

**Watch Spec Kit releases**:
- GitHub: [github.com/anthropics/spec-kit/releases](https://github.com/anthropics/spec-kit/releases)
- RSS: `https://github.com/anthropics/spec-kit/releases.atom`

**Key areas to monitor**:
- ✅ Bug fixes in bash/PowerShell scripts
- ✅ New agent support
- ✅ CLI improvements
- ✅ Template structure improvements
- ⚠️ Specification-specific workflow changes (may not apply)
- ⚠️ Implementation/testing templates (we use methodology/analysis)
- ⚠️ SDD methodology docs (we use SRD)

### Contributing Back to Spec Kit

If Research Kit discovers bugs that also affect Spec Kit, consider contributing back:

1. Verify the bug exists in Spec Kit
2. Fix it in Research Kit first (with tests)
3. Create a PR to Spec Kit with **reverse translation**:
   - `research` → `spec`
   - `research_cli` → `spec_cli`
   - `RESEARCH_TOPIC` → `SPEC_BRANCH`
4. Reference Research Kit in PR description
5. Both projects benefit!

---

## For Contributors

### Understanding the Codebase

#### Direct Mappings (Easy to Sync)

These files map directly and can often be synced with name translation:

- `scripts/bash/common.sh` ✅ (with variable name translation)
- `scripts/powershell/common.ps1` ✅ (with variable name translation)
- `.github/workflows/scripts/create-release-packages.sh` ✅ (with variable translation)
- `src/research_cli/__init__.py` (CLI logic) - Partial (agent config, validation)
- `.devcontainer/` ✅ (identical)

#### Diverged Files (Don't Sync)

These files serve different purposes and should NOT be synced:

- `templates/research-definition-template.md` ≠ `spec-definition-template.md`
- `templates/methodology-template.md` ≠ `implementation-template.md`
- `templates/commands/methodology.md` ≠ `speckit.implement.md`
- `docs/research-driven.md` ≠ `spec-driven.md`

### Development Workflow

1. **Check upstream regularly** (monthly):
   ```bash
   git fetch upstream
   git log HEAD..upstream/main --oneline
   ```

2. **Evaluate each change**:
   - Infrastructure improvement? → Sync it
   - Software-specific feature? → Ignore it
   - Unclear? → Discuss in issue

3. **Test thoroughly** after syncing

4. **Document the sync** in commit messages:
   ```bash
   git commit -m "fix: improve error handling (from spec-kit upstream #123)"
   ```

### Adding Research-Specific Features

When adding features unique to Research Kit:

1. **Consider the research workflow**: Does it fit define → methodology → analyze → synthesize → publish?

2. **Maintain rigor**: Does it support research quality, ethics, and validation?

3. **Check compatibility**: Will it work with all supported AI assistants?

4. **Document thoroughly**: Research features may be unfamiliar to software developers

5. **Add examples**: Show how researchers would use it

### File Structure Convention

```
research-kit/
├── src/research_cli/          # Python CLI (sync-able with translation)
├── scripts/                   # Automation scripts (sync-able with translation)
│   ├── bash/
│   └── powershell/
├── templates/                 # Templates (research-specific, don't sync)
│   ├── commands/             # Slash command definitions
│   ├── agents/               # Custom agent templates (NEW)
│   │   ├── research-assistant.md
│   │   └── research-reviewer.md
│   ├── research-definition-template.md
│   ├── methodology-template.md
│   └── ...
├── docs/                      # Documentation (research-specific, don't sync)
│   ├── index.md
│   ├── quickstart.md
│   ├── upgrade.md            # Upgrade guide (NEW)
│   ├── the-fork.md           # This file
│   └── ...
├── .github/workflows/         # CI/CD (sync-able with translation)
└── principles/                # Research governance (research-specific)
```

### Backward Compatibility

Research Kit maintains backward compatibility for projects transitioning from Spec Kit:

- Scripts check for `specs/` directory if `research/` doesn't exist
- `SPECIFY_FEATURE` environment variable supported (legacy)
- Function aliases: `get_feature_paths()` → `get_research_paths()`

**Don't remove backward compatibility** without discussion—it helps users migrate.

---

## Summary

### Key Takeaways

1. **Research Kit is a fork**, not an extension of Spec Kit
2. **Purpose**: Enable systematic research with AI assistance
3. **Philosophy**: Exploratory research ≠ Prescriptive software development
4. **Syncing**: Cherry-pick infrastructure improvements, ignore software-specific features
5. **Translation**: Always translate naming when syncing (spec → research, implement → methodology, etc.)

### Quick Reference

| Question | Answer |
|----------|--------|
| What is Research Kit? | Fork of Spec Kit for systematic research development |
| Why fork instead of extend? | Core conceptual differences between research and software |
| Should I use Spec Kit or Research Kit? | Spec Kit for software, Research Kit for research |
| How do I stay updated with Spec Kit? | Monitor releases, cherry-pick infrastructure improvements |
| Can I contribute to both? | Yes! Bug fixes can benefit both projects |
| Where to get help? | [GitHub Issues](https://github.com/nguyenvanduocit/research-kit/issues) |

### Related Documents

- [README.md](../README.md) - Getting started guide
- [research-driven.md](../research-driven.md) - SRD methodology deep dive
- [quickstart.md](quickstart.md) - Quick start guide
- [upgrade.md](upgrade.md) - Upgrade guide for CLI and projects
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines
- [AGENTS.md](../AGENTS.md) - Agent integration and workflow documentation
- [Spec Kit Upstream](https://github.com/github/spec-kit) - Original project

---

**This document is maintained by the Research Kit community. Last updated: 2025-11-22**

### Recent Updates (2025-11-22)

**Synced from Spec Kit (v0.0.21-v0.0.22):**

- **CDPATH bug fix**: Fixed shell script vulnerability where `CDPATH` environment variable could break script directory resolution. Applied `CDPATH=""` inline fix to all 9 bash scripts.
- **Handoffs**: Added workflow transition metadata to slash commands. Copilot users see handoff buttons for workflow transitions; Claude users see suggested next steps.
- **Custom agents**: Added two research-focused agents:
  - `research-assistant`: Full SRD workflow orchestrator (auto-delegates when user mentions research)
  - `research-reviewer`: Quality assurance specialist for validating research rigor
- **Agent deployment**: Updated release script to deploy agents to correct locations:
  - Claude: `.claude/agents/*.md`
  - Copilot: `.github/agents/*.agent.md` with companion `.prompt.md` files
  - Cursor: `.cursor/agents/*.md`
- **Version command**: Added `research version` command to CLI
- **Upgrade documentation**: Created comprehensive `docs/upgrade.md` guide

**Previous Updates (2025-11-12):**

- **Simplified slash command prefix**: Changed from `/researchkit.` to `/research.` for better usability
- **Repository references**: Updated all documentation to use correct repository URL (`github.com/nguyenvanduocit/research-kit`)
- **Command naming**: All slash commands now use the simpler `/research.` prefix (e.g., `/research.define`, `/research.methodology`)
