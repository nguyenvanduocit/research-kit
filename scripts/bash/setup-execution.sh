#!/usr/bin/env bash

set -e

# Parse command line arguments
JSON_MODE=false
FORCE_MODE=false
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json)
            JSON_MODE=true
            ;;
        --force)
            FORCE_MODE=true
            ;;
        --help|-h)
            echo "Usage: $0 [--json] [--force]"
            echo "  --json    Output results in JSON format"
            echo "  --force   Bypass REQUIRED quality gate checks (logged)"
            echo "  --help    Show this help message"
            exit 0
            ;;
        *)
            ARGS+=("$arg")
            ;;
    esac
done

# Get script directory and load common functions
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Get all paths and variables from common functions
eval $(get_research_paths)

# Check if we're on a proper research branch (only for git repos)
check_research_branch "$CURRENT_BRANCH" "$HAS_GIT" || exit 1

# Ensure the research directory exists
mkdir -p "$RESEARCH_DIR"

# Run quality gate: tasks → execute
run_quality_gate "tasks_to_execute" "$RESEARCH_DIR" "$FORCE_MODE" || exit $?

# Define execution file path
EXECUTION_FILE="$RESEARCH_DIR/execution.md"

# Copy execution template if it exists
EXECUTION_TEMPLATE="$REPO_ROOT/.research/templates/execution-template.md"
if [[ -f "$EXECUTION_TEMPLATE" ]]; then
    cp "$EXECUTION_TEMPLATE" "$EXECUTION_FILE"
    echo "Copied execution template to $EXECUTION_FILE"
else
    # Create a basic execution file if template doesn't exist
    cat > "$EXECUTION_FILE" << 'EOF'
# Research Execution Log

## Execution Overview
- Start Date: $(date +%Y-%m-%d)
- Status: In Progress
- Completion: 0/0 tasks

## Data Collection Progress

### Source 1: [NAME]
- Status: [Pending]
- Records Collected: 0
- Quality Score: [TBD]
- Issues: None
- Location: `data/raw/[filename]`

## Experiment Execution

### Experiment 1: [NAME]
- Date: [TBD]
- Conditions: [TBD]
- Observations: [TBD]
- Data Location: `data/raw/exp1/`
- Deviations: None

## Literature Collection
- Papers Reviewed: 0
- Papers Included: 0
- Search Queries Used: []
- Databases Searched: []

## Execution Issues & Resolutions

None reported.

## Next Steps

1. Begin data collection from primary sources
2. Set up experimental conditions
3. Start literature search

## Quality Metrics
- Data Completeness: 0%
- Protocol Adherence: 100%
- Time on Schedule: Yes
EOF
    echo "Created execution log at $EXECUTION_FILE"
fi

# Create data collection directories
DATA_RAW_DIR="$RESEARCH_DIR/data/raw"
DATA_PROCESSED_DIR="$RESEARCH_DIR/data/processed"
LOGS_DIR="$RESEARCH_DIR/logs"
NOTEBOOKS_DIR="$RESEARCH_DIR/notebooks"
SCRIPTS_DIR="$RESEARCH_DIR/scripts"

# Create sources directory for downloaded web content (markitdown)
SOURCES_DIR="$RESEARCH_DIR/sources"
SOURCES_WEB_DIR="$SOURCES_DIR/web"
SOURCES_PAPERS_DIR="$SOURCES_DIR/papers"
SOURCES_REPORTS_DIR="$SOURCES_DIR/reports"

mkdir -p "$DATA_RAW_DIR"
mkdir -p "$DATA_PROCESSED_DIR"
mkdir -p "$LOGS_DIR"
mkdir -p "$NOTEBOOKS_DIR"
mkdir -p "$SCRIPTS_DIR"
mkdir -p "$SOURCES_WEB_DIR"
mkdir -p "$SOURCES_PAPERS_DIR"
mkdir -p "$SOURCES_REPORTS_DIR"

echo "Created execution directories:"
echo "  - data/raw/ for raw collected data"
echo "  - data/processed/ for cleaned data"
echo "  - logs/ for execution logs"
echo "  - notebooks/ for analysis notebooks"
echo "  - scripts/ for collection scripts"
echo "  - sources/web/ for downloaded web content (markitdown)"
echo "  - sources/papers/ for downloaded academic papers"
echo "  - sources/reports/ for downloaded reports"

# Create initial log file
EXECUTION_LOG="$LOGS_DIR/execution_$(date +%Y%m%d_%H%M%S).log"
cat > "$EXECUTION_LOG" << EOF
# Execution Log
Started: $(date)
Branch: $CURRENT_BRANCH
Research Dir: $RESEARCH_DIR

## Setup Complete
- Created execution tracking file
- Initialized data directories
- Ready for data collection

EOF
echo "Created execution log at $EXECUTION_LOG"

# Create data inventory file
DATA_INVENTORY="$DATA_RAW_DIR/DATA_INVENTORY.md"
cat > "$DATA_INVENTORY" << 'EOF'
# Data Inventory

## Raw Data Files

| File | Description | Date Collected | Size | Format | Quality Check |
|------|-------------|----------------|------|--------|---------------|
| | | | | | |

## Data Sources Summary

| Source | Total Records | Date Range | Completeness | Issues |
|--------|---------------|------------|--------------|--------|
| | | | | |

## Metadata Standards
- All files should include collection timestamp
- Document any preprocessing applied
- Note collection parameters and conditions
- Include data dictionary for variables
EOF
echo "Created data inventory at $DATA_INVENTORY"

# Create sources index file for tracking downloaded sources
SOURCES_INDEX="$SOURCES_DIR/SOURCES_INDEX.md"
cat > "$SOURCES_INDEX" << 'EOF'
# Sources Index

> All web content, articles, papers, and reports MUST be downloaded locally using `markitdown` before being cited.
> Every citation MUST reference a local file with line number: `sources/web/filename.md:123`

## Source Collection Rules

1. **NEVER cite a URL directly** - Always download first
2. **Use markitdown** to convert web content to markdown: `markitdown "URL" > sources/web/filename.md`
3. **Read the local file** after downloading, not the web
4. **Cite with file:line** format: `sources/web/article-name.md:45`

## Downloaded Sources

### Web Articles (`sources/web/`)

| File | Original URL | Downloaded | Lines | Status |
|------|--------------|------------|-------|--------|
| | | | | |

### Academic Papers (`sources/papers/`)

| File | DOI/URL | Downloaded | Lines | Status |
|------|---------|------------|-------|--------|
| | | | | |

### Reports (`sources/reports/`)

| File | Source | Downloaded | Lines | Status |
|------|--------|------------|-------|--------|
| | | | | |

## Citation Format

When citing evidence or insights, ALWAYS use this format:

```markdown
According to the analysis, "quoted text" (sources/web/article-name.md:45-48)

Key finding from research (sources/papers/smith-2024.md:123)
```

## Verification Checklist

- [ ] All URLs converted to local files
- [ ] All citations reference local file:line
- [ ] Sources index is up to date
- [ ] No direct URL citations in research documents
EOF
echo "Created sources index at $SOURCES_INDEX"

# Output results
if $JSON_MODE; then
    printf '{"EXECUTION_FILE":"%s","DATA_RAW_DIR":"%s","DATA_PROCESSED_DIR":"%s","LOGS_DIR":"%s","NOTEBOOKS_DIR":"%s","SCRIPTS_DIR":"%s","SOURCES_DIR":"%s","SOURCES_WEB_DIR":"%s","SOURCES_PAPERS_DIR":"%s","SOURCES_REPORTS_DIR":"%s","EXECUTION_LOG":"%s","DATA_INVENTORY":"%s","RESEARCH_DIR":"%s","BRANCH":"%s","HAS_GIT":"%s"}\n' \
        "$EXECUTION_FILE" "$DATA_RAW_DIR" "$DATA_PROCESSED_DIR" "$LOGS_DIR" "$NOTEBOOKS_DIR" "$SCRIPTS_DIR" "$SOURCES_DIR" "$SOURCES_WEB_DIR" "$SOURCES_PAPERS_DIR" "$SOURCES_REPORTS_DIR" "$EXECUTION_LOG" "$DATA_INVENTORY" "$RESEARCH_DIR" "$CURRENT_BRANCH" "$HAS_GIT"
else
    echo "EXECUTION_FILE: $EXECUTION_FILE"
    echo "DATA_RAW_DIR: $DATA_RAW_DIR"
    echo "DATA_PROCESSED_DIR: $DATA_PROCESSED_DIR"
    echo "LOGS_DIR: $LOGS_DIR"
    echo "NOTEBOOKS_DIR: $NOTEBOOKS_DIR"
    echo "SCRIPTS_DIR: $SCRIPTS_DIR"
    echo "SOURCES_DIR: $SOURCES_DIR"
    echo "SOURCES_WEB_DIR: $SOURCES_WEB_DIR"
    echo "SOURCES_PAPERS_DIR: $SOURCES_PAPERS_DIR"
    echo "SOURCES_REPORTS_DIR: $SOURCES_REPORTS_DIR"
    echo "EXECUTION_LOG: $EXECUTION_LOG"
    echo "DATA_INVENTORY: $DATA_INVENTORY"
    echo "RESEARCH_DIR: $RESEARCH_DIR"
    echo "BRANCH: $CURRENT_BRANCH"
    echo "HAS_GIT: $HAS_GIT"
fi