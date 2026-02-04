#!/usr/bin/env bash
# Quality gate checks for SRD phase transitions
# This file is SOURCED by common.sh - do not execute directly

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Gate state
GATE_CRITICAL_PASS=0
GATE_CRITICAL_FAIL=0
GATE_REQUIRED_PASS=0
GATE_REQUIRED_FAIL=0
GATE_RECOMMENDED_PASS=0
GATE_RECOMMENDED_FAIL=0
GATE_RESULTS=""

gate_reset() {
    GATE_CRITICAL_PASS=0
    GATE_CRITICAL_FAIL=0
    GATE_REQUIRED_PASS=0
    GATE_REQUIRED_FAIL=0
    GATE_RECOMMENDED_PASS=0
    GATE_RECOMMENDED_FAIL=0
    GATE_RESULTS=""
}

gate_check_critical() {
    local description="$1"
    local result="$2"
    if [[ "$result" == "pass" ]]; then
        GATE_CRITICAL_PASS=$((GATE_CRITICAL_PASS + 1))
        GATE_RESULTS+="  ${GREEN}PASS${NC}  [CRITICAL]    $description\n"
    else
        GATE_CRITICAL_FAIL=$((GATE_CRITICAL_FAIL + 1))
        GATE_RESULTS+="  ${RED}FAIL${NC}  [CRITICAL]    $description\n"
    fi
}

gate_check_required() {
    local description="$1"
    local result="$2"
    if [[ "$result" == "pass" ]]; then
        GATE_REQUIRED_PASS=$((GATE_REQUIRED_PASS + 1))
        GATE_RESULTS+="  ${GREEN}PASS${NC}  [REQUIRED]    $description\n"
    else
        GATE_REQUIRED_FAIL=$((GATE_REQUIRED_FAIL + 1))
        GATE_RESULTS+="  ${RED}FAIL${NC}  [REQUIRED]    $description\n"
    fi
}

gate_check_recommended() {
    local description="$1"
    local result="$2"
    if [[ "$result" == "pass" ]]; then
        GATE_RECOMMENDED_PASS=$((GATE_RECOMMENDED_PASS + 1))
        GATE_RESULTS+="  ${GREEN}PASS${NC}  [RECOMMENDED] $description\n"
    else
        GATE_RECOMMENDED_FAIL=$((GATE_RECOMMENDED_FAIL + 1))
        GATE_RESULTS+="  ${YELLOW}WARN${NC}  [RECOMMENDED] $description\n"
    fi
}

check_file_min_lines() {
    local file="$1"
    local min="$2"
    if [[ ! -f "$file" ]]; then
        echo "fail"
        return
    fi
    local lines
    lines=$(wc -l < "$file" | tr -d ' ')
    if [[ "$lines" -ge "$min" ]]; then
        echo "pass"
    else
        echo "fail"
    fi
}

check_section_has_content() {
    local file="$1"
    local section_pattern="$2"
    if [[ ! -f "$file" ]]; then
        echo "fail"
        return
    fi
    # Find the section heading line number
    local heading_line
    heading_line=$(grep -n "^#" "$file" | grep -i "$section_pattern" | head -1 | cut -d: -f1)
    if [[ -z "$heading_line" ]]; then
        echo "fail"
        return
    fi
    # Find the next heading after this one
    local next_heading_line
    next_heading_line=$(awk -v start="$heading_line" 'NR > start && /^#/ { print NR; exit }' "$file")
    # Extract content between this heading and the next (or end of file)
    local content
    if [[ -n "$next_heading_line" ]]; then
        content=$(sed -n "$((heading_line + 1)),$((next_heading_line - 1))p" "$file")
    else
        content=$(sed -n "$((heading_line + 1)),\$p" "$file")
    fi
    # Strip blank lines and check if anything remains
    local stripped
    stripped=$(echo "$content" | grep -v '^[[:space:]]*$' | grep -v '^\[.*\]$' | grep -v '^-\s*$')
    if [[ -n "$stripped" ]]; then
        echo "pass"
    else
        echo "fail"
    fi
}

count_files_in_dir() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        echo "0"
        return
    fi
    find "$dir" -type f | wc -l | tr -d ' '
}


# Gate: definition -> methodology
gate_define_to_methodology() {
    local research_dir="$1"
    local def="$research_dir/definition.md"

    gate_reset
    echo -e "\n${YELLOW}Quality Gate: Definition -> Methodology${NC}\n"

    # CRITICAL: definition.md exists and has >20 lines
    gate_check_critical "definition.md exists and has >20 lines" \
        "$(check_file_min_lines "$def" 20)"

    # CRITICAL: key sections present
    for section in "Research Questions" "Scope" "Objectives" "Success Criteria"; do
        local present="fail"
        if [[ -f "$def" ]] && grep -qi "^#.*$section" "$def" 2>/dev/null; then
            present="pass"
        fi
        gate_check_critical "Section '$section' present in definition.md" "$present"
    done

    # REQUIRED: each section has actual content
    for section in "Research Questions" "Scope" "Objectives" "Success Criteria"; do
        gate_check_required "Section '$section' has content" \
            "$(check_section_has_content "$def" "$section")"
    done

    # REQUIRED: no unresolved markers
    local markers="pass"
    if [[ -f "$def" ]] && grep -q '\[NEEDS CLARIFICATION\]' "$def" 2>/dev/null; then
        markers="fail"
    fi
    gate_check_required "No unresolved [NEEDS CLARIFICATION] markers" "$markers"

    # RECOMMENDED: ethical considerations section
    local ethics="fail"
    if [[ -f "$def" ]] && grep -qi "^#.*[Ee]thical" "$def" 2>/dev/null; then
        ethics="pass"
    fi
    gate_check_recommended "Ethical considerations section present" "$ethics"
}

# Gate: methodology -> tasks
gate_methodology_to_tasks() {
    local research_dir="$1"
    local meth="$research_dir/methodology.md"
    local def="$research_dir/definition.md"

    gate_reset
    echo -e "\n${YELLOW}Quality Gate: Methodology -> Tasks${NC}\n"

    # CRITICAL: methodology.md exists and has >50 lines
    gate_check_critical "methodology.md exists and has >50 lines" \
        "$(check_file_min_lines "$meth" 50)"

    # CRITICAL: definition.md exists
    local def_exists="fail"
    [[ -f "$def" ]] && def_exists="pass"
    gate_check_critical "definition.md exists" "$def_exists"

    # CRITICAL: key sections present in methodology
    for section in "Research Design" "Data Sources" "Data Collection" "Analysis" "Ethical Considerations"; do
        local present="fail"
        if [[ -f "$meth" ]] && grep -qi "^#.*$section" "$meth" 2>/dev/null; then
            present="pass"
        fi
        gate_check_critical "Section '$section' present in methodology.md" "$present"
    done

    # REQUIRED: sections have content
    for section in "Research Design" "Data Sources" "Data Collection" "Analysis"; do
        gate_check_required "Section '$section' has content" \
            "$(check_section_has_content "$meth" "$section")"
    done

    # REQUIRED: bias mitigation mentioned
    local bias="fail"
    if [[ -f "$meth" ]] && grep -qi "bias" "$meth" 2>/dev/null; then
        bias="pass"
    fi
    gate_check_required "Bias mitigation mentioned" "$bias"

    # REQUIRED: limitations acknowledged
    local limitations="fail"
    if [[ -f "$meth" ]] && grep -qi "limitation" "$meth" 2>/dev/null; then
        limitations="pass"
    fi
    gate_check_required "Limitations acknowledged" "$limitations"
}

# Gate: tasks -> execute
gate_tasks_to_execute() {
    local research_dir="$1"
    local meth="$research_dir/methodology.md"
    local tasks="$research_dir/tasks.md"

    gate_reset
    echo -e "\n${YELLOW}Quality Gate: Tasks -> Execute${NC}\n"

    # CRITICAL: methodology.md exists
    local meth_exists="fail"
    [[ -f "$meth" ]] && meth_exists="pass"
    gate_check_critical "methodology.md exists" "$meth_exists"

    # CRITICAL: tasks.md exists and has >15 lines
    gate_check_critical "tasks.md exists and has >15 lines" \
        "$(check_file_min_lines "$tasks" 15)"

    # REQUIRED: at least 3 phases
    local phase_count=0
    if [[ -f "$tasks" ]]; then
        phase_count=$(grep -ci "phase" "$tasks" 2>/dev/null | head -1)
    fi
    local phases_ok="fail"
    [[ "$phase_count" -ge 3 ]] && phases_ok="pass"
    gate_check_required "At least 3 phases defined (found: $phase_count)" "$phases_ok"

    # REQUIRED: at least 15 tasks
    local task_count=0
    if [[ -f "$tasks" ]]; then
        task_count=$(grep -c '\- \[ \]' "$tasks" 2>/dev/null || echo "0")
    fi
    local tasks_ok="fail"
    [[ "$task_count" -ge 15 ]] && tasks_ok="pass"
    gate_check_required "At least 15 tasks defined (found: $task_count)" "$tasks_ok"

    # REQUIRED: dependencies documented
    local deps="fail"
    if [[ -f "$tasks" ]] && grep -qi "dependenc" "$tasks" 2>/dev/null; then
        deps="pass"
    fi
    gate_check_required "Dependencies documented" "$deps"
}

# Gate: execute -> analyze
gate_execute_to_analyze() {
    local research_dir="$1"
    local exec_file="$research_dir/execution.md"
    local sources_dir="$research_dir/sources"
    local sources_index="$sources_dir/SOURCES_INDEX.md"

    gate_reset
    echo -e "\n${YELLOW}Quality Gate: Execute -> Analyze${NC}\n"

    # CRITICAL: execution.md exists and has >30 lines
    gate_check_critical "execution.md exists and has >30 lines" \
        "$(check_file_min_lines "$exec_file" 30)"

    # CRITICAL: sources/ directory exists
    local sources_exists="fail"
    [[ -d "$sources_dir" ]] && sources_exists="pass"
    gate_check_critical "sources/ directory exists" "$sources_exists"

    # CRITICAL: at least 15 source files (excluding SOURCES_INDEX.md and .gitkeep)
    local source_count=0
    if [[ -d "$sources_dir" ]]; then
        source_count=$(find "$sources_dir" -type f \
            ! -name "SOURCES_INDEX.md" \
            ! -name ".gitkeep" \
            | wc -l | tr -d ' ')
    fi
    local sources_ok="fail"
    [[ "$source_count" -ge 15 ]] && sources_ok="pass"
    gate_check_critical "At least 15 source files in sources/ (found: $source_count)" "$sources_ok"

    # REQUIRED: SOURCES_INDEX.md exists and has >10 lines
    gate_check_required "SOURCES_INDEX.md exists and has >10 lines" \
        "$(check_file_min_lines "$sources_index" 10)"

    # REQUIRED: no URL-only citations in execution.md
    local url_only="pass"
    if [[ -f "$exec_file" ]] && grep -qE '^\s*https?://' "$exec_file" 2>/dev/null; then
        url_only="fail"
    fi
    gate_check_required "No URL-only citations in execution.md" "$url_only"

    # REQUIRED: data or sources have actual files
    local data_dir="$research_dir/data"
    local has_files="fail"
    if [[ -d "$sources_dir" ]] && [[ "$(count_files_in_dir "$sources_dir")" -gt 0 ]]; then
        has_files="pass"
    elif [[ -d "$data_dir" ]] && [[ "$(count_files_in_dir "$data_dir")" -gt 0 ]]; then
        has_files="pass"
    fi
    gate_check_required "Data or sources have actual files" "$has_files"
}

# Gate: analyze -> synthesize
gate_analyze_to_synthesize() {
    local research_dir="$1"
    local analysis="$research_dir/analysis.md"
    local figures_dir="$research_dir/figures"

    gate_reset
    echo -e "\n${YELLOW}Quality Gate: Analyze -> Synthesize${NC}\n"

    # CRITICAL: analysis.md exists and has >50 lines
    gate_check_critical "analysis.md exists and has >50 lines" \
        "$(check_file_min_lines "$analysis" 50)"

    # CRITICAL: Key Findings and Data Quality sections present
    for section in "Key Findings" "Data Quality"; do
        local present="fail"
        if [[ -f "$analysis" ]] && grep -qi "^#.*$section" "$analysis" 2>/dev/null; then
            present="pass"
        fi
        gate_check_critical "Section '$section' present in analysis.md" "$present"
    done

    # CRITICAL: Statistical Results or Pattern Analysis section present
    local stats_or_pattern="fail"
    if [[ -f "$analysis" ]]; then
        if grep -qi "^#.*Statistical Results" "$analysis" 2>/dev/null || \
           grep -qi "^#.*Pattern Analysis" "$analysis" 2>/dev/null; then
            stats_or_pattern="pass"
        fi
    fi
    gate_check_critical "'Statistical Results' or 'Pattern Analysis' section present" "$stats_or_pattern"

    # REQUIRED: at least 8 findings documented
    local finding_count=0
    if [[ -f "$analysis" ]]; then
        finding_count=$(grep -ci "finding" "$analysis" 2>/dev/null || echo "0")
    fi
    local findings_ok="fail"
    [[ "$finding_count" -ge 8 ]] && findings_ok="pass"
    gate_check_required "At least 8 findings documented (found: $finding_count)" "$findings_ok"

    # REQUIRED: at least 5 file:line citations
    local citation_count=0
    if [[ -f "$analysis" ]]; then
        citation_count=$(grep -cE 'sources/.*\.md:[0-9]' "$analysis" 2>/dev/null || echo "0")
    fi
    local citations_ok="fail"
    [[ "$citation_count" -ge 5 ]] && citations_ok="pass"
    gate_check_required "At least 5 file:line citations (found: $citation_count)" "$citations_ok"

    # REQUIRED: at least 3 files in figures/
    local figure_count=0
    if [[ -d "$figures_dir" ]]; then
        figure_count=$(find "$figures_dir" -type f | wc -l | tr -d ' ')
    fi
    local figures_ok="fail"
    [[ "$figure_count" -ge 3 ]] && figures_ok="pass"
    gate_check_required "At least 3 files in figures/ (found: $figure_count)" "$figures_ok"

    # REQUIRED: comparison with literature section has content
    gate_check_required "Comparison with literature section has content" \
        "$(check_section_has_content "$analysis" "Comparison with Literature")"
}

# Gate: synthesize -> publish
gate_synthesize_to_publish() {
    local research_dir="$1"
    local synthesis="$research_dir/synthesis.md"

    gate_reset
    echo -e "\n${YELLOW}Quality Gate: Synthesize -> Publish${NC}\n"

    # CRITICAL: synthesis.md exists and has >50 lines
    gate_check_critical "synthesis.md exists and has >50 lines" \
        "$(check_file_min_lines "$synthesis" 50)"

    # CRITICAL: key sections present
    for section in "Answers to Research Questions" "Conclusions" "Limitations" "Emergent Themes"; do
        local present="fail"
        if [[ -f "$synthesis" ]] && grep -qi "^#.*$section" "$synthesis" 2>/dev/null; then
            present="pass"
        fi
        gate_check_critical "Section '$section' present in synthesis.md" "$present"
    done

    # REQUIRED: confidence levels present
    local confidence="fail"
    if [[ -f "$synthesis" ]] && grep -qi "confidence" "$synthesis" 2>/dev/null; then
        confidence="pass"
    fi
    gate_check_required "Confidence levels present" "$confidence"

    # REQUIRED: practical implications has content
    gate_check_required "Practical implications has content" \
        "$(check_section_has_content "$synthesis" "Practical Implications")"

    # REQUIRED: future research directions has content
    gate_check_required "Future research directions has content" \
        "$(check_section_has_content "$synthesis" "Future Research")"

    # REQUIRED: limitations has content
    gate_check_required "Limitations has content" \
        "$(check_section_has_content "$synthesis" "Limitations")"
}


# Log a gate bypass to gate-log.md
log_gate_bypass() {
    local gate_name="$1"
    local research_dir="$2"
    local required_failures="$3"
    local gate_log="$research_dir/gate-log.md"

    if [[ ! -f "$gate_log" ]]; then
        cat > "$gate_log" << 'EOF'
# Quality Gate Bypass Log

| Date | Gate | Required Failures | Bypassed By |
|------|------|-------------------|-------------|
EOF
    fi

    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local user="${USER:-unknown}"
    echo "| $timestamp | $gate_name | $required_failures | $user (--force) |" >> "$gate_log"
}

# Run a quality gate and return appropriate exit code
# Usage: run_quality_gate <gate_name> <research_dir> <force_flag>
# Returns: 0 = pass, 1 = required failures (can force), 2 = critical failures (cannot bypass)
run_quality_gate() {
    local gate_name="$1"
    local research_dir="$2"
    local force_flag="${3:-false}"

    # Call the appropriate gate function
    case "$gate_name" in
        define_to_methodology)    gate_define_to_methodology "$research_dir" ;;
        methodology_to_tasks)     gate_methodology_to_tasks "$research_dir" ;;
        tasks_to_execute)         gate_tasks_to_execute "$research_dir" ;;
        execute_to_analyze)       gate_execute_to_analyze "$research_dir" ;;
        analyze_to_synthesize)    gate_analyze_to_synthesize "$research_dir" ;;
        synthesize_to_publish)    gate_synthesize_to_publish "$research_dir" ;;
        *)
            echo -e "${RED}Unknown gate: $gate_name${NC}" >&2
            return 2
            ;;
    esac

    # Print results
    echo -e "$GATE_RESULTS"

    # Summary
    local total_pass=$((GATE_CRITICAL_PASS + GATE_REQUIRED_PASS + GATE_RECOMMENDED_PASS))
    local total_fail=$((GATE_CRITICAL_FAIL + GATE_REQUIRED_FAIL + GATE_RECOMMENDED_FAIL))
    local total=$((total_pass + total_fail))

    echo ""
    echo -e "Summary: ${GREEN}$total_pass${NC}/$total passed"
    if [[ "$GATE_CRITICAL_FAIL" -gt 0 ]]; then
        echo -e "  ${RED}CRITICAL failures: $GATE_CRITICAL_FAIL${NC}"
    fi
    if [[ "$GATE_REQUIRED_FAIL" -gt 0 ]]; then
        echo -e "  ${RED}REQUIRED failures: $GATE_REQUIRED_FAIL${NC}"
    fi
    if [[ "$GATE_RECOMMENDED_FAIL" -gt 0 ]]; then
        echo -e "  ${YELLOW}RECOMMENDED warnings: $GATE_RECOMMENDED_FAIL${NC}"
    fi

    # Determine exit code
    if [[ "$GATE_CRITICAL_FAIL" -gt 0 ]]; then
        echo -e "\n${RED}BLOCKED: Critical checks failed. These cannot be bypassed.${NC}"
        return 2
    fi

    if [[ "$GATE_REQUIRED_FAIL" -gt 0 ]]; then
        if [[ "$force_flag" == "true" ]]; then
            echo -e "\n${YELLOW}WARNING: Bypassing $GATE_REQUIRED_FAIL required check(s) with --force${NC}"
            log_gate_bypass "$gate_name" "$research_dir" "$GATE_REQUIRED_FAIL"
            return 0
        else
            echo -e "\n${RED}BLOCKED: Required checks failed. Use --force to override.${NC}"
            return 1
        fi
    fi

    echo -e "\n${GREEN}All checks passed.${NC}"
    return 0
}
