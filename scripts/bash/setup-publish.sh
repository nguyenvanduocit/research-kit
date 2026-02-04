#!/usr/bin/env bash

set -e

# Parse command line arguments
JSON_MODE=false
FORCE_MODE=false
PUBLICATION_TYPE="report"
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json)
            JSON_MODE=true
            ;;
        --force)
            FORCE_MODE=true
            ;;
        --type=*)
            PUBLICATION_TYPE="${arg#*=}"
            ;;
        --help|-h)
            echo "Usage: $0 [--json] [--force] [--type=TYPE]"
            echo "  --json    Output results in JSON format"
            echo "  --force   Bypass REQUIRED quality gate checks (logged)"
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
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Get all paths and variables from common functions
eval $(get_research_paths)

# Check if we're on a proper research branch (only for git repos)
check_research_branch "$CURRENT_BRANCH" "$HAS_GIT" || exit 1

# Ensure the research directory exists
mkdir -p "$RESEARCH_DIR"

# Run quality gate: synthesize → publish
run_quality_gate "synthesize_to_publish" "$RESEARCH_DIR" "$FORCE_MODE" || exit $?

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
        # Copy Sli.dev template file
        SLIDES_FILE="$PRESENTATION_DIR/slides.md"

        # Find the template file (could be in different locations based on install method)
        TEMPLATE_FILE=""
        if [ -f "$REPO_ROOT/templates/presentation-template.md" ]; then
            TEMPLATE_FILE="$REPO_ROOT/templates/presentation-template.md"
        elif [ -f "$SCRIPT_DIR/../templates/presentation-template.md" ]; then
            TEMPLATE_FILE="$SCRIPT_DIR/../templates/presentation-template.md"
        elif [ -f "$HOME/.research-kit/templates/presentation-template.md" ]; then
            TEMPLATE_FILE="$HOME/.research-kit/templates/presentation-template.md"
        fi

        if [ -n "$TEMPLATE_FILE" ] && [ -f "$TEMPLATE_FILE" ]; then
            cp "$TEMPLATE_FILE" "$SLIDES_FILE"
            echo "Created Sli.dev presentation at $SLIDES_FILE"
            echo ""
            echo "To run the presentation:"
            echo "  bunx slidev $SLIDES_FILE"
            echo ""
            echo "Or with npm:"
            echo "  npx slidev $SLIDES_FILE"
        else
            # Fallback: create inline if template not found
            cat > "$SLIDES_FILE" << 'EOF'
---
# Configure the theme
theme: default
# Use custom background
background: https://source.unsplash.com/collection/94734566/1920x1080
# Apply unocss classes to the current slide
class: text-center
# Highlighting and drawing
highlighter: shiki
# Show line numbers in code blocks
lineNumbers: false
# Persist drawings in exports
drawings:
  persist: false
# Use slide transitions
transition: slide-left
# Use title of the page in the browser tab
title: Research Presentation
# Enable Monaco editor
monaco: true
# Download as PDF or PPT
download: true
# Presentation info
info: |
  ## Research Presentation

  Academic research presentation created with Sli.dev
---

# [Research Title]

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    Press Space for next slide <carbon:arrow-right class="inline"/>
  </span>
</div>

<div class="abs-br m-6 flex gap-2">
  <span class="text-sm opacity-50">Authors: [Names]</span>
</div>

<div class="abs-bl m-6 flex gap-2">
  <span class="text-sm opacity-50">Institution: [Organization] | Date: [Presentation Date]</span>
</div>

---
transition: fade-out
layout: default
---

# Agenda

<div class="grid grid-cols-2 gap-4 pt-4">

<div>

### Research Foundation
1. Background & Motivation
2. Research Questions
3. Methodology

</div>

<div>

### Findings & Impact
4. Key Findings
5. Discussion
6. Conclusions & Recommendations

</div>

</div>

<v-click>

<div class="mt-8 text-center text-sm opacity-75">
  Estimated Duration: 20 minutes + Q&A
</div>

</v-click>

---
layout: image-right
image: https://source.unsplash.com/collection/94734566/1920x1080
---

# Background

## The Problem

<v-clicks>

- **Issue 1**: [Key problem point 1]
- **Issue 2**: [Key problem point 2]
- **Issue 3**: [Key problem point 3]

</v-clicks>

<v-click>

<div class="mt-8 p-4 bg-blue-500 bg-opacity-20 rounded">
  <strong>Why This Matters</strong>: [One sentence impact statement]
</div>

</v-click>

---
layout: center
class: text-center
---

# Research Questions

<div class="text-left inline-block">

<v-clicks>

<div class="mb-6">
  <span class="text-3xl text-blue-500">1.</span>
  <span class="text-xl ml-2">[RQ1 in simple terms]</span>
</div>

<div class="mb-6">
  <span class="text-3xl text-green-500">2.</span>
  <span class="text-xl ml-2">[RQ2 in simple terms]</span>
</div>

<div class="mb-6">
  <span class="text-3xl text-yellow-500">3.</span>
  <span class="text-xl ml-2">[RQ3 in simple terms]</span>
</div>

</v-clicks>

</div>

---
layout: two-cols
---

# Methodology

How We Investigated

<v-clicks>

- **Approach**
  - [Research design]

- **Data Sources**
  - [Data sources]

- **Analysis Methods**
  - [Methods used]

- **Timeline**
  - [Study period]

</v-clicks>

::right::

<div class="flex h-full items-center">

```mermaid {theme: 'neutral', scale: 0.8}
graph TD
    A[Research Design] --> B[Data Collection]
    B --> C[Data Analysis]
    C --> D[Results Synthesis]
    D --> E[Conclusions]
```

</div>

---
layout: fact
---

# Key Findings

Three major discoveries from our research

---
layout: image-left
image: ./figures/finding1.png
---

# Finding 1

## [Finding Title]

<v-clicks>

- **What we found**
  - [Finding statement]

- **Supporting evidence**
  - [Supporting data]

- **Impact**
  - [What this means]

</v-clicks>

<v-click>

<div class="mt-4 p-3 bg-green-500 bg-opacity-20 rounded">
  <strong>Key Insight</strong>: [One-line summary]
</div>

</v-click>

---
layout: image-left
image: ./figures/finding2.png
---

# Finding 2

## [Finding Title]

<v-clicks>

- **What we found**
  - [Finding statement]

- **Supporting evidence**
  - [Supporting data]

- **Impact**
  - [What this means]

</v-clicks>

<v-click>

<div class="mt-4 p-3 bg-blue-500 bg-opacity-20 rounded">
  <strong>Key Insight</strong>: [One-line summary]
</div>

</v-click>

---
layout: image-left
image: ./figures/finding3.png
---

# Finding 3

## [Finding Title]

<v-clicks>

- **What we found**
  - [Finding statement]

- **Supporting evidence**
  - [Supporting data]

- **Impact**
  - [What this means]

</v-clicks>

<v-click>

<div class="mt-4 p-3 bg-purple-500 bg-opacity-20 rounded">
  <strong>Key Insight</strong>: [One-line summary]
</div>

</v-click>

---
layout: default
---

# Discussion

## What It All Means

<div class="grid grid-cols-3 gap-4 pt-4">

<v-click>
<div class="p-4 bg-green-500 bg-opacity-20 rounded">
  <h3 class="text-green-400 mb-2">✓ Confirms</h3>
  <p>[What we validated]</p>
</div>
</v-click>

<v-click>
<div class="p-4 bg-yellow-500 bg-opacity-20 rounded">
  <h3 class="text-yellow-400 mb-2">? Challenges</h3>
  <p>[What we questioned]</p>
</div>
</v-click>

<v-click>
<div class="p-4 bg-blue-500 bg-opacity-20 rounded">
  <h3 class="text-blue-400 mb-2">! Reveals</h3>
  <p>[What's new]</p>
</div>
</v-click>

</div>

---
layout: quote
---

# Limitations

<div class="text-xl">

Study Boundaries

</div>

<v-clicks>

- [Limitation 1]
- [Limitation 2]
- [Limitation 3]

</v-clicks>

<v-click>

<div class="mt-8 text-sm opacity-75 italic">
  These limitations [do/do not] significantly impact our conclusions
</div>

</v-click>

---
layout: statement
---

# Conclusions

<v-clicks>

<div class="text-2xl mb-6">
  <span class="text-blue-400">1.</span> **Main Conclusion**: [Primary finding]
</div>

<div class="text-2xl mb-6">
  <span class="text-green-400">2.</span> **Implication**: [What organizations should do]
</div>

<div class="text-2xl">
  <span class="text-yellow-400">3.</span> **Future**: [What comes next]
</div>

</v-clicks>

---
layout: default
---

# Recommendations

## Action Items

<v-clicks>

<div class="mb-6 p-4 bg-red-500 bg-opacity-20 rounded">
  <h3 class="text-red-400">🔥 Immediate (Now)</h3>
  <ul class="mt-2">
    <li>[Action 1]</li>
  </ul>
</div>

<div class="mb-6 p-4 bg-yellow-500 bg-opacity-20 rounded">
  <h3 class="text-yellow-400">📅 Short-term (3-6 months)</h3>
  <ul class="mt-2">
    <li>[Action 2]</li>
  </ul>
</div>

<div class="p-4 bg-blue-500 bg-opacity-20 rounded">
  <h3 class="text-blue-400">🎯 Long-term (1+ years)</h3>
  <ul class="mt-2">
    <li>[Action 3]</li>
  </ul>
</div>

</v-clicks>

---
layout: default
---

# Future Research

## Next Steps

<v-clicks>

<div class="space-y-4">

<div class="flex items-center space-x-3">
  <div class="text-3xl">🔬</div>
  <div>[Research direction 1]</div>
</div>

<div class="flex items-center space-x-3">
  <div class="text-3xl">📊</div>
  <div>[Research direction 2]</div>
</div>

<div class="flex items-center space-x-3">
  <div class="text-3xl">🌍</div>
  <div>[Research direction 3]</div>
</div>

</div>

</v-clicks>

---
layout: end
class: text-center
---

# Thank You

Questions?

<div class="pt-12">
  <span class="text-sm opacity-75">**Contact**: [Email]</span><br>
  <span class="text-sm opacity-75">**Full Report**: [Where to find it]</span><br>
  <span class="text-sm opacity-75">**Data**: [If publicly available]</span>
</div>

---
layout: section
---

# Backup Slides

Additional details for Q&A

---

# [Additional Detail Slide 1]

[Content for deeper dive on specific topics]

---

# [Additional Detail Slide 2]

[Content for deeper dive on specific topics]
EOF
            echo "Created Sli.dev presentation at $SLIDES_FILE (fallback template)"
            echo ""
            echo "To run the presentation:"
            echo "  bunx slidev $SLIDES_FILE"
            echo ""
            echo "Or with npm:"
            echo "  npx slidev $SLIDES_FILE"
        fi
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