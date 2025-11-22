#!/usr/bin/env bash

set -e

# Parse command line arguments
JSON_MODE=false
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json)
            JSON_MODE=true
            ;;
        --help|-h)
            echo "Usage: $0 [--json]"
            echo "  --json    Output results in JSON format"
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

# Check phase dependencies - analysis requires execution to be completed first
EXECUTION_FILE="$RESEARCH_DIR/execution.md"
if [[ ! -f "$EXECUTION_FILE" ]]; then
    echo "Error: execution.md not found in $RESEARCH_DIR"
    echo "Please run /research.execute before running /research.analyze"
    echo ""
    echo "The research workflow phases must be completed in order:"
    echo "  1. /research.define - Define research question"
    echo "  2. /research.methodology - Design methodology"
    echo "  3. /research.execute - Collect data"
    echo "  4. /research.analyze - Analyze data (current step)"
    echo "  5. /research.synthesize - Draw conclusions"
    echo "  6. /research.publish - Create outputs"
    exit 1
fi

# Also check if data directory exists with some data
DATA_DIR="$RESEARCH_DIR/data"
if [[ ! -d "$DATA_DIR" ]] || [[ -z "$(ls -A "$DATA_DIR" 2>/dev/null)" ]]; then
    echo "Warning: No data directory or data files found"
    echo "The execution phase should have created data in: $DATA_DIR"
    echo "Continuing anyway, but analysis may be limited..."
fi

# Define analysis file path
ANALYSIS_FILE="$RESEARCH_DIR/analysis.md"

# Copy analysis template if it exists
ANALYSIS_TEMPLATE="$REPO_ROOT/.research/templates/analysis-template.md"
if [[ -f "$ANALYSIS_TEMPLATE" ]]; then
    cp "$ANALYSIS_TEMPLATE" "$ANALYSIS_FILE"
    echo "Copied analysis template to $ANALYSIS_FILE"
else
    # Create a basic analysis file if template doesn't exist
    cat > "$ANALYSIS_FILE" << 'EOF'
# Research Analysis

## Analysis Overview
- Analysis Date: $(date +%Y-%m-%d)
- Data Sources Analyzed: []
- Analysis Methods Used: []

## Data Quality Assessment

### Dataset 1: [NAME]
- Total Records: 0
- Valid Records: 0
- Missing Data: 0%
- Quality Score: [TBD]
- Processing Applied: []

## Key Findings

### Finding 1: [Clear statement]
- Supporting Evidence: [Data/statistics]
- Statistical Significance: [p-value if applicable]
- Effect Size: [if applicable]
- Visualization: `figures/fig_01_finding1.png`
- Interpretation: [What this means]

## Statistical Results

### Test 1: [Name]
- Hypothesis: [H0 and H1]
- Test Statistic: [value]
- p-value: [value]
- Conclusion: [Accept/Reject H0]

## Pattern Analysis

### Pattern 1: [Description]
- Evidence: [Data points]
- Strength: [Strong/Moderate/Weak]
- Implications: [What this suggests]

## Comparison with Literature
- Confirmatory Findings: []
- Contradictory Findings: []
- Novel Findings: []

## Limitations of Analysis
- [Limitation 1 and impact]
- [Limitation 2 and impact]

## Next Steps for Synthesis
1. Integrate findings across data sources
2. Connect findings to research questions
3. Develop theoretical implications
EOF
    echo "Created analysis file at $ANALYSIS_FILE"
fi

# Create or ensure analysis directories exist
FIGURES_DIR="$RESEARCH_DIR/figures"
TABLES_DIR="$RESEARCH_DIR/tables"
RESULTS_DIR="$RESEARCH_DIR/data/results"
NOTEBOOKS_DIR="$RESEARCH_DIR/notebooks"

mkdir -p "$FIGURES_DIR"
mkdir -p "$TABLES_DIR"
mkdir -p "$RESULTS_DIR"
mkdir -p "$NOTEBOOKS_DIR"

echo "Created analysis directories:"
echo "  - figures/ for visualizations"
echo "  - tables/ for statistical tables"
echo "  - data/results/ for analysis outputs"
echo "  - notebooks/ for analysis notebooks"

# Create initial analysis notebooks structure
NOTEBOOK_01="$NOTEBOOKS_DIR/01_data_preparation.ipynb"
if [[ ! -f "$NOTEBOOK_01" ]]; then
    cat > "$NOTEBOOK_01" << 'EOF'
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Data Preparation\n",
    "\n",
    "This notebook handles data loading, cleaning, and preparation for analysis."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd\n",
    "import numpy as np\n",
    "import os\n",
    "from pathlib import Path\n",
    "\n",
    "# Set up paths\n",
    "PROJECT_ROOT = Path('.').resolve().parent.parent\n",
    "DATA_RAW = PROJECT_ROOT / 'data' / 'raw'\n",
    "DATA_PROCESSED = PROJECT_ROOT / 'data' / 'processed'"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Load Raw Data"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Load your data here"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
EOF
    echo "Created data preparation notebook"
fi

# Create statistical summary template
STATS_SUMMARY="$TABLES_DIR/statistical_summary.md"
cat > "$STATS_SUMMARY" << 'EOF'
# Statistical Summary

## Descriptive Statistics

| Variable | N | Mean | SD | Min | Q1 | Median | Q3 | Max |
|----------|---|------|----|----|----|---------|----|-----|
| | | | | | | | | |

## Correlation Matrix

| Variable | Var1 | Var2 | Var3 |
|----------|------|------|------|
| Var1 | 1.00 | | |
| Var2 | | 1.00 | |
| Var3 | | | 1.00 |

## Hypothesis Tests Summary

| Test | Hypothesis | Statistic | p-value | Result |
|------|------------|-----------|---------|---------|
| | | | | |
EOF
echo "Created statistical summary template"

# Create analysis log
ANALYSIS_LOG="$RESEARCH_DIR/logs/analysis_$(date +%Y%m%d_%H%M%S).log"
cat > "$ANALYSIS_LOG" << EOF
# Analysis Log
Started: $(date)
Branch: $CURRENT_BRANCH
Research Dir: $RESEARCH_DIR

## Analysis Setup
- Created analysis tracking file
- Initialized output directories
- Ready for data analysis

## Analysis Steps
1. Data preparation and cleaning
2. Exploratory data analysis
3. Statistical testing
4. Pattern identification
5. Results validation

EOF
echo "Created analysis log at $ANALYSIS_LOG"

# Output results
if $JSON_MODE; then
    printf '{"ANALYSIS_FILE":"%s","FIGURES_DIR":"%s","TABLES_DIR":"%s","RESULTS_DIR":"%s","NOTEBOOKS_DIR":"%s","STATS_SUMMARY":"%s","ANALYSIS_LOG":"%s","RESEARCH_DIR":"%s","BRANCH":"%s","HAS_GIT":"%s"}\n' \
        "$ANALYSIS_FILE" "$FIGURES_DIR" "$TABLES_DIR" "$RESULTS_DIR" "$NOTEBOOKS_DIR" "$STATS_SUMMARY" "$ANALYSIS_LOG" "$RESEARCH_DIR" "$CURRENT_BRANCH" "$HAS_GIT"
else
    echo "ANALYSIS_FILE: $ANALYSIS_FILE"
    echo "FIGURES_DIR: $FIGURES_DIR"
    echo "TABLES_DIR: $TABLES_DIR"
    echo "RESULTS_DIR: $RESULTS_DIR"
    echo "NOTEBOOKS_DIR: $NOTEBOOKS_DIR"
    echo "STATS_SUMMARY: $STATS_SUMMARY"
    echo "ANALYSIS_LOG: $ANALYSIS_LOG"
    echo "RESEARCH_DIR: $RESEARCH_DIR"
    echo "BRANCH: $CURRENT_BRANCH"
    echo "HAS_GIT: $HAS_GIT"
fi