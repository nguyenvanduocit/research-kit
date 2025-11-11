#!/usr/bin/env bash

# Consolidated prerequisite checking script
#
# This script provides unified prerequisite checking for Research Kit workflow.
# It replaces the functionality previously spread across multiple scripts.
#
# Usage: ./check-prerequisites.sh [OPTIONS]
#
# OPTIONS:
#   --json              Output in JSON format
#   --require-tasks     Require tasks.md to exist (for execution phase)
#   --include-tasks     Include tasks.md in AVAILABLE_DOCS list
#   --paths-only        Only output path variables (no validation)
#   --help, -h          Show help message
#
# OUTPUTS:
#   JSON mode: {"RESEARCH_DIR":"...", "AVAILABLE_DOCS":["..."]}
#   Text mode: RESEARCH_DIR:... \n AVAILABLE_DOCS: \n ✓/✗ file.md
#   Paths only: REPO_ROOT: ... \n BRANCH: ... \n RESEARCH_DIR: ... etc.

set -e

# Parse command line arguments
JSON_MODE=false
REQUIRE_TASKS=false
INCLUDE_TASKS=false
PATHS_ONLY=false

for arg in "$@"; do
    case "$arg" in
        --json)
            JSON_MODE=true
            ;;
        --require-tasks)
            REQUIRE_TASKS=true
            ;;
        --include-tasks)
            INCLUDE_TASKS=true
            ;;
        --paths-only)
            PATHS_ONLY=true
            ;;
        --help|-h)
            cat << 'EOF'
Usage: check-prerequisites.sh [OPTIONS]

Consolidated prerequisite checking for Research Kit workflow.

OPTIONS:
  --json              Output in JSON format
  --require-tasks     Require tasks.md to exist (for execution phase)
  --include-tasks     Include tasks.md in AVAILABLE_DOCS list
  --paths-only        Only output path variables (no prerequisite validation)
  --help, -h          Show this help message

EXAMPLES:
  # Check task prerequisites (methodology.md required)
  ./check-prerequisites.sh --json

  # Check execution prerequisites (methodology.md + tasks.md required)
  ./check-prerequisites.sh --json --require-tasks --include-tasks

  # Get research paths only (no validation)
  ./check-prerequisites.sh --paths-only

EOF
            exit 0
            ;;
        *)
            echo "ERROR: Unknown option '$arg'. Use --help for usage information." >&2
            exit 1
            ;;
    esac
done

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Get research paths and validate branch
eval $(get_research_paths)
check_research_branch "$CURRENT_BRANCH" "$HAS_GIT" || exit 1

# Map research variables to shorter names for backward compatibility
METHODOLOGY="$RESEARCH_METHODOLOGY"
TASKS="$RESEARCH_TASKS"
LITERATURE_REVIEW="$RESEARCH_LITERATURE_REVIEW"
DATA_ANALYSIS="$RESEARCH_DATA_ANALYSIS"
REFERENCES_DIR="$RESEARCH_REFERENCES_DIR"

# If paths-only mode, output paths and exit (support JSON + paths-only combined)
if $PATHS_ONLY; then
    if $JSON_MODE; then
        # Minimal JSON paths payload (no validation performed)
        printf '{"REPO_ROOT":"%s","BRANCH":"%s","RESEARCH_DIR":"%s","RESEARCH_DEFINITION":"%s","METHODOLOGY":"%s","TASKS":"%s"}\n' \
            "$REPO_ROOT" "$CURRENT_BRANCH" "$RESEARCH_DIR" "$RESEARCH_DEFINITION" "$METHODOLOGY" "$TASKS"
    else
        echo "REPO_ROOT: $REPO_ROOT"
        echo "BRANCH: $CURRENT_BRANCH"
        echo "RESEARCH_DIR: $RESEARCH_DIR"
        echo "RESEARCH_DEFINITION: $RESEARCH_DEFINITION"
        echo "METHODOLOGY: $METHODOLOGY"
        echo "TASKS: $TASKS"
    fi
    exit 0
fi

# Validate required directories and files
if [[ ! -d "$RESEARCH_DIR" ]]; then
    echo "ERROR: Research directory not found: $RESEARCH_DIR" >&2
    echo "Run /researchkit.define first to create the research structure." >&2
    exit 1
fi

if [[ ! -f "$METHODOLOGY" ]]; then
    echo "ERROR: methodology.md not found in $RESEARCH_DIR" >&2
    echo "Run /researchkit.methodology first to create the research methodology." >&2
    exit 1
fi

# Check for tasks.md if required
if $REQUIRE_TASKS && [[ ! -f "$TASKS" ]]; then
    echo "ERROR: tasks.md not found in $RESEARCH_DIR" >&2
    echo "Run /researchkit.tasks first to create the task list." >&2
    exit 1
fi

# Build list of available documents
docs=()

# Always check these optional docs
[[ -f "$LITERATURE_REVIEW" ]] && docs+=("literature-review.md")
[[ -f "$DATA_ANALYSIS" ]] && docs+=("data-analysis.md")

# Check references directory (only if it exists and has files)
if [[ -d "$REFERENCES_DIR" ]] && [[ -n "$(ls -A "$REFERENCES_DIR" 2>/dev/null)" ]]; then
    docs+=("references/")
fi

[[ -f "$REFERENCES_BIB" ]] && docs+=("references.bib")
[[ -f "$QUICKSTART" ]] && docs+=("quickstart.md")

# Include tasks.md if requested and it exists
if $INCLUDE_TASKS && [[ -f "$TASKS" ]]; then
    docs+=("tasks.md")
fi

# Output results
if $JSON_MODE; then
    # Build JSON array of documents
    if [[ ${#docs[@]} -eq 0 ]]; then
        json_docs="[]"
    else
        json_docs=$(printf '"%s",' "${docs[@]}")
        json_docs="[${json_docs%,}]"
    fi

    printf '{"RESEARCH_DIR":"%s","AVAILABLE_DOCS":%s}\n' "$RESEARCH_DIR" "$json_docs"
else
    # Text output
    echo "RESEARCH_DIR:$RESEARCH_DIR"
    echo "AVAILABLE_DOCS:"

    # Show status of each potential document
    check_file "$LITERATURE_REVIEW" "literature-review.md"
    check_file "$DATA_ANALYSIS" "data-analysis.md"
    check_dir "$REFERENCES_DIR" "references/"
    check_file "$REFERENCES_BIB" "references.bib"
    check_file "$QUICKSTART" "quickstart.md"

    if $INCLUDE_TASKS; then
        check_file "$TASKS" "tasks.md"
    fi
fi
