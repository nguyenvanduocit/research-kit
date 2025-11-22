---
description: Generate research methodology document based on research definition
handoffs:
  - label: Validate Methodology
    agent: research.validate
    prompt: Validate research methodology for rigor and feasibility
  - label: Generate Tasks
    agent: research.tasks
    prompt: Break down methodology into actionable tasks
    send: true
scripts:
  sh: scripts/bash/setup-methodology.sh
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command generates a comprehensive research methodology based on the research definition. Run this **after** `/research.define` (and optionally `/research.refine`).

**IMPORTANT**: The setup script (`scripts/bash/setup-methodology.sh`) will automatically:
- Create methodology directory structure
- Initialize methodology template (`methodology.md`)
- Set up supporting document templates (literature review, data sources, ethics)
- Verify prerequisite phases have been completed (especially `definition.md`)

**DO NOT manually create these directories or files - the script `{SCRIPT}` handles everything!**

1. **Run the methodology setup script** `{SCRIPT}` which will set up all required files and verify prerequisites

2. **Load research definition** from `research/###-topic-name/definition.md`

3. **Design research methodology** covering:

   **A. Research Design**:
   - Type: Qualitative / Quantitative / Mixed Methods
   - Approach: Exploratory / Descriptive / Explanatory / Evaluative
   - Justification for chosen approach

   **B. Data Sources**:
   - **Primary Sources**: (if applicable)
     * Interviews, surveys, experiments
     * Criteria for selection
     * Sample size/selection method
   - **Secondary Sources**:
     * Academic databases (Google Scholar, PubMed, IEEE Xplore, etc.)
     * Industry reports and whitepapers
     * Government/institutional data
     * Books and authoritative publications
     * News and media (with credibility criteria)
   - **Source Quality Criteria**:
     * Credibility assessment framework
     * Recency requirements
     * Bias identification approach

   **C. Data Collection Methods**:
   - Literature review strategy:
     * Search terms and queries
     * Databases to search
     * Inclusion/exclusion criteria
     * PRISMA or similar framework (if academic)
   - Primary data collection (if applicable):
     * Instruments/protocols
     * Timeline
   - Documentation approach:
     * Note-taking system
     * Citation management (BibTeX)

   **D. Analysis Approach**:
   - Analytical frameworks to apply
   - Analysis techniques (thematic, statistical, comparative, etc.)
   - Synthesis method
   - Quality assurance measures

   **E. Tools & Platforms**:
   - Research tools (Zotero, Mendeley, etc.)
   - Analysis software (if applicable)
   - Citation management (BibTeX format)
   - Collaboration tools

   **F. Ethical Considerations**:
   - Ethics approval (if needed)
   - Data privacy/confidentiality
   - Conflicts of interest disclosure
   - Bias mitigation strategies

   **G. Timeline & Phases**:
   - Phase 1: Literature Review (duration)
   - Phase 2: Data Collection (duration)
   - Phase 3: Analysis (duration)
   - Phase 4: Synthesis & Writing (duration)
   - Milestones and checkpoints

   **H. Limitations**:
   - Acknowledged constraints
   - Scope limitations
   - Resource limitations
   - Methodological limitations

4. **Create supporting files**:
   - `literature-review.md`: Initialize with structure
   - `data-sources.md`: Document identified sources
   - `references.bib`: Initialize BibTeX file

5. **Write methodology** to `research/###-topic-name/methodology.md`

6. **Output summary**:
   - Methodology type and approach
   - Key data sources identified
   - Analysis frameworks to be used
   - Timeline estimate
   - Next step: Use `/research.validate` (optional) or proceed to `/research.tasks`

**Methodology Templates by Research Type**:

- **Academic**: Systematic literature review, theoretical framework, rigorous methodology, extensive citations
- **Market/Business**: Market analysis frameworks (SWOT, Porter's 5 Forces, etc.), competitive intelligence, trend analysis
- **Technical**: Technology evaluation criteria, proof-of-concept plans, comparison matrices, technical feasibility assessment
- **General**: Broad literature scan, synthesis approach, knowledge mapping, fact-checking protocols
