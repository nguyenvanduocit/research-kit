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

# Run quality gate: analyze → synthesize
run_quality_gate "analyze_to_synthesize" "$RESEARCH_DIR" "$FORCE_MODE" || exit $?

# Define synthesis file path
SYNTHESIS_FILE="$RESEARCH_DIR/synthesis.md"

# Copy synthesis template if it exists
SYNTHESIS_TEMPLATE="$REPO_ROOT/.research/templates/synthesis-template.md"
if [[ -f "$SYNTHESIS_TEMPLATE" ]]; then
    cp "$SYNTHESIS_TEMPLATE" "$SYNTHESIS_FILE"
    echo "Copied synthesis template to $SYNTHESIS_FILE"
else
    # Create a basic synthesis file if template doesn't exist
    cat > "$SYNTHESIS_FILE" << 'EOF'
# Research Synthesis

## Synthesis Overview
- Date: $(date +%Y-%m-%d)
- Research Questions Addressed: 0/0
- Key Themes Identified: 0
- Confidence Level: [TBD]

## Answers to Research Questions

### RQ1: [Research Question from definition.md]
**Answer**: [Clear, concise answer]
- **Supporting Evidence**:
  - [Finding with strength indicator]
- **Contradicting Evidence**:
  - [If any]
- **Confidence Level**: [High/Medium/Low]
- **Remaining Gaps**: [What we still don't know]

## Emergent Themes

### Theme 1: [Name]
**Description**: [What this theme represents]
- **Supporting Findings**: [List with references]
- **Cross-Data Evidence**: [Multiple sources]
- **Theoretical Link**: [Connection to theory]
- **Practical Relevance**: [Why it matters]

## Theoretical Contributions

### Contribution 1: [Statement]
- **Type**: [Extension/Modification/Novel]
- **Evidence Base**: [Supporting findings]
- **Relationship to Existing Theory**: [How it fits]
- **Significance**: [Why important]

## Practical Implications

### Implication 1: [For whom/what]
- **Recommendation**: [Specific action]
- **Based on**: [Which findings]
- **Expected Impact**: [Outcomes]
- **Implementation Considerations**: [Challenges]

## Integrated Conclusions

### Main Conclusion
[Overarching synthesis statement]

### Supporting Conclusions
1. [Conclusion with evidence]
2. [Conclusion with evidence]
3. [Conclusion with evidence]

## Limitations and Caveats
- **Scope Limitations**: [What wasn't covered]
- **Methodological Constraints**: [Impact on conclusions]
- **Generalizability**: [To what extent findings apply]
- **Confidence Boundaries**: [Where we're less certain]

## Future Research Directions
1. **Direction 1**: [What and why]
2. **Direction 2**: [What and why]
3. **Direction 3**: [What and why]

## Knowledge Contribution Summary
- **What We Now Know**: [Key additions to knowledge]
- **What We've Confirmed**: [Validated existing knowledge]
- **What We've Challenged**: [Contradicted assumptions]
- **What Remains Unknown**: [Persistent gaps]
EOF
    echo "Created synthesis file at $SYNTHESIS_FILE"
fi

# Create synthesis support directories
MODELS_DIR="$RESEARCH_DIR/models"
SYNTHESIS_FIGURES_DIR="$RESEARCH_DIR/figures/synthesis"
BRIEFS_DIR="$RESEARCH_DIR/briefs"

mkdir -p "$MODELS_DIR"
mkdir -p "$SYNTHESIS_FIGURES_DIR"
mkdir -p "$BRIEFS_DIR"

echo "Created synthesis directories:"
echo "  - models/ for conceptual models"
echo "  - figures/synthesis/ for synthesis visualizations"
echo "  - briefs/ for stakeholder briefs"

# Create conceptual model template
MODEL_TEMPLATE="$MODELS_DIR/conceptual_model.md"
cat > "$MODEL_TEMPLATE" << 'EOF'
# Conceptual Model

## Model Overview
[Description of the conceptual model emerging from synthesis]

## Core Components

### Component 1: [Name]
- Definition: [What it represents]
- Relationships: [How it connects to other components]
- Evidence: [Supporting findings]

### Component 2: [Name]
- Definition: [What it represents]
- Relationships: [How it connects to other components]
- Evidence: [Supporting findings]

## Relationships

### Relationship 1: [Component A → Component B]
- Type: [Causal/Correlational/Moderating/Mediating]
- Strength: [Strong/Moderate/Weak]
- Evidence: [Supporting data]

## Model Validation
- Internal consistency: [Assessment]
- External validity: [Assessment]
- Predictive power: [If applicable]

## Model Applications
1. [Application 1]
2. [Application 2]

## Model Limitations
- [Limitation 1]
- [Limitation 2]
EOF
echo "Created conceptual model template"

# Create executive summary template
EXEC_SUMMARY="$BRIEFS_DIR/executive_summary.md"
cat > "$EXEC_SUMMARY" << 'EOF'
# Executive Summary

## Research Topic
[One sentence description]

## Key Question
[What we sought to answer]

## Main Finding
[Most important discovery in 1-2 sentences]

## Why It Matters
[Business/practical impact in 2-3 sentences]

## Recommendations
1. **Immediate Action**: [What to do now]
2. **Short-term**: [Next 3-6 months]
3. **Long-term**: [Strategic considerations]

## Evidence Strength
- Confidence Level: [High/Medium/Low]
- Data Sources: [Number and types]
- Validation: [How findings were validated]

## Next Steps
[What should happen next]

---
*Full report available at: research/###-topic-name/publications/report/*
EOF
echo "Created executive summary template"

# Create synthesis checklist
SYNTHESIS_CHECKLIST="$RESEARCH_DIR/synthesis_checklist.md"
cat > "$SYNTHESIS_CHECKLIST" << 'EOF'
# Synthesis Checklist

## Research Questions
- [ ] All research questions addressed
- [ ] Clear answers provided
- [ ] Evidence level assessed
- [ ] Gaps acknowledged

## Theme Development
- [ ] Themes identified from patterns
- [ ] Cross-source validation
- [ ] Theoretical connections made
- [ ] Practical relevance established

## Integration Quality
- [ ] Findings connected coherently
- [ ] Contradictions addressed
- [ ] Alternative explanations considered
- [ ] Synthesis tells clear story

## Theoretical Contribution
- [ ] Contribution type identified
- [ ] Relationship to existing theory clear
- [ ] Novel insights highlighted
- [ ] Significance articulated

## Practical Implications
- [ ] Recommendations actionable
- [ ] Target audience identified
- [ ] Implementation feasibility assessed
- [ ] Expected impact described

## Quality Assurance
- [ ] Conclusions follow from evidence
- [ ] Overgeneralization avoided
- [ ] Limitations acknowledged
- [ ] Future directions justified
EOF
echo "Created synthesis checklist"

# Create synthesis log
SYNTHESIS_LOG="$RESEARCH_DIR/logs/synthesis_$(date +%Y%m%d_%H%M%S).log"
cat > "$SYNTHESIS_LOG" << EOF
# Synthesis Log
Started: $(date)
Branch: $CURRENT_BRANCH
Research Dir: $RESEARCH_DIR

## Synthesis Setup
- Created synthesis tracking file
- Initialized support directories
- Ready for findings integration

## Synthesis Process
1. Map findings to research questions
2. Identify emergent themes
3. Build theoretical contributions
4. Develop practical implications
5. Create integrated conclusions

EOF
echo "Created synthesis log at $SYNTHESIS_LOG"

# Output results
if $JSON_MODE; then
    printf '{"SYNTHESIS_FILE":"%s","MODELS_DIR":"%s","SYNTHESIS_FIGURES_DIR":"%s","BRIEFS_DIR":"%s","MODEL_TEMPLATE":"%s","EXEC_SUMMARY":"%s","SYNTHESIS_CHECKLIST":"%s","SYNTHESIS_LOG":"%s","RESEARCH_DIR":"%s","BRANCH":"%s","HAS_GIT":"%s"}\n' \
        "$SYNTHESIS_FILE" "$MODELS_DIR" "$SYNTHESIS_FIGURES_DIR" "$BRIEFS_DIR" "$MODEL_TEMPLATE" "$EXEC_SUMMARY" "$SYNTHESIS_CHECKLIST" "$SYNTHESIS_LOG" "$RESEARCH_DIR" "$CURRENT_BRANCH" "$HAS_GIT"
else
    echo "SYNTHESIS_FILE: $SYNTHESIS_FILE"
    echo "MODELS_DIR: $MODELS_DIR"
    echo "SYNTHESIS_FIGURES_DIR: $SYNTHESIS_FIGURES_DIR"
    echo "BRIEFS_DIR: $BRIEFS_DIR"
    echo "MODEL_TEMPLATE: $MODEL_TEMPLATE"
    echo "EXEC_SUMMARY: $EXEC_SUMMARY"
    echo "SYNTHESIS_CHECKLIST: $SYNTHESIS_CHECKLIST"
    echo "SYNTHESIS_LOG: $SYNTHESIS_LOG"
    echo "RESEARCH_DIR: $RESEARCH_DIR"
    echo "BRANCH: $CURRENT_BRANCH"
    echo "HAS_GIT: $HAS_GIT"
fi