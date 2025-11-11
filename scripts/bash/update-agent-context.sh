#!/usr/bin/env bash

# Update agent context files with information from methodology.md
#
# This script maintains AI agent context files by parsing research definitions
# and updating agent-specific configuration files with research information.
#
# MAIN FUNCTIONS:
# 1. Environment Validation
#    - Verifies git repository structure and branch information
#    - Checks for required methodology.md files and templates
#    - Validates file permissions and accessibility
#
# 2. Methodology Data Extraction
#    - Parses methodology.md files to extract research metadata
#    - Identifies research type, questions, methods, and data sources
#    - Handles missing or incomplete research data gracefully
#
# 3. Agent File Management
#    - Creates new agent context files from templates when needed
#    - Updates existing agent files with new research information
#    - Preserves manual additions and custom configurations
#    - Supports multiple AI agent formats and directory structures
#
# 4. Content Generation
#    - Generates research-specific workflow guidance
#    - Creates appropriate research directory structures
#    - Updates active research topics and recent findings sections
#    - Maintains consistent formatting and timestamps
#
# 5. Multi-Agent Support
#    - Handles agent-specific file paths and naming conventions
#    - Supports: Claude, Gemini, Copilot, Cursor, Qwen, opencode, Codex, Windsurf, Kilo Code, Auggie CLI, Roo Code, CodeBuddy CLI, Amp, or Amazon Q Developer CLI
#    - Can update single agents or all existing agent files
#    - Creates default Claude file if no agent files exist
#
# Usage: ./update-agent-context.sh [agent_type]
# Agent types: claude|gemini|copilot|cursor-agent|qwen|opencode|codex|windsurf|kilocode|auggie|q
# Leave empty to update all existing agent files

set -e

# Enable strict error handling
set -u
set -o pipefail

#==============================================================================
# Configuration and Global Variables
#==============================================================================

# Get script directory and load common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Get all paths and variables from common functions
eval $(get_feature_paths)

NEW_METHODOLOGY="$IMPL_PLAN"  # Alias for compatibility with existing code
AGENT_TYPE="${1:-}"

# Agent-specific file paths
CLAUDE_FILE="$REPO_ROOT/CLAUDE.md"
GEMINI_FILE="$REPO_ROOT/GEMINI.md"
COPILOT_FILE="$REPO_ROOT/.github/copilot-instructions.md"
CURSOR_FILE="$REPO_ROOT/.cursor/rules/research-rules.mdc"
QWEN_FILE="$REPO_ROOT/QWEN.md"
AGENTS_FILE="$REPO_ROOT/AGENTS.md"
WINDSURF_FILE="$REPO_ROOT/.windsurf/rules/research-rules.md"
KILOCODE_FILE="$REPO_ROOT/.kilocode/rules/research-rules.md"
AUGGIE_FILE="$REPO_ROOT/.augment/rules/research-rules.md"
ROO_FILE="$REPO_ROOT/.roo/rules/research-rules.md"
CODEBUDDY_FILE="$REPO_ROOT/CODEBUDDY.md"
AMP_FILE="$REPO_ROOT/AGENTS.md"
Q_FILE="$REPO_ROOT/AGENTS.md"

# Template file
TEMPLATE_FILE="$REPO_ROOT/.research/templates/agent-file-template.md"

# Global variables for parsed methodology data
NEW_RESEARCH_TYPE=""
NEW_RESEARCH_QUESTIONS=""
NEW_METHODS=""
NEW_DATA_SOURCES=""

#==============================================================================
# Utility Functions
#==============================================================================

log_info() {
    echo "INFO: $1"
}

log_success() {
    echo "✓ $1"
}

log_error() {
    echo "ERROR: $1" >&2
}

log_warning() {
    echo "WARNING: $1" >&2
}

# Cleanup function for temporary files
cleanup() {
    local exit_code=$?
    rm -f /tmp/agent_update_*_$$
    rm -f /tmp/manual_additions_$$
    exit $exit_code
}

# Set up cleanup trap
trap cleanup EXIT INT TERM

#==============================================================================
# Validation Functions
#==============================================================================

validate_environment() {
    # Check if we have a current branch/feature (git or non-git)
    if [[ -z "$CURRENT_BRANCH" ]]; then
        log_error "Unable to determine current research topic"
        if [[ "$HAS_GIT" == "true" ]]; then
            log_info "Make sure you're on a research topic branch"
        else
            log_info "Set RESEARCH_TOPIC environment variable or create a research topic first"
        fi
        exit 1
    fi

    # Check if methodology.md exists
    if [[ ! -f "$NEW_METHODOLOGY" ]]; then
        log_error "No methodology.md found at $NEW_METHODOLOGY"
        log_info "Make sure you're working on a research topic with a corresponding research directory"
        if [[ "$HAS_GIT" != "true" ]]; then
            log_info "Use: export RESEARCH_TOPIC=your-topic-name or create a new research topic first"
        fi
        exit 1
    fi

    # Check if template exists (needed for new files)
    if [[ ! -f "$TEMPLATE_FILE" ]]; then
        log_warning "Template file not found at $TEMPLATE_FILE"
        log_warning "Creating new agent files will fail"
    fi
}

#==============================================================================
# Methodology Parsing Functions
#==============================================================================

extract_methodology_field() {
    local field_pattern="$1"
    local methodology_file="$2"

    grep "^\*\*${field_pattern}\*\*: " "$methodology_file" 2>/dev/null | \
        head -1 | \
        sed "s|^\*\*${field_pattern}\*\*: ||" | \
        sed 's/^[ \t]*//;s/[ \t]*$//' | \
        grep -v "NEEDS CLARIFICATION" | \
        grep -v "^N/A$" || echo ""
}

parse_methodology_data() {
    local methodology_file="$1"

    if [[ ! -f "$methodology_file" ]]; then
        log_error "Methodology file not found: $methodology_file"
        return 1
    fi

    if [[ ! -r "$methodology_file" ]]; then
        log_error "Methodology file is not readable: $methodology_file"
        return 1
    fi

    log_info "Parsing research data from $methodology_file"

    NEW_RESEARCH_TYPE=$(extract_methodology_field "Research Type" "$methodology_file")
    NEW_RESEARCH_QUESTIONS=$(extract_methodology_field "Research Questions" "$methodology_file")
    NEW_METHODS=$(extract_methodology_field "Research Methods" "$methodology_file")
    NEW_DATA_SOURCES=$(extract_methodology_field "Data Sources" "$methodology_file")

    # Log what we found
    if [[ -n "$NEW_RESEARCH_TYPE" ]]; then
        log_info "Found research type: $NEW_RESEARCH_TYPE"
    else
        log_warning "No research type information found in methodology"
    fi

    if [[ -n "$NEW_RESEARCH_QUESTIONS" ]]; then
        log_info "Found research questions: $NEW_RESEARCH_QUESTIONS"
    fi

    if [[ -n "$NEW_METHODS" ]]; then
        log_info "Found research methods: $NEW_METHODS"
    fi

    if [[ -n "$NEW_DATA_SOURCES" ]] && [[ "$NEW_DATA_SOURCES" != "N/A" ]]; then
        log_info "Found data sources: $NEW_DATA_SOURCES"
    fi
}

format_research_description() {
    local research_type="$1"
    local research_questions="$2"
    local parts=()

    # Add non-empty parts
    [[ -n "$research_type" && "$research_type" != "NEEDS CLARIFICATION" ]] && parts+=("$research_type")
    [[ -n "$research_questions" && "$research_questions" != "NEEDS CLARIFICATION" && "$research_questions" != "N/A" ]] && parts+=("$research_questions")

    # Join with proper formatting
    if [[ ${#parts[@]} -eq 0 ]]; then
        echo ""
    elif [[ ${#parts[@]} -eq 1 ]]; then
        echo "${parts[0]}"
    else
        # Join multiple parts with " - "
        local result="${parts[0]}"
        for ((i=1; i<${#parts[@]}; i++)); do
            result="$result - ${parts[i]}"
        done
        echo "$result"
    fi
}

#==============================================================================
# Template and Content Generation Functions
#==============================================================================

get_research_principles() {
    local principles_file="$REPO_ROOT/principles/research-principles.md"

    if [[ -f "$principles_file" ]] && [[ -r "$principles_file" ]]; then
        # Extract first 5 lines after the heading as a summary
        grep -A 5 "^#" "$principles_file" 2>/dev/null | tail -n 5 | head -n 5 || echo "Follow rigorous research methodology and ethical guidelines"
    else
        echo "Follow rigorous research methodology and ethical guidelines"
    fi
}

get_research_activities() {
    local research_type="$1"

    case "$research_type" in
        *"Academic"*)
            echo "- Literature review in academic databases\\n- Critical analysis of peer-reviewed sources\\n- Synthesis of theoretical frameworks"
            ;;
        *"Market"*)
            echo "- Industry report analysis\\n- Competitive landscape mapping\\n- Trend identification and validation"
            ;;
        *"Technical"*)
            echo "- Documentation review\\n- Technical feasibility assessment\\n- Implementation comparison"
            ;;
        *)
            echo "- Source identification and evaluation\\n- Data collection and organization\\n- Synthesis and reporting"
            ;;
    esac
}

create_new_agent_file() {
    local target_file="$1"
    local temp_file="$2"
    local project_name="$3"
    local current_date="$4"

    if [[ ! -f "$TEMPLATE_FILE" ]]; then
        log_error "Template not found at $TEMPLATE_FILE"
        return 1
    fi

    if [[ ! -r "$TEMPLATE_FILE" ]]; then
        log_error "Template file is not readable: $TEMPLATE_FILE"
        return 1
    fi

    log_info "Creating new agent context file from template..."

    if ! cp "$TEMPLATE_FILE" "$temp_file"; then
        log_error "Failed to copy template file"
        return 1
    fi

    # Replace template placeholders
    local research_principles
    research_principles=$(get_research_principles)

    local research_activities
    research_activities=$(get_research_activities "$NEW_RESEARCH_TYPE")

    # Escape special characters for sed
    local escaped_type=$(printf '%s\n' "$NEW_RESEARCH_TYPE" | sed 's/[\[\.*^$()+{}|]/\\&/g')
    local escaped_questions=$(printf '%s\n' "$NEW_RESEARCH_QUESTIONS" | sed 's/[\[\.*^$()+{}|]/\\&/g')
    local escaped_branch=$(printf '%s\n' "$CURRENT_BRANCH" | sed 's/[\[\.*^$()+{}|]/\\&/g')

    # Build research description and recent research strings conditionally
    local research_desc
    if [[ -n "$escaped_type" && -n "$escaped_questions" ]]; then
        research_desc="- $escaped_type - $escaped_questions ($escaped_branch)"
    elif [[ -n "$escaped_type" ]]; then
        research_desc="- $escaped_type ($escaped_branch)"
    elif [[ -n "$escaped_questions" ]]; then
        research_desc="- $escaped_questions ($escaped_branch)"
    else
        research_desc="- ($escaped_branch)"
    fi

    local recent_research
    if [[ -n "$escaped_type" && -n "$escaped_questions" ]]; then
        recent_research="- $escaped_branch: Completed $escaped_type research - $escaped_questions"
    elif [[ -n "$escaped_type" ]]; then
        recent_research="- $escaped_branch: Completed $escaped_type research"
    elif [[ -n "$escaped_questions" ]]; then
        recent_research="- $escaped_branch: Addressed research question - $escaped_questions"
    else
        recent_research="- $escaped_branch: Completed research"
    fi

    local substitutions=(
        "s|\[PROJECT_NAME\]|$project_name|"
        "s|\[DATE\]|$current_date|"
        "s|\[RESEARCH_PRINCIPLES\]|$research_principles|"
        "s|\[EXTRACTED_FROM_ALL_METHODOLOGY_FILES\]|$research_desc|"
        "s|\[ACTIVE_RESEARCH_ACTIVITIES\]|$research_activities|"
        "s|\[LAST_3_TOPICS_AND_KEY_FINDINGS\]|$recent_research|"
    )

    for substitution in "${substitutions[@]}"; do
        if ! sed -i.bak -e "$substitution" "$temp_file"; then
            log_error "Failed to perform substitution: $substitution"
            rm -f "$temp_file" "$temp_file.bak"
            return 1
        fi
    done

    # Convert \n sequences to actual newlines
    newline=$(printf '\n')
    sed -i.bak2 "s/\\\\n/${newline}/g" "$temp_file"

    # Clean up backup files
    rm -f "$temp_file.bak" "$temp_file.bak2"

    return 0
}




update_existing_agent_file() {
    local target_file="$1"
    local current_date="$2"

    log_info "Updating existing agent context file..."

    # Use a single temporary file for atomic update
    local temp_file
    temp_file=$(mktemp) || {
        log_error "Failed to create temporary file"
        return 1
    }

    # Process the file in one pass
    local research_desc=$(format_research_description "$NEW_RESEARCH_TYPE" "$NEW_RESEARCH_QUESTIONS")
    local new_research_entries=()
    local new_recent_entry=""

    # Prepare new research topic entries
    if [[ -n "$research_desc" ]] && ! grep -q "$research_desc" "$target_file"; then
        new_research_entries+=("- $research_desc ($CURRENT_BRANCH)")
    fi

    if [[ -n "$NEW_METHODS" ]] && [[ "$NEW_METHODS" != "N/A" ]] && [[ "$NEW_METHODS" != "NEEDS CLARIFICATION" ]] && ! grep -q "$NEW_METHODS" "$target_file"; then
        new_research_entries+=("- Methods: $NEW_METHODS ($CURRENT_BRANCH)")
    fi

    # Prepare new recent research entry
    if [[ -n "$research_desc" ]]; then
        new_recent_entry="- $CURRENT_BRANCH: Completed $research_desc"
    elif [[ -n "$NEW_METHODS" ]] && [[ "$NEW_METHODS" != "N/A" ]] && [[ "$NEW_METHODS" != "NEEDS CLARIFICATION" ]]; then
        new_recent_entry="- $CURRENT_BRANCH: Used methods - $NEW_METHODS"
    fi

    # Check if sections exist in the file
    local has_active_research=0
    local has_recent_research=0

    if grep -q "^## Active Research Topics" "$target_file" 2>/dev/null; then
        has_active_research=1
    fi

    if grep -q "^## Recent Research" "$target_file" 2>/dev/null; then
        has_recent_research=1
    fi

    # Process file line by line
    local in_research_section=false
    local in_recent_section=false
    local research_entries_added=false
    local recent_entries_added=false
    local existing_recent_count=0
    local file_ended=false

    while IFS= read -r line || [[ -n "$line" ]]; do
        # Handle Active Research Topics section
        if [[ "$line" == "## Active Research Topics" ]]; then
            echo "$line" >> "$temp_file"
            in_research_section=true
            continue
        elif [[ $in_research_section == true ]] && [[ "$line" =~ ^##[[:space:]] ]]; then
            # Add new research entries before closing the section
            if [[ $research_entries_added == false ]] && [[ ${#new_research_entries[@]} -gt 0 ]]; then
                printf '%s\n' "${new_research_entries[@]}" >> "$temp_file"
                research_entries_added=true
            fi
            echo "$line" >> "$temp_file"
            in_research_section=false
            continue
        elif [[ $in_research_section == true ]] && [[ -z "$line" ]]; then
            # Add new research entries before empty line in research section
            if [[ $research_entries_added == false ]] && [[ ${#new_research_entries[@]} -gt 0 ]]; then
                printf '%s\n' "${new_research_entries[@]}" >> "$temp_file"
                research_entries_added=true
            fi
            echo "$line" >> "$temp_file"
            continue
        fi

        # Handle Recent Research section
        if [[ "$line" == "## Recent Research" ]]; then
            echo "$line" >> "$temp_file"
            # Add new recent entry right after the heading
            if [[ -n "$new_recent_entry" ]]; then
                echo "$new_recent_entry" >> "$temp_file"
            fi
            in_recent_section=true
            recent_entries_added=true
            continue
        elif [[ $in_recent_section == true ]] && [[ "$line" =~ ^##[[:space:]] ]]; then
            echo "$line" >> "$temp_file"
            in_recent_section=false
            continue
        elif [[ $in_recent_section == true ]] && [[ "$line" == "- "* ]]; then
            # Keep only first 2 existing recent entries
            if [[ $existing_recent_count -lt 2 ]]; then
                echo "$line" >> "$temp_file"
                ((existing_recent_count++))
            fi
            continue
        fi

        # Update timestamp
        if [[ "$line" =~ \*\*Last\ updated\*\*:.*[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] ]] || [[ "$line" =~ Last\ updated:.*[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] ]]; then
            echo "$line" | sed "s/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/$current_date/" >> "$temp_file"
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$target_file"

    # Post-loop check: if we're still in the Active Research Topics section and haven't added new entries
    if [[ $in_research_section == true ]] && [[ $research_entries_added == false ]] && [[ ${#new_research_entries[@]} -gt 0 ]]; then
        printf '%s\n' "${new_research_entries[@]}" >> "$temp_file"
        research_entries_added=true
    fi

    # If sections don't exist, add them at the end of the file
    if [[ $has_active_research -eq 0 ]] && [[ ${#new_research_entries[@]} -gt 0 ]]; then
        echo "" >> "$temp_file"
        echo "## Active Research Topics" >> "$temp_file"
        printf '%s\n' "${new_research_entries[@]}" >> "$temp_file"
        research_entries_added=true
    fi

    if [[ $has_recent_research -eq 0 ]] && [[ -n "$new_recent_entry" ]]; then
        echo "" >> "$temp_file"
        echo "## Recent Research" >> "$temp_file"
        echo "$new_recent_entry" >> "$temp_file"
        recent_entries_added=true
    fi

    # Move temp file to target atomically
    if ! mv "$temp_file" "$target_file"; then
        log_error "Failed to update target file"
        rm -f "$temp_file"
        return 1
    fi

    return 0
}
#==============================================================================
# Main Agent File Update Function
#==============================================================================

update_agent_file() {
    local target_file="$1"
    local agent_name="$2"

    if [[ -z "$target_file" ]] || [[ -z "$agent_name" ]]; then
        log_error "update_agent_file requires target_file and agent_name parameters"
        return 1
    fi

    log_info "Updating $agent_name context file: $target_file"

    local project_name
    project_name=$(basename "$REPO_ROOT")
    local current_date
    current_date=$(date +%Y-%m-%d)

    # Create directory if it doesn't exist
    local target_dir
    target_dir=$(dirname "$target_file")
    if [[ ! -d "$target_dir" ]]; then
        if ! mkdir -p "$target_dir"; then
            log_error "Failed to create directory: $target_dir"
            return 1
        fi
    fi

    if [[ ! -f "$target_file" ]]; then
        # Create new file from template
        local temp_file
        temp_file=$(mktemp) || {
            log_error "Failed to create temporary file"
            return 1
        }

        if create_new_agent_file "$target_file" "$temp_file" "$project_name" "$current_date"; then
            if mv "$temp_file" "$target_file"; then
                log_success "Created new $agent_name context file"
            else
                log_error "Failed to move temporary file to $target_file"
                rm -f "$temp_file"
                return 1
            fi
        else
            log_error "Failed to create new agent file"
            rm -f "$temp_file"
            return 1
        fi
    else
        # Update existing file
        if [[ ! -r "$target_file" ]]; then
            log_error "Cannot read existing file: $target_file"
            return 1
        fi

        if [[ ! -w "$target_file" ]]; then
            log_error "Cannot write to existing file: $target_file"
            return 1
        fi

        if update_existing_agent_file "$target_file" "$current_date"; then
            log_success "Updated existing $agent_name context file"
        else
            log_error "Failed to update existing agent file"
            return 1
        fi
    fi

    return 0
}

#==============================================================================
# Agent Selection and Processing
#==============================================================================

update_specific_agent() {
    local agent_type="$1"

    case "$agent_type" in
        claude)
            update_agent_file "$CLAUDE_FILE" "Claude Code"
            ;;
        gemini)
            update_agent_file "$GEMINI_FILE" "Gemini CLI"
            ;;
        copilot)
            update_agent_file "$COPILOT_FILE" "GitHub Copilot"
            ;;
        cursor-agent)
            update_agent_file "$CURSOR_FILE" "Cursor IDE"
            ;;
        qwen)
            update_agent_file "$QWEN_FILE" "Qwen Code"
            ;;
        opencode)
            update_agent_file "$AGENTS_FILE" "opencode"
            ;;
        codex)
            update_agent_file "$AGENTS_FILE" "Codex CLI"
            ;;
        windsurf)
            update_agent_file "$WINDSURF_FILE" "Windsurf"
            ;;
        kilocode)
            update_agent_file "$KILOCODE_FILE" "Kilo Code"
            ;;
        auggie)
            update_agent_file "$AUGGIE_FILE" "Auggie CLI"
            ;;
        roo)
            update_agent_file "$ROO_FILE" "Roo Code"
            ;;
        codebuddy)
            update_agent_file "$CODEBUDDY_FILE" "CodeBuddy CLI"
            ;;
        amp)
            update_agent_file "$AMP_FILE" "Amp"
            ;;
        q)
            update_agent_file "$Q_FILE" "Amazon Q Developer CLI"
            ;;
        *)
            log_error "Unknown agent type '$agent_type'"
            log_error "Expected: claude|gemini|copilot|cursor-agent|qwen|opencode|codex|windsurf|kilocode|auggie|roo|amp|q"
            exit 1
            ;;
    esac
}

update_all_existing_agents() {
    local found_agent=false

    # Check each possible agent file and update if it exists
    if [[ -f "$CLAUDE_FILE" ]]; then
        update_agent_file "$CLAUDE_FILE" "Claude Code"
        found_agent=true
    fi

    if [[ -f "$GEMINI_FILE" ]]; then
        update_agent_file "$GEMINI_FILE" "Gemini CLI"
        found_agent=true
    fi

    if [[ -f "$COPILOT_FILE" ]]; then
        update_agent_file "$COPILOT_FILE" "GitHub Copilot"
        found_agent=true
    fi

    if [[ -f "$CURSOR_FILE" ]]; then
        update_agent_file "$CURSOR_FILE" "Cursor IDE"
        found_agent=true
    fi

    if [[ -f "$QWEN_FILE" ]]; then
        update_agent_file "$QWEN_FILE" "Qwen Code"
        found_agent=true
    fi

    if [[ -f "$AGENTS_FILE" ]]; then
        update_agent_file "$AGENTS_FILE" "Codex/opencode"
        found_agent=true
    fi

    if [[ -f "$WINDSURF_FILE" ]]; then
        update_agent_file "$WINDSURF_FILE" "Windsurf"
        found_agent=true
    fi

    if [[ -f "$KILOCODE_FILE" ]]; then
        update_agent_file "$KILOCODE_FILE" "Kilo Code"
        found_agent=true
    fi

    if [[ -f "$AUGGIE_FILE" ]]; then
        update_agent_file "$AUGGIE_FILE" "Auggie CLI"
        found_agent=true
    fi

    if [[ -f "$ROO_FILE" ]]; then
        update_agent_file "$ROO_FILE" "Roo Code"
        found_agent=true
    fi

    if [[ -f "$CODEBUDDY_FILE" ]]; then
        update_agent_file "$CODEBUDDY_FILE" "CodeBuddy CLI"
        found_agent=true
    fi

    if [[ -f "$Q_FILE" ]]; then
        update_agent_file "$Q_FILE" "Amazon Q Developer CLI"
        found_agent=true
    fi

    # If no agent files exist, create a default Claude file
    if [[ "$found_agent" == false ]]; then
        log_info "No existing agent files found, creating default Claude file..."
        update_agent_file "$CLAUDE_FILE" "Claude Code"
    fi
}
print_summary() {
    echo
    log_info "Summary of research context updates:"

    if [[ -n "$NEW_RESEARCH_TYPE" ]]; then
        echo "  - Research type: $NEW_RESEARCH_TYPE"
    fi

    if [[ -n "$NEW_RESEARCH_QUESTIONS" ]]; then
        echo "  - Research questions: $NEW_RESEARCH_QUESTIONS"
    fi

    if [[ -n "$NEW_METHODS" ]]; then
        echo "  - Research methods: $NEW_METHODS"
    fi

    if [[ -n "$NEW_DATA_SOURCES" ]] && [[ "$NEW_DATA_SOURCES" != "N/A" ]]; then
        echo "  - Data sources: $NEW_DATA_SOURCES"
    fi

    echo
    log_info "Agent context files updated with current research information"
    echo

    log_info "Usage: $0 [claude|gemini|copilot|cursor-agent|qwen|opencode|codex|windsurf|kilocode|auggie|codebuddy|q]"
}

#==============================================================================
# Main Execution
#==============================================================================

main() {
    # Validate environment before proceeding
    validate_environment

    log_info "=== Updating agent context files for research topic $CURRENT_BRANCH ==="

    # Parse the methodology file to extract research information
    if ! parse_methodology_data "$NEW_METHODOLOGY"; then
        log_error "Failed to parse methodology data"
        exit 1
    fi

    # Process based on agent type argument
    local success=true

    if [[ -z "$AGENT_TYPE" ]]; then
        # No specific agent provided - update all existing agent files
        log_info "No agent specified, updating all existing agent files..."
        if ! update_all_existing_agents; then
            success=false
        fi
    else
        # Specific agent provided - update only that agent
        log_info "Updating specific agent: $AGENT_TYPE"
        if ! update_specific_agent "$AGENT_TYPE"; then
            success=false
        fi
    fi

    # Print summary
    print_summary

    if [[ "$success" == true ]]; then
        log_success "Agent context update completed successfully"
        exit 0
    else
        log_error "Agent context update completed with errors"
        exit 1
    fi
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

