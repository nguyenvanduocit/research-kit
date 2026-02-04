#!/usr/bin/env bash
# Common functions and variables for all scripts

# Get repository root, with fallback for non-git repositories
get_repo_root() {
    if git rev-parse --show-toplevel >/dev/null 2>&1; then
        git rev-parse --show-toplevel
    else
        # Fall back to script location for non-git repos
        local script_dir="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        (cd "$script_dir/../../.." && pwd)
    fi
}

# Get current branch, with fallback for non-git repositories
get_current_branch() {
    # First check if RESEARCH_TOPIC environment variable is set
    if [[ -n "${RESEARCH_TOPIC:-}" ]]; then
        echo "$RESEARCH_TOPIC"
        return
    fi

    # Then check git if available
    if git rev-parse --abbrev-ref HEAD >/dev/null 2>&1; then
        git rev-parse --abbrev-ref HEAD
        return
    fi

    # For non-git repos, try to find the latest research directory
    local repo_root=$(get_repo_root)
    local research_dir="$repo_root/research"

    if [[ -d "$research_dir" ]]; then
        local latest_topic=""
        local highest=0

        for dir in "$research_dir"/*; do
            if [[ -d "$dir" ]]; then
                local dirname=$(basename "$dir")
                if [[ "$dirname" =~ ^([0-9]{3})- ]]; then
                    local number=${BASH_REMATCH[1]}
                    number=$((10#$number))
                    if [[ "$number" -gt "$highest" ]]; then
                        highest=$number
                        latest_topic=$dirname
                    fi
                fi
            fi
        done

        if [[ -n "$latest_topic" ]]; then
            echo "$latest_topic"
            return
        fi
    fi

    echo "main"  # Final fallback
}

# Check if we have git available
has_git() {
    git rev-parse --show-toplevel >/dev/null 2>&1
}

check_research_branch() {
    local branch="$1"
    local has_git_repo="$2"

    # For non-git repos, we can't enforce branch naming but still provide output
    if [[ "$has_git_repo" != "true" ]]; then
        echo "[research-kit] Warning: Git repository not detected; skipped branch validation" >&2
        return 0
    fi

    if [[ ! "$branch" =~ ^[0-9]{3}- ]]; then
        echo "ERROR: Not on a research branch. Current branch: $branch" >&2
        echo "Research branches should be named like: 001-topic-name" >&2
        return 1
    fi

    return 0
}

get_research_dir() {
    echo "$1/research/$2"
}

# Find research directory by numeric prefix instead of exact branch match
# This allows multiple branches to work on the same research topic (e.g., 004-analysis, 004-methodology)
find_research_dir_by_prefix() {
    local repo_root="$1"
    local branch_name="$2"

    local research_dir="$repo_root/research"

    # Extract numeric prefix from branch (e.g., "004" from "004-whatever")
    if [[ ! "$branch_name" =~ ^([0-9]{3})- ]]; then
        # If branch doesn't have numeric prefix, fall back to exact match
        echo "$research_dir/$branch_name"
        return
    fi

    local prefix="${BASH_REMATCH[1]}"

    # Search for directories that start with this prefix
    local matches=()
    if [[ -d "$research_dir" ]]; then
        for dir in "$research_dir"/"$prefix"-*; do
            if [[ -d "$dir" ]]; then
                matches+=("$(basename "$dir")")
            fi
        done
    fi

    # Handle results
    if [[ ${#matches[@]} -eq 0 ]]; then
        # No match found - return the branch name path (will fail later with clear error)
        echo "$research_dir/$branch_name"
    elif [[ ${#matches[@]} -eq 1 ]]; then
        # Exactly one match - perfect!
        echo "$research_dir/${matches[0]}"
    else
        # Multiple matches - this shouldn't happen with proper naming convention
        echo "ERROR: Multiple research directories found with prefix '$prefix': ${matches[*]}" >&2
        echo "Please ensure only one research directory exists per numeric prefix." >&2
        echo "$research_dir/$branch_name"  # Return something to avoid breaking the script
    fi
}

get_research_paths() {
    local repo_root=$(get_repo_root)
    local current_branch=$(get_current_branch)
    local has_git_repo="false"

    if has_git; then
        has_git_repo="true"
    fi

    # Use prefix-based lookup to support multiple branches per research topic
    local research_dir=$(find_research_dir_by_prefix "$repo_root" "$current_branch")

    cat <<EOF
REPO_ROOT='$repo_root'
CURRENT_BRANCH='$current_branch'
HAS_GIT='$has_git_repo'
RESEARCH_DIR='$research_dir'
RESEARCH_DEFINITION='$research_dir/definition.md'
RESEARCH_METHODOLOGY='$research_dir/methodology.md'
RESEARCH_TASKS='$research_dir/tasks.md'
RESEARCH_LITERATURE_REVIEW='$research_dir/literature-review.md'
RESEARCH_DATA_SOURCES='$research_dir/data-sources.md'
RESEARCH_FINDINGS='$research_dir/findings.md'
RESEARCH_REFERENCES='$research_dir/references.bib'
RESEARCH_DATA_ANALYSIS='$research_dir/data-analysis.md'
RESEARCH_QUICKSTART='$research_dir/quickstart.md'
RESEARCH_REFERENCES_DIR='$research_dir/references'
EOF
}

check_file() { [[ -f "$1" ]] && echo "  ✓ $2" || echo "  ✗ $2"; }
check_dir() { [[ -d "$1" && -n $(ls -A "$1" 2>/dev/null) ]] && echo "  ✓ $2" || echo "  ✗ $2"; }

# Source quality gate functions
_COMMON_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$_COMMON_DIR/quality-gate.sh"

# Check if --force flag is present in args
# Usage: FORCE_MODE=$(parse_force_flag "$@")
parse_force_flag() {
    for arg in "$@"; do
        if [[ "$arg" == "--force" ]]; then
            echo "true"
            return
        fi
    done
    echo "false"
}
