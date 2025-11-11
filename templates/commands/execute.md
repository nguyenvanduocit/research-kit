---
description: Execute research tasks and compile final research report
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command guides the systematic execution of research tasks and compilation of the final report. Run this **after** `/research.tasks`.

1. **Load task list** from `research/###-topic-name/tasks.md`

2. **Load research definition** from `research/###-topic-name/definition.md`

3. **Load methodology** from `research/###-topic-name/methodology.md`

4. **Execute research tasks systematically**:

   **For each task**:
   - Review task description and dependencies
   - Execute the task following methodology
   - Document findings/progress
   - Update relevant files (literature-review.md, data-sources.md, findings.md, etc.)
   - Check off task when complete
   - Move to next task

   **Task Execution Guidelines**:
   - Follow research principles for quality and ethics
   - Document sources immediately in references.bib
   - Note any deviations from methodology
   - Flag unexpected findings or issues
   - Maintain organized notes throughout

5. **Continuous documentation**:
   - Update `literature-review.md` as sources are reviewed
   - Update `data-sources.md` as data is collected
   - Update `findings.md` as analysis progresses
   - Update `references.bib` continuously
   - Keep notes on methodology adjustments

6. **Quality checkpoints** (throughout execution):
   - Verify sources meet credibility criteria
   - Ensure citations are properly formatted
   - Check alignment with research questions
   - Validate findings against research principles
   - Document limitations encountered

7. **Compile final research report** (`research/###-topic-name/report.md`):

   **Report Structure**:
   ```markdown
   # Research Report: [TOPIC]

   ## Executive Summary
   [1-2 page overview: research question, approach, key findings, conclusions]

   ## Research Question & Objectives
   [Restate from definition with any refinements]

   ## Methodology
   [How research was conducted - can reference methodology.md]

   ## Literature Review
   [Synthesized from literature-review.md]

   ## Findings
   [Organized by theme/question - from findings.md]
   - Finding 1: [Evidence + sources]
   - Finding 2: [Evidence + sources]
   - ...

   ## Analysis & Discussion
   [Interpretation of findings, patterns, implications]

   ## Conclusions
   [Direct answers to research questions]

   ## Recommendations
   [If applicable - actionable recommendations based on findings]

   ## Limitations
   [Acknowledged constraints and their impact]

   ## Future Research
   [Suggested areas for further investigation]

   ## References
   [Generated from references.bib - properly formatted]

   ## Appendices
   [Supporting materials - raw data, detailed tables, etc.]
   ```

8. **Final validation** against research principles:
   - Source quality standards met
   - Methodology rigor maintained
   - Ethics & bias addressed
   - Citation standards followed
   - Analysis quality verified
   - Report completeness confirmed

9. **Generate completion report**:
   - Research questions answered (Y/N for each)
   - Objectives achieved (% completion)
   - Number of sources cited
   - Key findings summary
   - Limitations encountered
   - Quality score (self-assessment against principles)

10. **Output summary**:
    - All tasks completed
    - Final report location
    - Report page count/word count
    - Number of sources cited
    - Key findings (bullet points)
    - Quality assessment
    - Suggested next steps (peer review, publication, presentation, etc.)

**Report Quality Criteria**:
- Executive summary is clear and standalone
- All research questions explicitly answered
- Claims supported by cited sources
- Methodology transparent and reproducible
- Limitations honestly acknowledged
- Conclusions justified by findings
- References properly formatted and complete
- Writing is clear, concise, professional

**Common Pitfalls to Avoid**:
- Citing sources without reading them
- Cherry-picking data to support predetermined conclusions
- Ignoring contradictory evidence
- Overgeneralizing from limited data
- Failing to acknowledge limitations
- Weak causal claims from correlational data
- Missing or improperly formatted citations
