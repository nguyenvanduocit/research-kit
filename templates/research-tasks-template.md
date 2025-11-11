---
description: "Task list template for research execution"
---

# Research Tasks: [TOPIC_NAME]

**Input**: Research documents from `/research/[###-topic-name]/`
**Prerequisites**: methodology.md (required), definition.md (required), data-model.md, contracts/, research-principles.md

**Quality Checks**: The examples below include validation tasks. Validation is RECOMMENDED to ensure research quality and credibility.

**Organization**: Tasks are grouped by research phase to enable systematic progression through the research workflow.

## Format: `[ID] [P?] [Phase] Description`

- **[P]**: Can run in parallel (different sources, no dependencies)
- **[Phase]**: Which research phase this task belongs to (e.g., LIT, DATA, ANALYSIS)
- Include exact file paths in descriptions

## Path Conventions

- **Research output**: `research/[###-topic-name]/`
- **Citations**: `research/[###-topic-name]/references.bib`
- **Data**: `research/[###-topic-name]/data/`
- **Findings**: `research/[###-topic-name]/findings/`

<!--
  ============================================================================
  IMPORTANT: The tasks below are SAMPLE TASKS for illustration purposes only.

  The /researchkit.tasks command MUST replace these with actual tasks based on:
  - Research questions from definition.md
  - Research objectives from methodology.md
  - Data requirements from data-model.md
  - Research scope from research-principles.md

  Tasks MUST be organized by research phase so each phase can be:
  - Executed systematically
  - Validated independently
  - Delivered as interim research milestones

  DO NOT keep these sample tasks in the generated tasks.md file.
  ============================================================================
-->

## Phase 1: Setup & Preparation

**Purpose**: Research infrastructure and initial preparation

**Duration**: [estimate: e.g., 1-2 days]

- [ ] T001 Create research directory structure per research plan
- [ ] T002 Initialize citation management system (references.bib)
- [ ] T003 [P] Set up research tools (Zotero, Mendeley, etc.)
- [ ] T004 [P] Document search terms and keywords in search-strategy.md
- [ ] T005 Identify key databases and sources (academic, industry, web)
- [ ] T006 Review research-principles.md for quality standards
- [ ] T007 Create data collection templates (if applicable)

**Checkpoint**: Research infrastructure ready - literature search can begin

---

## Phase 2: Literature Review

**Purpose**: Identify, collect, and synthesize existing knowledge

**Duration**: [estimate: e.g., 1-2 weeks]

### Initial Search & Screening

- [ ] T010 [P] [LIT] Conduct database search on [Database1] (e.g., Google Scholar)
- [ ] T011 [P] [LIT] Conduct database search on [Database2] (e.g., PubMed, IEEE)
- [ ] T012 [P] [LIT] Conduct web search for grey literature and industry reports
- [ ] T013 [LIT] Screen titles and abstracts for relevance (inclusion/exclusion criteria)
- [ ] T014 [LIT] Download and organize selected papers in research/[###-topic-name]/sources/
- [ ] T015 [LIT] Remove duplicates and update search log

### Reading & Analysis

- [ ] T020 [P] [LIT] Read and annotate source group 1 ([topic/theme])
- [ ] T021 [P] [LIT] Read and annotate source group 2 ([topic/theme])
- [ ] T022 [P] [LIT] Read and annotate source group 3 ([topic/theme])
- [ ] T023 [LIT] Extract key findings, methodologies, and insights
- [ ] T024 [LIT] Identify themes and patterns across sources
- [ ] T025 [LIT] Document gaps in existing research
- [ ] T026 [LIT] Update references.bib with all cited sources

### Synthesis

- [ ] T030 [LIT] Organize findings by theme in literature-review.md
- [ ] T031 [LIT] Write literature review synthesis (state of the art)
- [ ] T032 [LIT] Map findings to research questions
- [ ] T033 [LIT] Quality check: verify all claims have citations

**Checkpoint**: Literature review complete - understanding of existing knowledge established

---

## Phase 3: Data Collection (if applicable)

**Purpose**: Gather primary or secondary data for analysis

**Duration**: [estimate: e.g., 1-3 weeks]

> **NOTE**: Remove this phase if research is purely desk-based/literature synthesis

### Preparation

- [ ] T040 [DATA] Prepare data collection instruments (surveys, interview guides, scraping scripts)
- [ ] T041 [DATA] Validate instruments against research questions
- [ ] T042 [P] [DATA] Recruit participants OR identify data sources
- [ ] T043 [DATA] Obtain necessary approvals (ethics, permissions)

### Collection

- [ ] T050 [P] [DATA] Collect data batch 1 (e.g., interviews 1-5)
- [ ] T051 [P] [DATA] Collect data batch 2 (e.g., interviews 6-10)
- [ ] T052 [P] [DATA] Compile secondary data (public datasets, reports)
- [ ] T053 [DATA] Organize raw data in research/[###-topic-name]/data/raw/
- [ ] T054 [DATA] Document data provenance and collection metadata
- [ ] T055 [DATA] Verify data completeness and quality

**Checkpoint**: Data collection complete - analysis-ready dataset prepared

---

## Phase 4: Data Analysis

**Purpose**: Process, analyze, and interpret collected data

**Duration**: [estimate: e.g., 2-4 weeks]

### Data Preparation

- [ ] T060 [ANALYSIS] Clean and prepare data for analysis
- [ ] T061 [ANALYSIS] Code/categorize qualitative data (if applicable)
- [ ] T062 [ANALYSIS] Process quantitative data (if applicable)
- [ ] T063 [ANALYSIS] Organize processed data in research/[###-topic-name]/data/processed/

### Analysis Execution

- [ ] T070 [P] [ANALYSIS] Apply analytical framework 1 ([method/approach])
- [ ] T071 [P] [ANALYSIS] Apply analytical framework 2 ([method/approach])
- [ ] T072 [ANALYSIS] Identify patterns, themes, and insights
- [ ] T073 [ANALYSIS] Cross-reference findings across data sources
- [ ] T074 [ANALYSIS] Validate findings against research questions
- [ ] T075 [ANALYSIS] Document analysis process in analysis-log.md

### Visualization & Documentation

- [ ] T080 [P] [ANALYSIS] Create charts/visualizations for finding 1
- [ ] T081 [P] [ANALYSIS] Create charts/visualizations for finding 2
- [ ] T082 [ANALYSIS] Document findings in research/[###-topic-name]/findings.md
- [ ] T083 [ANALYSIS] Perform quality check on analysis rigor
- [ ] T084 [ANALYSIS] Document limitations and assumptions

**Checkpoint**: Analysis complete - evidence-based findings documented

---

## Phase 5: Synthesis & Conclusions

**Purpose**: Synthesize findings and draw evidence-based conclusions

**Duration**: [estimate: e.g., 1-2 weeks]

### Integration

- [ ] T090 [SYNTHESIS] Synthesize findings across literature and data
- [ ] T091 [SYNTHESIS] Answer research question 1 explicitly with evidence
- [ ] T092 [SYNTHESIS] Answer research question 2 explicitly with evidence
- [ ] T093 [SYNTHESIS] Answer research question 3 explicitly with evidence
- [ ] T094 [SYNTHESIS] Cross-validate conclusions against multiple sources

### Conclusions & Implications

- [ ] T100 [SYNTHESIS] Draw evidence-based conclusions
- [ ] T101 [SYNTHESIS] Formulate recommendations (if applicable)
- [ ] T102 [SYNTHESIS] Identify research limitations and constraints
- [ ] T103 [SYNTHESIS] Suggest areas for future research
- [ ] T104 [SYNTHESIS] Document theoretical/practical implications
- [ ] T105 [SYNTHESIS] Validate conclusions against research-principles.md

**Checkpoint**: Synthesis complete - research conclusions established

---

## Phase 6: Report Writing

**Purpose**: Communicate research findings in structured report

**Duration**: [estimate: e.g., 1-2 weeks]

### Document Structure

- [ ] T110 [P] [REPORT] Draft executive summary
- [ ] T111 [P] [REPORT] Write introduction (context, background, objectives)
- [ ] T112 [P] [REPORT] Write research questions section
- [ ] T113 [REPORT] Write methodology section (research design, data collection, analysis)
- [ ] T114 [REPORT] Write literature review section
- [ ] T115 [REPORT] Write findings section (organized by research question)
- [ ] T116 [REPORT] Write analysis & discussion section
- [ ] T117 [REPORT] Write conclusions & recommendations section
- [ ] T118 [REPORT] Write limitations section
- [ ] T119 [REPORT] Write future research directions section

### Supporting Materials

- [ ] T120 [P] [REPORT] Compile references from references.bib (formatted correctly)
- [ ] T121 [P] [REPORT] Create appendices (raw data samples, instruments, etc.)
- [ ] T122 [P] [REPORT] Create table of contents and figures list
- [ ] T123 [REPORT] Add citations for all claims and findings

### Review & Finalization

- [ ] T130 [REPORT] Review full report for coherence and flow
- [ ] T131 [REPORT] Verify all research questions are answered
- [ ] T132 [REPORT] Check all citations are complete and formatted correctly
- [ ] T133 [REPORT] Quality check against research-principles.md
- [ ] T134 [REPORT] Proofread for clarity, grammar, and style
- [ ] T135 [REPORT] Format report according to guidelines
- [ ] T136 [REPORT] Generate final PDF/output format
- [ ] T137 [REPORT] Archive all research materials and data

**Checkpoint**: Research report complete and ready for distribution

---

## Phase 7: Review & Validation (OPTIONAL - if peer review requested)

**Purpose**: Validate research quality and credibility

**Duration**: [estimate: e.g., 1-2 weeks]

- [ ] T140 [REVIEW] Conduct internal review for methodological rigor
- [ ] T141 [REVIEW] Validate data analysis reproducibility
- [ ] T142 [REVIEW] Check citation accuracy and completeness
- [ ] T143 [REVIEW] Peer review (if applicable)
- [ ] T144 [REVIEW] Address reviewer feedback
- [ ] T145 [REVIEW] Final quality assurance check

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Literature Review (Phase 2)**: Depends on Setup completion
- **Data Collection (Phase 3)**: Depends on Literature Review (to refine instruments)
- **Data Analysis (Phase 4)**: Depends on Data Collection OR can start after Phase 2 if desk-based
- **Synthesis (Phase 5)**: Depends on Analysis completion
- **Report Writing (Phase 6)**: Depends on Synthesis completion
- **Review (Phase 7)**: Depends on Report Writing completion

### Within Each Phase

- **Setup**: All tasks can run in parallel after directory creation
- **Literature Review**:
  - Searches (T010-T012) can run in parallel
  - Reading (T020-T022) can run in parallel by source group
  - Synthesis must follow reading
- **Data Collection**: Batches can run in parallel
- **Analysis**: Different analytical methods can run in parallel
- **Synthesis**: Must be sequential (answers build on each other)
- **Report Writing**: Sections can be drafted in parallel, then integrated

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All database searches marked [P] can run in parallel
- Reading and annotating different source groups can run in parallel
- Data collection batches can run in parallel
- Applying different analytical frameworks can run in parallel
- Creating different visualizations can run in parallel
- Drafting different report sections can run in parallel (after synthesis)

---

## Parallel Example: Literature Review Phase

```bash
# Launch all database searches together:
Task: "Conduct database search on Google Scholar"
Task: "Conduct database search on IEEE Xplore"
Task: "Conduct web search for industry reports"

# Launch reading tasks for different source groups:
Task: "Read and annotate source group 1 (methodology papers)"
Task: "Read and annotate source group 2 (case studies)"
Task: "Read and annotate source group 3 (theoretical frameworks)"
```

---

## Execution Strategy

### Minimum Viable Research (Literature Review Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Literature Review
3. Complete Phase 5: Synthesis (based on literature only)
4. Complete Phase 6: Report Writing (literature synthesis report)
5. **STOP and VALIDATE**: Review report for quality and completeness

### Full Research with Data Collection

1. Complete Phase 1: Setup
2. Complete Phase 2: Literature Review
3. Complete Phase 3: Data Collection
4. Complete Phase 4: Data Analysis
5. Complete Phase 5: Synthesis (literature + data)
6. Complete Phase 6: Report Writing
7. Optional: Complete Phase 7: Review & Validation

### Iterative Research Strategy

With multiple research questions:

1. Complete Setup + Literature Review for all questions
2. Focus on Research Question 1:
   - Data Collection → Analysis → Synthesis → Draft findings
3. Focus on Research Question 2:
   - Data Collection → Analysis → Synthesis → Draft findings
4. Integrate all findings into final report

---

## Milestones & Checkpoints

1. **Milestone 1**: Research infrastructure ready (after T007)
   - Verify: Directory structure, tools, search strategy documented

2. **Milestone 2**: Literature review complete (after T033)
   - Verify: Literature synthesis written, gaps identified, all sources cited

3. **Milestone 3**: Data collection complete (after T055)
   - Verify: Data organized, provenance documented, quality checked

4. **Milestone 4**: Analysis complete (after T084)
   - Verify: Findings documented, limitations noted, quality checked

5. **Milestone 5**: Synthesis complete (after T105)
   - Verify: All research questions answered, conclusions validated

6. **Milestone 6**: Draft report complete (after T123)
   - Verify: All sections written, references compiled, appendices created

7. **Milestone 7**: Final report ready (after T137)
   - Verify: Quality checked, formatted, archived

---

## Notes

- [P] tasks = independent sources/sections, no dependencies
- [Phase] label maps task to specific research phase for traceability
- Each phase should have clear quality checkpoints
- Document decisions and changes in research-log.md
- Commit after each task or logical group
- Stop at any checkpoint to validate research quality
- Adjust phases based on research type (desk research vs. empirical research)
- Remove Phase 3 (Data Collection) if conducting pure literature review
- Add domain-specific phases as needed (e.g., experiments, surveys, interviews)

---

## Total Estimated Duration

- **Minimum (Literature Review Only)**: [X weeks]
- **Full Research (With Data Collection)**: [X weeks/months]

**Created**: [DATE]
**Last Updated**: [DATE]
