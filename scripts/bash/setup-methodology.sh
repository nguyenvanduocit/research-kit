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

# Check phase dependencies - methodology requires definition to be completed first
DEFINITION_FILE="$RESEARCH_DIR/definition.md"
if [[ ! -f "$DEFINITION_FILE" ]]; then
    echo "Error: definition.md not found in $RESEARCH_DIR"
    echo "Please run /research.define before running /research.methodology"
    echo ""
    echo "The research workflow phases must be completed in order:"
    echo "  1. /research.define - Define research question (must be completed)"
    echo "  2. /research.methodology - Design methodology (current step)"
    echo "  3. /research.execute - Collect data"
    echo "  4. /research.analyze - Analyze data"
    echo "  5. /research.synthesize - Draw conclusions"
    echo "  6. /research.publish - Create outputs"
    exit 1
fi

# Define methodology file path
METHODOLOGY_FILE="$RESEARCH_DIR/methodology.md"

# Copy methodology template if it exists
METHODOLOGY_TEMPLATE="$REPO_ROOT/.research/templates/methodology-template.md"
if [[ -f "$METHODOLOGY_TEMPLATE" ]]; then
    cp "$METHODOLOGY_TEMPLATE" "$METHODOLOGY_FILE"
    echo "Copied methodology template to $METHODOLOGY_FILE"
else
    echo "Warning: Methodology template not found at $METHODOLOGY_TEMPLATE"
    # Create a basic methodology file if template doesn't exist
    touch "$METHODOLOGY_FILE"
fi

# Copy literature review template if it exists
LITERATURE_REVIEW_TEMPLATE="$REPO_ROOT/.research/templates/literature-review-template.md"
LITERATURE_REVIEW_FILE="$RESEARCH_DIR/literature-review.md"
if [[ -f "$LITERATURE_REVIEW_TEMPLATE" ]]; then
    cp "$LITERATURE_REVIEW_TEMPLATE" "$LITERATURE_REVIEW_FILE"
    echo "Copied literature review template to $LITERATURE_REVIEW_FILE"
else
    echo "Warning: Literature review template not found at $LITERATURE_REVIEW_TEMPLATE"
fi

# Copy references template if it exists
REFERENCES_TEMPLATE="$REPO_ROOT/.research/templates/references.bib"
REFERENCES_FILE="$RESEARCH_DIR/references.bib"
if [[ -f "$REFERENCES_TEMPLATE" ]]; then
    cp "$REFERENCES_TEMPLATE" "$REFERENCES_FILE"
    echo "Copied references template to $REFERENCES_FILE"
else
    echo "Warning: References template not found at $REFERENCES_TEMPLATE"
fi

# Create data-sources.md placeholder (no template exists yet)
DATA_SOURCES_FILE="$RESEARCH_DIR/data-sources.md"
if [[ ! -f "$DATA_SOURCES_FILE" ]]; then
    cat > "$DATA_SOURCES_FILE" << 'EOF'
# Data Sources

## Overview
List and describe all data sources used in this research.

## Primary Sources

### Source 1
- **Name**:
- **Type**:
- **Access Method**:
- **Relevant Variables**:
- **Quality Assessment**:
- **Limitations**:

## Secondary Sources

### Source 1
- **Name**:
- **Type**:
- **Access Method**:
- **Relevant Variables**:
- **Quality Assessment**:
- **Limitations**:

## Data Collection Methods

## Ethical Considerations

## Data Management Plan
EOF
    echo "Created data sources file at $DATA_SOURCES_FILE"
fi

# Create findings.md placeholder (no template exists yet)
FINDINGS_FILE="$RESEARCH_DIR/findings.md"
if [[ ! -f "$FINDINGS_FILE" ]]; then
    cat > "$FINDINGS_FILE" << 'EOF'
# Research Findings

## Overview
Document key findings as they emerge during the research process.

## Preliminary Findings

## Key Results

## Unexpected Observations

## Implications

## Next Steps
EOF
    echo "Created findings file at $FINDINGS_FILE"
fi

# Create research-specific subdirectories
PROTOCOLS_DIR="$RESEARCH_DIR/protocols"
DATA_DIR="$RESEARCH_DIR/data"
ANALYSIS_DIR="$RESEARCH_DIR/analysis"

mkdir -p "$PROTOCOLS_DIR"
mkdir -p "$DATA_DIR"
mkdir -p "$ANALYSIS_DIR"

echo "Created research subdirectories:"
echo "  - protocols/ for research protocols"
echo "  - data/ for collected data"
echo "  - analysis/ for analysis outputs"

# Output results
if $JSON_MODE; then
    printf '{"DEFINITION_FILE":"%s","METHODOLOGY_FILE":"%s","LITERATURE_REVIEW":"%s","DATA_SOURCES":"%s","FINDINGS":"%s","REFERENCES":"%s","RESEARCH_DIR":"%s","PROTOCOLS_DIR":"%s","DATA_DIR":"%s","ANALYSIS_DIR":"%s","BRANCH":"%s","HAS_GIT":"%s"}\n' \
        "$DEFINITION_FILE" "$METHODOLOGY_FILE" "$LITERATURE_REVIEW_FILE" "$DATA_SOURCES_FILE" "$FINDINGS_FILE" "$REFERENCES_FILE" "$RESEARCH_DIR" "$PROTOCOLS_DIR" "$DATA_DIR" "$ANALYSIS_DIR" "$CURRENT_BRANCH" "$HAS_GIT"
else
    echo "DEFINITION_FILE: $DEFINITION_FILE"
    echo "METHODOLOGY_FILE: $METHODOLOGY_FILE"
    echo "LITERATURE_REVIEW: $LITERATURE_REVIEW_FILE"
    echo "DATA_SOURCES: $DATA_SOURCES_FILE"
    echo "FINDINGS: $FINDINGS_FILE"
    echo "REFERENCES: $REFERENCES_FILE"
    echo "RESEARCH_DIR: $RESEARCH_DIR"
    echo "PROTOCOLS_DIR: $PROTOCOLS_DIR"
    echo "DATA_DIR: $DATA_DIR"
    echo "ANALYSIS_DIR: $ANALYSIS_DIR"
    echo "BRANCH: $CURRENT_BRANCH"
    echo "HAS_GIT: $HAS_GIT"
fi
