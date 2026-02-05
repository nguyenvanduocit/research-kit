#!/usr/bin/env bash
# Download web content with metadata embedded in the file
# Usage: download-source.sh <url> <output-path>
#
# Example:
#   download-source.sh "https://arxiv.org/abs/2301.00001" sources/papers/smith-2024.md
#
# The output file will contain YAML frontmatter with source metadata:
#   ---
#   source_url: https://arxiv.org/abs/2301.00001
#   downloaded_at: 2024-02-05T14:30:00+07:00
#   ---
#   [content from markitdown...]

set -euo pipefail

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_error() { echo -e "${RED}ERROR: $1${NC}" >&2; }
print_success() { echo -e "${GREEN}$1${NC}"; }
print_warning() { echo -e "${YELLOW}$1${NC}"; }

usage() {
    cat <<EOF
Usage: $(basename "$0") <url> <output-path> [options]

Download web content and embed source URL metadata.

Arguments:
  url           URL to download
  output-path   Path to save the file (relative or absolute)

Options:
  --no-index    Don't update SOURCES_INDEX.md
  --title       Custom title for the source (default: extracted from URL)
  -h, --help    Show this help message

Examples:
  $(basename "$0") "https://arxiv.org/abs/2301.00001" sources/papers/smith-2024.md
  $(basename "$0") "https://example.com/article" sources/web/article.md --no-index
EOF
    exit 0
}

# Parse arguments
URL=""
OUTPUT_PATH=""
UPDATE_INDEX=true
CUSTOM_TITLE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        --no-index)
            UPDATE_INDEX=false
            shift
            ;;
        --title)
            CUSTOM_TITLE="$2"
            shift 2
            ;;
        *)
            if [[ -z "$URL" ]]; then
                URL="$1"
            elif [[ -z "$OUTPUT_PATH" ]]; then
                OUTPUT_PATH="$1"
            else
                print_error "Unknown argument: $1"
                usage
            fi
            shift
            ;;
    esac
done

# Validate arguments
if [[ -z "$URL" ]] || [[ -z "$OUTPUT_PATH" ]]; then
    print_error "Both URL and output path are required"
    usage
fi

# Check if markitdown is available
if ! command -v markitdown &> /dev/null; then
    print_error "markitdown is not installed"
    echo "Install with: pip install markitdown" >&2
    exit 1
fi

# Create output directory if needed
OUTPUT_DIR=$(dirname "$OUTPUT_PATH")
mkdir -p "$OUTPUT_DIR"

# Get current timestamp
TIMESTAMP=$(date -Iseconds 2>/dev/null || date +"%Y-%m-%dT%H:%M:%S%z")

# Download content using markitdown
echo "Downloading: $URL"
CONTENT=$(markitdown "$URL" 2>/dev/null) || {
    print_error "Failed to download content from: $URL"
    exit 1
}

# Check if content is empty
if [[ -z "$CONTENT" ]]; then
    print_error "Downloaded content is empty"
    exit 1
fi

# Count lines for metadata
LINE_COUNT=$(echo "$CONTENT" | wc -l | tr -d ' ')

# Extract title from content if not provided
if [[ -z "$CUSTOM_TITLE" ]]; then
    # Try to extract first heading from content
    CUSTOM_TITLE=$(echo "$CONTENT" | grep -m1 '^#' | sed 's/^#* *//' || echo "")
    if [[ -z "$CUSTOM_TITLE" ]]; then
        # Fallback to filename
        CUSTOM_TITLE=$(basename "$OUTPUT_PATH" .md)
    fi
fi

# Write file with frontmatter
cat > "$OUTPUT_PATH" <<EOF
---
source_url: $URL
downloaded_at: $TIMESTAMP
title: "$CUSTOM_TITLE"
---

$CONTENT
EOF

print_success "✓ Downloaded to: $OUTPUT_PATH"
echo "  Source: $URL"
echo "  Lines: $LINE_COUNT"

# Update SOURCES_INDEX.md if requested
if [[ "$UPDATE_INDEX" == true ]]; then
    eval "$(get_research_paths)"

    SOURCES_INDEX="$RESEARCH_DIR/sources/SOURCES_INDEX.md"

    if [[ -f "$SOURCES_INDEX" ]]; then
        # Get relative path from research dir
        REL_PATH=$(realpath --relative-to="$RESEARCH_DIR" "$OUTPUT_PATH" 2>/dev/null || echo "$OUTPUT_PATH")

        # Check if entry already exists
        if grep -q "$REL_PATH" "$SOURCES_INDEX" 2>/dev/null; then
            print_warning "Source already in index: $REL_PATH"
        else
            # Append to table (before the closing section if exists)
            DATE_ONLY=$(echo "$TIMESTAMP" | cut -d'T' -f1)
            echo "| $REL_PATH | $URL | $DATE_ONLY | $LINE_COUNT | Complete |" >> "$SOURCES_INDEX"
            print_success "✓ Updated SOURCES_INDEX.md"
        fi
    else
        print_warning "SOURCES_INDEX.md not found at: $SOURCES_INDEX"
        echo "  Run setup-execution.sh first to create the sources directory structure"
    fi
fi
