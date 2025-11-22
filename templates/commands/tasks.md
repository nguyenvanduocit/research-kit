---
description: Generate ordered, actionable research tasks from methodology
handoffs:
  - label: Execute Research
    agent: research.execute
    prompt: Execute the research methodology and collect data
    send: true
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command breaks down the research methodology into specific, actionable tasks organized by phase. Run this **after** `/research.methodology` (and optionally `/research.validate`).

1. **Load methodology** from `research/###-topic-name/methodology.md`

2. **Load research definition** from `research/###-topic-name/definition.md`

3. **Generate task breakdown** organized by research phases:

   **Phase 1: Setup & Preparation**
   - [ ] T001: Set up research directory structure
   - [ ] T002: Initialize citation management (BibTeX file)
   - [ ] T003: Document search terms and keywords
   - [ ] T004: Identify key databases and sources
   - [ ] T005: Set up research tools (if needed)

   **Phase 2: Literature Review**
   - [ ] T010: Conduct database searches with defined terms
   - [ ] T011: Screen titles and abstracts for relevance
   - [ ] T012: Download and organize selected papers/sources
   - [ ] T013: Read and extract key findings from sources
   - [ ] T014: Document findings in literature-review.md
   - [ ] T015: Identify gaps in existing research
   - [ ] T016: Update references.bib with all sources

   **Phase 3: Data Collection** (if applicable)
   - [ ] T020: Prepare data collection instruments
   - [ ] T021: Recruit participants/identify data sources
   - [ ] T022: Collect primary data
   - [ ] T023: Compile secondary data
   - [ ] T024: Organize and catalog all collected data
   - [ ] T025: Document data provenance and quality

   **Phase 4: Data Analysis**
   - [ ] T030: Clean and prepare data for analysis
   - [ ] T031: Apply analytical frameworks
   - [ ] T032: Identify patterns, themes, and insights
   - [ ] T033: Cross-reference findings across sources
   - [ ] T034: Validate findings against research questions
   - [ ] T035: Document analysis in findings.md
   - [ ] T036: Create visualizations/charts (if applicable)

   **Phase 5: Synthesis & Conclusions**
   - [ ] T040: Synthesize findings across all sources
   - [ ] T041: Answer each research question explicitly
   - [ ] T042: Draw conclusions based on evidence
   - [ ] T043: Formulate recommendations (if applicable)
   - [ ] T044: Identify limitations of the research
   - [ ] T045: Suggest areas for future research

   **Phase 6: Report Writing**
   - [ ] T050: Draft executive summary
   - [ ] T051: Write research question & objectives section
   - [ ] T052: Write methodology section
   - [ ] T053: Write literature review section
   - [ ] T054: Write findings section
   - [ ] T055: Write analysis & discussion section
   - [ ] T056: Write conclusions & recommendations
   - [ ] T057: Write limitations section
   - [ ] T058: Compile references from BibTeX
   - [ ] T059: Create appendices (if needed)
   - [ ] T060: Review and edit full report
   - [ ] T061: Final quality check against principles

4. **Task Dependencies & Parallelization**:
   - Mark tasks that can be done in parallel with [P]
   - Indicate dependencies (e.g., "T012 depends on T011")
   - Suggest optimal order of execution

5. **Add estimates** (optional):
   - Rough time estimates per task
   - Total estimated duration
   - Milestones/checkpoints

6. **Write tasks** to `research/###-topic-name/tasks.md`

7. **Output summary**:
   - Total number of tasks
   - Number of phases
   - Estimated duration (if calculated)
   - Tasks that can be parallelized
   - Next step: Proceed to `/research.execute`

**Task Granularity Guidelines**:
- Each task should be completable in one work session (2-4 hours max)
- Tasks should have clear start and end points
- Tasks should be specific enough to track progress
- Avoid tasks like "Do research" - break down further
- Good task: "Screen abstracts of papers from Google Scholar search"
- Bad task: "Research the topic"

**Task Numbering**:
- T001-T009: Setup
- T010-T019: Literature Review
- T020-T029: Data Collection
- T030-T039: Analysis
- T040-T049: Synthesis
- T050-T099: Writing & Finalization
