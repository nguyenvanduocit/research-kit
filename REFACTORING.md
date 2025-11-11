# Refactoring from Spec Kit to Research Kit

## Overview

Research Kit is a fork of [Spec Kit](https://github.com/anthropics/spec-kit), transformed from a specification-driven development (SDD) toolkit into a systematic research development (SRD) toolkit. This document explains the refactoring process and how to incorporate upstream improvements from Spec Kit.

## What We Changed

### 1. Core Concept Transformation

**From Specifications to Research**

| Spec Kit Concept | Research Kit Concept | Rationale |
|------------------|---------------------|-----------|
| Specifications | Research Topics | Research is exploratory, not prescriptive |
| `/spec.define` | `/research.define` | Define research questions and scope |
| `/spec.clarify` | `/research.clarify` | Clarify underspecified research areas |
| `/spec.implement` | `/research.methodology` | Design research methodologies |
| `/spec.test` | `/research.analyze` | Conduct analysis and validate findings |
| `/spec.verify` | `/research.synthesize` | Synthesize findings and conclusions |
| Specification branch (`###-spec-name`) | Research topic branch (`###-topic-name`) | Topic-based organization |

### 2. File Structure Changes

**Directory Naming**
```bash
# Old (Spec Kit)
specs/###-spec-name/definition.md
specs/###-spec-name/implementation.md
specs/###-spec-name/tests.md

# New (Research Kit)
research/###-topic-name/definition.md
research/###-topic-name/methodology.md
research/###-topic-name/analysis.md
research/###-topic-name/literature-review.md
research/###-topic-name/data-sources.md
research/###-topic-name/publications/
```

**Command Files**
```bash
# Old (Spec Kit)
.claude/commands/speckit.define.md
.claude/commands/speckit.clarify.md
.claude/commands/speckit.implement.md
.claude/commands/speckit.test.md
.claude/commands/speckit.verify.md
.claude/commands/speckit.principles.md

# New (Research Kit)
.claude/commands/researchkit.define.md
.claude/commands/researchkit.clarify.md
.claude/commands/researchkit.methodology.md
.claude/commands/researchkit.analyze.md
.claude/commands/researchkit.synthesize.md
.claude/commands/researchkit.publish.md
.claude/commands/researchkit.principles.md
```

### 3. Python CLI Changes

**Package Renaming**
- Package: `spec_cli` → `research_cli`
- Command: `spec` → `research`
- Entry point: `spec_cli:main` → `research_cli:main`

**Script Changes**
```python
# Old
spec init my-project
spec check
spec <command>

# New
research init my-research-project
research check
research <command>
```

### 4. Script Refactoring

**File Renaming**
```bash
# Old (Spec Kit)
scripts/bash/create-new-spec.sh
scripts/bash/setup-implementation.sh
scripts/powershell/create-new-spec.ps1
scripts/powershell/setup-implementation.ps1

# New (Research Kit)
scripts/bash/create-new-research.sh
scripts/bash/setup-methodology.sh
scripts/powershell/create-new-research.ps1
scripts/powershell/setup-methodology.ps1
```

**Variable Renaming**
```bash
# Old variables in scripts
SPEC_BRANCH
SPEC_NUMBER
SPEC_NAME
specs/

# New variables in scripts
RESEARCH_TOPIC
RESEARCH_NUMBER
RESEARCH_NAME
research/
```

### 5. Template Changes

**Document Templates**
- `spec-definition-template.md` → `research-definition-template.md`
- `implementation-template.md` → `methodology-template.md`
- Added: `analysis-template.md`, `literature-review-template.md`, `data-sources-template.md`

**Content Structure**
- Removed implementation-specific sections (tests, success criteria)
- Added research-specific sections (literature review, data sources, ethics, publications)
- Changed terminology from "requirements" to "research questions"

### 6. Documentation Updates

**File Renaming**
- `spec-driven.md` → `research-driven.md`
- Updated all references to "specification" → "research"
- Updated all references to "SDD" → "SRD"

**Conceptual Changes**
- Focus on exploratory research vs. prescriptive specifications
- Emphasis on methodology design, literature review, and publication
- Added sections on research ethics and data management

## Key Architectural Decisions

### 1. Branching Strategy Kept Intact

We preserved the numbered branch structure (`###-name`) because:
- It provides clear organization and uniqueness
- Git-based tracking of research topics is valuable
- Easy to identify and switch between research topics
- Maintains compatibility with multi-researcher workflows

### 2. Template-Driven Approach Retained

The template system is core to both toolkits:
- Ensures consistency across research projects
- Enables AI assistants to parse structured data
- Facilitates automation and validation
- Makes the workflow agent-agnostic

### 3. Script Structure Preserved

We kept the bash/PowerShell dual-script approach:
- Cross-platform compatibility (Unix/Windows)
- Separation of concerns (common utilities, specific operations)
- Non-git environment support via environment variables
- Feature parity between script variants

## How to Sync Upstream Changes from Spec Kit

### Setup Remote Tracking

```bash
# Add Spec Kit as upstream remote
git remote add upstream https://github.com/anthropics/spec-kit.git

# Verify remotes
git remote -v
# origin    https://github.com/nguyenvanduocit/research-kit.git
# upstream  https://github.com/anthropics/spec-kit.git

# Fetch upstream changes
git fetch upstream
```

### Review Upstream Changes

```bash
# View commits in upstream since fork
git log HEAD..upstream/main --oneline

# View specific file changes
git diff HEAD..upstream/main -- <file-path>

# Examples:
git diff HEAD..upstream/main -- scripts/bash/common.sh
git diff HEAD..upstream/main -- src/spec_cli/__init__.py
git diff HEAD..upstream/main -- templates/
```

### Selective Cherry-Picking

**Identify valuable changes:**
1. Bug fixes in script logic
2. Improvements to error handling
3. New agent support
4. Enhanced CLI features
5. Better template structures

**Apply changes manually:**

```bash
# Create a sync branch
git checkout -b sync-upstream-improvements

# Cherry-pick specific commits (if applicable)
git cherry-pick <commit-hash>

# Or manually apply changes from diff
git diff upstream/main HEAD -- scripts/bash/common.sh > /tmp/common.patch
# Review patch, manually apply relevant parts

# Test thoroughly
uv run research init test-sync-project --ai claude
```

### Translation Guide for Upstream Changes

When applying Spec Kit changes to Research Kit, use this translation table:

| Spec Kit | Research Kit | Notes |
|----------|--------------|-------|
| `spec` (command) | `research` | CLI command name |
| `spec_cli` (package) | `research_cli` | Python package |
| `specs/` (directory) | `research/` | Research topics directory |
| `SPEC_BRANCH` | `RESEARCH_TOPIC` | Environment variable |
| `spec-name` | `topic-name` | Branch naming |
| `definition.md` | `definition.md` | ✓ Same name |
| `implementation.md` | `methodology.md` | Different purpose |
| `tests.md` | `analysis.md` | Different purpose |
| `/spec.define` | `/research.define` | Slash command |
| `/spec.implement` | `/research.methodology` | Slash command |
| `/spec.test` | `/research.analyze` | Slash command |
| `spec-driven` | `research-driven` | Methodology name |
| `SDD` | `SRD` | Acronym |

### Example: Applying a Bug Fix

**Scenario:** Spec Kit fixed a branch numbering bug in `create-new-spec.sh`

```bash
# 1. View the upstream change
git diff upstream/main HEAD -- scripts/bash/create-new-spec.sh

# 2. Identify the logic change (e.g., improved regex for branch detection)
# Old: branches=$(git branch -r | grep -oE '[0-9]{3}-' | sort -u)
# New: branches=$(git branch -r | grep -oE '[0-9]{3}-[^/]+$' | sort -u)

# 3. Apply to our equivalent file with name translation
# Edit scripts/bash/create-new-research.sh
# Replace the corresponding line in our script

# 4. Apply the same fix to PowerShell variant
# Edit scripts/powershell/create-new-research.ps1

# 5. Test the fix
.github/workflows/scripts/create-release-packages.sh v1.0.0-test
cp -r .genreleases/srd-claude-package-sh/. ~/test-research-project/
# Test in the research project

# 6. Commit with reference
git commit -m "fix: improve branch numbering detection (from spec-kit upstream)"
```

### Example: Adding New Agent Support

**Scenario:** Spec Kit adds support for a new AI agent "Nova Code"

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
# Edit src/research_cli/__init__.py
# Add the nova config to AGENT_CONFIG

# 4. Update templates if needed
# Check if they added nova-specific templates in templates/commands/

# 5. Test
uv run research init test-nova --ai nova

# 6. Commit
git commit -m "feat: add Nova Code agent support (from spec-kit upstream)"
```

## Files That Map Directly

These files have equivalent logic and can often be synced directly (with name translation):

| Spec Kit File | Research Kit File | Direct Sync? |
|---------------|-------------------|--------------|
| `scripts/bash/common.sh` | `scripts/bash/common.sh` | ✓ Yes (with var names) |
| `scripts/powershell/common.ps1` | `scripts/powershell/common.ps1` | ✓ Yes (with var names) |
| `.github/workflows/scripts/create-release-packages.sh` | `.github/workflows/scripts/create-release-packages.sh` | ✓ Yes (with var names) |
| `src/spec_cli/__init__.py` (CLI logic) | `src/research_cli/__init__.py` | Partial (agent config, validation) |
| `templates/vscode-settings.json` | `templates/vscode-settings.json` | ✓ Yes (identical) |
| `.devcontainer/` | `.devcontainer/` | ✓ Yes (identical) |

## Files That Diverge Significantly

These files have different purposes and should NOT be synced directly:

| Spec Kit File | Research Kit File | Reason |
|---------------|-------------------|--------|
| `templates/spec-definition-template.md` | `templates/research-definition-template.md` | Different content structure |
| `templates/implementation-template.md` | `templates/methodology-template.md` | Different workflow stage |
| `templates/commands/speckit.implement.md` | `templates/commands/researchkit.methodology.md` | Different instructions |
| `spec-driven.md` | `research-driven.md` | Different methodology philosophy |

## Testing Checklist After Syncing

When applying upstream changes, test these workflows:

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

## Contribution Workflow

When contributing upstream-inspired changes:

1. **Create feature branch**: `git checkout -b feat/upstream-<feature-name>`
2. **Apply changes with translation**: Use the translation guide above
3. **Test thoroughly**: Run full testing checklist
4. **Document origin**: Reference Spec Kit commit/PR in commit message
5. **Open PR**: Include "Inspired by spec-kit: <link>" in description

## Monitoring Upstream

**Watch Spec Kit releases:**
- GitHub: Watch releases at https://github.com/anthropics/spec-kit/releases
- RSS: Subscribe to `https://github.com/anthropics/spec-kit/releases.atom`

**Key areas to monitor:**
- Bug fixes in bash/PowerShell scripts (branch numbering, file operations)
- New agent support (extends our supported AI assistants)
- CLI improvements (better validation, error messages, UX)
- Template improvements (better structure, clearer instructions)

**Less relevant areas:**
- Specification-specific workflow changes
- Implementation/testing templates (we use methodology/analysis)
- Documentation about SDD methodology (we use SRD)

## Philosophy Differences

Understanding these differences helps decide what to sync:

| Aspect | Spec Kit | Research Kit |
|--------|----------|--------------|
| **Purpose** | Prescriptive specifications | Exploratory research |
| **Workflow** | Define → Implement → Test → Verify | Define → Methodology → Analyze → Synthesize → Publish |
| **Outputs** | Code implementations, tests | Methodologies, analyses, publications |
| **Validation** | Tests pass, specs met | Findings validated, conclusions supported |
| **Success** | Requirements fulfilled | Research questions answered |
| **Iteration** | Refine specs | Refine methodology |

## Conclusion

Research Kit maintains the robust infrastructure of Spec Kit while adapting it for research workflows. When syncing upstream:

1. **Focus on infrastructure**: Scripts, CLI, agent support, build process
2. **Translate naming**: spec → research, implementation → methodology
3. **Preserve philosophy**: Don't blindly copy spec-driven concepts
4. **Test thoroughly**: Ensure research workflows still function
5. **Contribute back**: If we fix bugs, consider PRing to Spec Kit (with reverse translation)

This approach keeps us compatible with Spec Kit's improvements while maintaining our research-focused mission.
