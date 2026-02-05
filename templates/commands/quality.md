---
description: Generate research quality checklists to validate completeness, rigor, and standards compliance
scripts:
  sh: scripts/bash/run-quality-check.sh {ARGS}
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command runs automated quality gate checks and supplements them with AI-level content validation. Can be run at any phase.

**IMPORTANT**: The setup script (`scripts/bash/run-quality-check.sh`) will automatically:
- Detect the current research phase based on existing artifacts
- Run the appropriate quality gate function from `quality-gate.sh`
- Report CRITICAL, REQUIRED, and RECOMMENDED check results
- Support `--force` to bypass REQUIRED checks (logged to `gate-log.md`)
- Support specific gate names (e.g., `define_to_methodology`) or `all` to run every applicable gate

**The script handles structural quality checks. Your job is the AI-level content quality checks below.**

1. **Review script gate results**:
   - The script output above shows which structural checks passed/failed
   - If CRITICAL checks failed: report to user, these cannot be bypassed
   - If REQUIRED checks failed: report to user, suggest fixes or `--force` to override
   - If all passed: proceed to AI-level checks

2. **AI-Level Content Quality Checks** (supplement the script gate):

   Read the relevant research artifacts and perform deeper content validation that scripts cannot do. The checks below depend on the current phase.

   **Phase Detection**: Check which artifacts exist to determine the current phase:
   - `definition.md` exists → check definition quality
   - `methodology.md` exists → check methodology quality
   - `tasks.md` exists → check tasks quality
   - `execution.md` exists → check execution quality
   - `analysis.md` exists → check analysis quality
   - `synthesis.md` exists → check synthesis quality
   - `publications/report/article.md` exists → check publication quality

   Run AI checks for ALL phases that have artifacts, from earliest to current.

3. **AI Checks: Definition Quality** (if `definition.md` exists):
   - [ ] Primary research question is clearly stated and answerable
   - [ ] At least 3 sub-questions that decompose the primary question
   - [ ] Scope has clear in-scope AND out-of-scope boundaries
   - [ ] At least 5 success criteria that are measurable
   - [ ] Research type (qualitative/quantitative/mixed) justified
   - [ ] No vague or ambiguous language in research questions
   - [ ] Objectives are SMART (Specific, Measurable, Achievable, Relevant, Time-bound)

4. **AI Checks: Methodology Quality** (if `methodology.md` exists):
   - [ ] At least 5 data sources identified across 2+ types
   - [ ] Source quality assessment framework defined (tier system or CRAAP)
   - [ ] Recency requirements specified for sources
   - [ ] At least 2 bias mitigation strategies described
   - [ ] At least 3 limitations acknowledged with impact assessment
   - [ ] Data collection methods clearly specified for every source
   - [ ] Inclusion/exclusion criteria defined for literature search
   - [ ] Analysis techniques appropriate for data types
   - [ ] Ethical considerations addressed substantively (not placeholder)

5. **AI Checks: Tasks Quality** (if `tasks.md` exists):
   - [ ] Every research question has at least 2 related tasks
   - [ ] At least 15 total tasks defined
   - [ ] Each phase (Literature Review, Data Collection, Analysis, Synthesis) has at least 3 tasks
   - [ ] Dependencies documented for tasks that have them
   - [ ] Tasks are actionable (start with verbs, have clear deliverables)
   - [ ] No duplicate or overlapping tasks

6. **AI Checks: Execution Quality** (if `execution.md` exists):
   - [ ] At least 15 source files downloaded in `sources/`
   - [ ] At least 30% of sources are Tier 1 (peer-reviewed, official statistics, primary data)
   - [ ] Zero URL-only citations (all use file:line format)
   - [ ] Every research question has at least 3 relevant sources collected
   - [ ] Data collection status documented for every source in methodology
   - [ ] Failed/unavailable sources documented with reasons and alternatives

7. **AI Checks: Analysis Quality** (if `analysis.md` exists):
   - [ ] At least 8 key findings documented
   - [ ] Every finding has: supporting evidence, file:line citation, interpretation
   - [ ] At least 70% of findings have evidence strength rating
   - [ ] Data quality assessment completed with quality score for every dataset
   - [ ] Comparison with literature documented for at least 5 findings
   - [ ] Contradictory findings explicitly addressed (not ignored)
   - [ ] At least 3 visualizations created in `figures/`
   - [ ] Analysis methods documented sufficiently for replication

8. **AI Checks: Synthesis Quality** (if `synthesis.md` exists):
   - [ ] 100% of research questions addressed with explicit answers
   - [ ] Confidence level assigned for every research question (High/Medium/Low)
   - [ ] At least 70% of research questions have confidence High or Medium
   - [ ] Every answer has at least 3 supporting evidence items
   - [ ] Contradicting evidence acknowledged for every RQ that has contradictions
   - [ ] At least 3 emergent themes identified and documented
   - [ ] At least 5 practical implications/recommendations
   - [ ] Limitations section has at least 5 items with impact assessment
   - [ ] At least 3 future research directions, each justified by evidence gap

9. **AI Checks: Publication Quality** (if `publications/report/article.md` exists):

   **Structure & Length:**
   - [ ] Total word count ≥ 7500 words
   - [ ] Introduction ≥ 800 words
   - [ ] Literature Review ≥ 1500 words
   - [ ] Methodology ≥ 1000 words
   - [ ] Results ≥ 1500 words
   - [ ] Discussion ≥ 2000 words
   - [ ] Conclusion ≥ 500 words

   **Citation Quality:**
   - [ ] Total footnotes ≥ 95
   - [ ] Introduction has ≥ 10 footnotes
   - [ ] Literature Review has ≥ 25 footnotes
   - [ ] Results has ≥ 20 footnotes
   - [ ] Discussion has ≥ 25 footnotes
   - [ ] Every footnote contains exact quote in quotation marks
   - [ ] Every footnote contains file:line reference
   - [ ] No URL-only citations (all use sources/path/file.md:line format)

   **Writing Quality:**
   - [ ] Zero bullet point lists in main content (convert to prose)
   - [ ] No paragraph shorter than 4 sentences
   - [ ] Sentence beginnings are varied (no "The study..." repeated)
   - [ ] Transitions between paragraphs are smooth
   - [ ] Active voice used predominantly (>70% of sentences)
   - [ ] Specific numbers and data cited (not vague "significant" claims)

   **Content Quality:**
   - [ ] Abstract provides substantive information (not just "this paper examines...")
   - [ ] Introduction hooks the reader with context, not generic statements
   - [ ] Literature review synthesizes (not just lists) prior work
   - [ ] Methodology is detailed enough for replication
   - [ ] Results include interpretation alongside data
   - [ ] Discussion adds analysis beyond restating results
   - [ ] Conclusion provides insight beyond summary

   **Evidence Integration:**
   - [ ] Every major claim has supporting footnote
   - [ ] Contradictory evidence is acknowledged
   - [ ] Source quality is indicated (Tier 1/2/3)
   - [ ] Multiple sources synthesized for key claims

11. **Generate validation report**:

    Output format:
    ```
    QUALITY CHECK REPORT
    ====================

    ## Script Gate Results (Structural)
    [Summarize script output: X/Y passed, any failures]

    ## AI Content Quality Results

    ### [Phase Name]
    ✓/✗ [check description]
    ...

    ## Summary
    - Script gate: PASSED/FAILED
    - AI content checks: X/Y passed
    - Overall quality score: [percentage]
    - Critical issues: [list if any]

    ## Recommendations
    - [Priority] [Specific fix needed]
    ...

    ## Next Steps
    - [What to do to fix issues, or proceed to next phase]
    ```

12. **Save checklist** (optional):
    - Save the full report to `research/###-topic-name/checklists/quality-check-[date].md`

**When to Use**:
- `/research.quality` — Auto-detect phase, run gate + AI checks
- `/research.quality all` — Run ALL gates from definition to current phase
- `/research.quality define_to_methodology` — Run a specific gate
- `/research.quality --force` — Bypass REQUIRED failures in script gate
- `/research.quality` anytime — On-demand quality validation at any phase

**User can say "skip gate"** to override AI-level check failures and proceed anyway (log the bypass in output).
