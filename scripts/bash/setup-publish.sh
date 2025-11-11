#!/usr/bin/env bash

set -e

# Parse command line arguments
JSON_MODE=false
PUBLICATION_TYPE="report"
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json)
            JSON_MODE=true
            ;;
        --type=*)
            PUBLICATION_TYPE="${arg#*=}"
            ;;
        --help|-h)
            echo "Usage: $0 [--json] [--type=TYPE]"
            echo "  --json    Output results in JSON format"
            echo "  --type    Publication type (report|paper|presentation|brief)"
            echo "  --help    Show this help message"
            exit 0
            ;;
        *)
            ARGS+=("$arg")
            ;;
    esac
done

# Get script directory and load common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Get all paths and variables from common functions
eval $(get_research_paths)

# Check if we're on a proper research branch (only for git repos)
check_research_branch "$CURRENT_BRANCH" "$HAS_GIT" || exit 1

# Ensure the research directory exists
mkdir -p "$RESEARCH_DIR"

# Check phase dependencies - publish requires synthesis to be completed first
SYNTHESIS_FILE="$RESEARCH_DIR/synthesis.md"
if [[ ! -f "$SYNTHESIS_FILE" ]]; then
    echo "Error: synthesis.md not found in $RESEARCH_DIR"
    echo "Please run /research.synthesize before running /research.publish"
    echo ""
    echo "The research workflow phases must be completed in order:"
    echo "  1. /research.define - Define research question"
    echo "  2. /research.methodology - Design methodology"
    echo "  3. /research.execute - Collect data"
    echo "  4. /research.analyze - Analyze data"
    echo "  5. /research.synthesize - Draw conclusions"
    echo "  6. /research.publish - Create outputs (current step)"
    exit 1
fi

# Also check for critical prerequisite files
DEFINITION_FILE="$RESEARCH_DIR/definition.md"
ANALYSIS_FILE="$RESEARCH_DIR/analysis.md"
if [[ ! -f "$DEFINITION_FILE" ]] || [[ ! -f "$ANALYSIS_FILE" ]]; then
    echo "Warning: Missing critical files for publication"
    [[ ! -f "$DEFINITION_FILE" ]] && echo "  - definition.md not found"
    [[ ! -f "$ANALYSIS_FILE" ]] && echo "  - analysis.md not found"
    echo "Publication quality may be affected"
fi

# Create publications directory structure
PUBLICATIONS_DIR="$RESEARCH_DIR/publications"
REPORT_DIR="$PUBLICATIONS_DIR/report"
PAPER_DIR="$PUBLICATIONS_DIR/paper"
PRESENTATION_DIR="$PUBLICATIONS_DIR/presentation"
BRIEF_DIR="$PUBLICATIONS_DIR/brief"

mkdir -p "$REPORT_DIR"
mkdir -p "$PAPER_DIR"
mkdir -p "$PRESENTATION_DIR"
mkdir -p "$BRIEF_DIR"

echo "Created publication directories:"
echo "  - publications/report/ for comprehensive report"
echo "  - publications/paper/ for academic paper"
echo "  - publications/presentation/ for slide deck"
echo "  - publications/brief/ for executive summary"

# Create publication based on type
case "$PUBLICATION_TYPE" in
    report)
        REPORT_FILE="$REPORT_DIR/research_report.md"
        cat > "$REPORT_FILE" << 'EOF'
# [TITLE]: Research Report

## Executive Summary

### Background
[Brief context and motivation]

### Research Questions
[Key questions investigated]

### Methodology
[High-level approach]

### Key Findings
[Main discoveries - bullet points]

### Conclusions
[Primary conclusions]

### Recommendations
[Key recommendations]

---

## 1. Introduction

### 1.1 Background
[Detailed context and problem statement]

### 1.2 Research Questions
[Formal statement of research questions]

### 1.3 Objectives
[Specific research objectives]

### 1.4 Scope and Limitations
[Research boundaries and constraints]

### 1.5 Report Structure
[Overview of report sections]

## 2. Literature Review

### 2.1 Theoretical Framework
[Relevant theories and models]

### 2.2 Previous Research
[Summary of prior work]

### 2.3 Research Gaps
[Identified gaps this research addresses]

## 3. Methodology

### 3.1 Research Design
[Overall research approach]

### 3.2 Data Collection
[Data sources and collection methods]

### 3.3 Analysis Methods
[Analytical techniques used]

### 3.4 Quality Assurance
[Validation and verification approaches]

### 3.5 Ethical Considerations
[Ethical issues and how addressed]

## 4. Results

### 4.1 Data Overview
[Description of collected data]

### 4.2 Descriptive Statistics
[Summary statistics and characteristics]

### 4.3 Key Findings
[Main findings with supporting evidence]

### 4.4 Statistical Analysis
[Results of statistical tests]

### 4.5 Additional Observations
[Unexpected or secondary findings]

## 5. Discussion

### 5.1 Interpretation of Findings
[What the results mean]

### 5.2 Comparison with Literature
[How findings relate to existing knowledge]

### 5.3 Theoretical Implications
[Contributions to theory]

### 5.4 Practical Applications
[Real-world applications]

### 5.5 Limitations
[Study limitations and their impact]

## 6. Conclusions

### 6.1 Summary of Findings
[Concise recap of key findings]

### 6.2 Answering Research Questions
[Explicit answers to each research question]

### 6.3 Contributions
[Key contributions of this research]

### 6.4 Future Research
[Suggested future research directions]

## 7. Recommendations

### 7.1 Immediate Actions
[What should be done now]

### 7.2 Short-term Recommendations
[3-6 month timeframe]

### 7.3 Long-term Strategic Considerations
[Long-term implications]

### 7.4 Implementation Roadmap
[How to implement recommendations]

## References
[Complete bibliography in chosen citation style]

## Appendices

### Appendix A: Detailed Methodology
[Extended methodology description]

### Appendix B: Data Tables
[Detailed data tables]

### Appendix C: Statistical Outputs
[Full statistical results]

### Appendix D: Research Instruments
[Surveys, interview guides, etc.]
EOF
        echo "Created research report template at $REPORT_FILE"
        ;;

    paper)
        PAPER_FILE="$PAPER_DIR/manuscript.md"
        cat > "$PAPER_FILE" << 'EOF'
# [Title]

## Abstract
[250 words maximum summarizing background, methods, results, conclusions]

**Keywords**: [5-6 keywords]

## 1. Introduction
[Background, problem statement, research questions, paper structure]

## 2. Literature Review
[Theoretical background and related work]

## 3. Methodology
### 3.1 Research Design
### 3.2 Data Collection
### 3.3 Analysis

## 4. Results
### 4.1 Descriptive Findings
### 4.2 Main Results
### 4.3 Additional Analyses

## 5. Discussion
### 5.1 Theoretical Implications
### 5.2 Practical Implications
### 5.3 Limitations

## 6. Conclusion
[Summary, contributions, future work]

## Acknowledgments
[If applicable]

## References
[Formatted per journal requirements]

## Supplementary Materials
[Available at: URL]
EOF

        COVER_LETTER="$PAPER_DIR/cover_letter.md"
        cat > "$COVER_LETTER" << 'EOF'
# Cover Letter

Dear Editor,

We are pleased to submit our manuscript entitled "[Title]" for consideration for publication in [Journal Name].

## Significance
[Why this work is important and fits the journal]

## Novel Contributions
[What's new in this work]

## Confirmation Statements
- This manuscript has not been published elsewhere
- All authors have approved the submission
- No conflicts of interest exist

We believe this work will be of significant interest to the readers of [Journal] because [reasons].

Thank you for considering our manuscript.

Sincerely,
[Authors]
EOF
        echo "Created academic paper template at $PAPER_FILE"
        echo "Created cover letter template at $COVER_LETTER"
        ;;

    presentation)
        SLIDES_FILE="$PRESENTATION_DIR/slides.md"
        cat > "$SLIDES_FILE" << 'EOF'
# Research Presentation

---

## Slide 1: Title Slide
### [Research Title]
**Authors**: [Names]
**Institution**: [Organization]
**Date**: [Presentation Date]

---

## Slide 2: Agenda
1. Background & Motivation
2. Research Questions
3. Methodology
4. Key Findings
5. Discussion
6. Conclusions & Recommendations
7. Q&A

---

## Slide 3: Background
### The Problem
- [Key problem point 1]
- [Key problem point 2]
- [Key problem point 3]

**Why This Matters**: [One sentence impact statement]

---

## Slide 4: Research Questions
### What We Asked
1. [RQ1 in simple terms]
2. [RQ2 in simple terms]
3. [RQ3 in simple terms]

---

## Slide 5: Methodology
### How We Investigated
- **Approach**: [Research design]
- **Data**: [Data sources]
- **Analysis**: [Methods used]
- **Timeline**: [Study period]

---

## Slide 6: Key Finding 1
### [Finding Title]
[Visualization or key data]
- **What**: [Finding statement]
- **Evidence**: [Supporting data]
- **Impact**: [What this means]

---

## Slide 7: Key Finding 2
### [Finding Title]
[Visualization or key data]
- **What**: [Finding statement]
- **Evidence**: [Supporting data]
- **Impact**: [What this means]

---

## Slide 8: Key Finding 3
### [Finding Title]
[Visualization or key data]
- **What**: [Finding statement]
- **Evidence**: [Supporting data]
- **Impact**: [What this means]

---

## Slide 9: Discussion
### What It All Means
- **Confirms**: [What we validated]
- **Challenges**: [What we questioned]
- **Reveals**: [What's new]

---

## Slide 10: Limitations
### Study Boundaries
- [Limitation 1]
- [Limitation 2]
- [Limitation 3]

*These limitations [do/do not] significantly impact our conclusions*

---

## Slide 11: Conclusions
### Key Takeaways
1. **Main Conclusion**: [Primary finding]
2. **Implication**: [What organizations should do]
3. **Future**: [What comes next]

---

## Slide 12: Recommendations
### Action Items
**Immediate** (Now):
- [Action 1]

**Short-term** (3-6 months):
- [Action 2]

**Long-term** (1+ years):
- [Action 3]

---

## Slide 13: Future Research
### Next Steps
- [Research direction 1]
- [Research direction 2]
- [Research direction 3]

---

## Slide 14: Thank You
### Questions?

**Contact**: [Email]
**Full Report**: [Where to find it]
**Data**: [If publicly available]

---

## Slide 15: Backup Slides
[Additional detail slides for Q&A]
EOF
        echo "Created presentation template at $SLIDES_FILE"
        ;;

    brief)
        BRIEF_FILE="$BRIEF_DIR/executive_brief.md"
        cat > "$BRIEF_FILE" << 'EOF'
# Executive Brief: [Topic]

**Date**: [Date]
**Prepared for**: [Audience]
**Prepared by**: [Authors]

---

## The Issue
[1-2 sentences describing the problem or opportunity]

## What We Did
[1-2 sentences describing the research approach]

## What We Found

### Finding 1
**[Clear statement]**
Supporting evidence: [Brief data point]

### Finding 2
**[Clear statement]**
Supporting evidence: [Brief data point]

### Finding 3
**[Clear statement]**
Supporting evidence: [Brief data point]

## What This Means
[2-3 sentences on implications]

## Recommendations

1. **Immediate Action**: [What to do now]
   - Expected outcome: [Result]
   - Investment required: [Resources]

2. **Next Steps**: [What to do next]
   - Timeline: [When]
   - Responsibility: [Who]

## Evidence Quality
- **Data Sources**: [Number and types]
- **Confidence Level**: [High/Medium/Low]
- **Key Assumption**: [Main assumption if any]

## Bottom Line
[One sentence summary of the most important takeaway]

---

*For detailed findings and methodology, see full report at: [location]*
EOF
        echo "Created executive brief template at $BRIEF_FILE"
        ;;

    *)
        echo "Unknown publication type: $PUBLICATION_TYPE"
        echo "Using default (report)"
        ;;
esac

# Create metadata file
METADATA_FILE="$PUBLICATIONS_DIR/metadata.yml"
cat > "$METADATA_FILE" << EOF
# Publication Metadata
title: "[Full Title]"
authors:
  - name: "[Author 1]"
    affiliation: "[Institution]"
    email: "[Email]"
date: "$(date +%Y-%m-%d)"
type: "$PUBLICATION_TYPE"
version: "1.0.0"
keywords:
  - "[Keyword 1]"
  - "[Keyword 2]"
  - "[Keyword 3]"
abstract: |
  [Abstract if applicable]
license: "CC-BY-4.0"
doi: "[If assigned]"
url: "[If published online]"
EOF
echo "Created publication metadata"

# Create figures and assets directories
PUBLICATION_FIGURES="$PUBLICATIONS_DIR/figures"
PUBLICATION_TABLES="$PUBLICATIONS_DIR/tables"
PUBLICATION_ASSETS="$PUBLICATIONS_DIR/assets"

mkdir -p "$PUBLICATION_FIGURES"
mkdir -p "$PUBLICATION_TABLES"
mkdir -p "$PUBLICATION_ASSETS"

# Copy existing figures if they exist
if [[ -d "$RESEARCH_DIR/figures" ]]; then
    echo "Copying existing figures to publications..."
    cp -r "$RESEARCH_DIR/figures/"* "$PUBLICATION_FIGURES/" 2>/dev/null || true
fi

# Copy existing tables if they exist
if [[ -d "$RESEARCH_DIR/tables" ]]; then
    echo "Copying existing tables to publications..."
    cp -r "$RESEARCH_DIR/tables/"* "$PUBLICATION_TABLES/" 2>/dev/null || true
fi

# Create publication checklist
PUBLICATION_CHECKLIST="$PUBLICATIONS_DIR/publication_checklist.md"
cat > "$PUBLICATION_CHECKLIST" << 'EOF'
# Publication Checklist

## Content Review
- [ ] All research questions answered
- [ ] Key findings clearly stated
- [ ] Evidence properly cited
- [ ] Conclusions justified
- [ ] Recommendations actionable

## Quality Assurance
- [ ] Grammar and spelling checked
- [ ] Figures and tables referenced
- [ ] Citations complete and formatted
- [ ] Terminology consistent
- [ ] Acronyms defined

## Format Compliance
- [ ] Follows target format guidelines
- [ ] Word/page limits met
- [ ] Section structure correct
- [ ] Reference style consistent
- [ ] File formats appropriate

## Review Process
- [ ] Internal review complete
- [ ] Feedback incorporated
- [ ] Final proofread done
- [ ] Metadata accurate
- [ ] Version controlled

## Submission Ready
- [ ] All required files present
- [ ] Submission guidelines followed
- [ ] Copyright/license specified
- [ ] Author information complete
- [ ] Conflicts of interest declared
EOF
echo "Created publication checklist"

# Create publication log
PUBLICATION_LOG="$RESEARCH_DIR/logs/publication_$(date +%Y%m%d_%H%M%S).log"
cat > "$PUBLICATION_LOG" << EOF
# Publication Log
Started: $(date)
Branch: $CURRENT_BRANCH
Research Dir: $RESEARCH_DIR
Publication Type: $PUBLICATION_TYPE

## Publication Setup
- Created publication directories
- Generated $PUBLICATION_TYPE template
- Copied existing assets
- Ready for content creation

## Publication Workflow
1. Load all research materials
2. Structure according to format
3. Write/compile content
4. Review and edit
5. Finalize for distribution

EOF
echo "Created publication log at $PUBLICATION_LOG"

# Output results
if $JSON_MODE; then
    printf '{"PUBLICATIONS_DIR":"%s","REPORT_DIR":"%s","PAPER_DIR":"%s","PRESENTATION_DIR":"%s","BRIEF_DIR":"%s","PUBLICATION_TYPE":"%s","METADATA_FILE":"%s","PUBLICATION_CHECKLIST":"%s","PUBLICATION_LOG":"%s","RESEARCH_DIR":"%s","BRANCH":"%s","HAS_GIT":"%s"}\n' \
        "$PUBLICATIONS_DIR" "$REPORT_DIR" "$PAPER_DIR" "$PRESENTATION_DIR" "$BRIEF_DIR" "$PUBLICATION_TYPE" "$METADATA_FILE" "$PUBLICATION_CHECKLIST" "$PUBLICATION_LOG" "$RESEARCH_DIR" "$CURRENT_BRANCH" "$HAS_GIT"
else
    echo "PUBLICATIONS_DIR: $PUBLICATIONS_DIR"
    echo "REPORT_DIR: $REPORT_DIR"
    echo "PAPER_DIR: $PAPER_DIR"
    echo "PRESENTATION_DIR: $PRESENTATION_DIR"
    echo "BRIEF_DIR: $BRIEF_DIR"
    echo "PUBLICATION_TYPE: $PUBLICATION_TYPE"
    echo "METADATA_FILE: $METADATA_FILE"
    echo "PUBLICATION_CHECKLIST: $PUBLICATION_CHECKLIST"
    echo "PUBLICATION_LOG: $PUBLICATION_LOG"
    echo "RESEARCH_DIR: $RESEARCH_DIR"
    echo "BRANCH: $CURRENT_BRANCH"
    echo "HAS_GIT: $HAS_GIT"
fi