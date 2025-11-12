---
description: Generate research quality checklists to validate completeness, rigor, and standards compliance
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command generates comprehensive quality checklists for research validation. Can be run at any phase but recommended **after** `/research.methodology` or `/research.execute`.

1. **Determine checkpoint type** based on current phase:
   - If methodology exists but tasks don't: **Methodology Quality Checklist**
   - If tasks exist but report doesn't: **Pre-Execution Quality Checklist**
   - If report exists: **Final Report Quality Checklist**

2. **Generate appropriate checklist**:

   **A. Methodology Quality Checklist** (`research/###-topic-name/checklists/methodology-quality.md`):
   ```markdown
   # Methodology Quality Checklist

   ## Research Design
   - [ ] Research type appropriate for questions
   - [ ] Approach justified and documented
   - [ ] Scope clearly defined

   ## Data Sources
   - [ ] Sources adequate to answer questions
   - [ ] Source quality criteria defined
   - [ ] Source accessibility verified
   - [ ] Credibility assessment framework established

   ## Data Collection
   - [ ] Collection methods clearly specified
   - [ ] Search strategy documented
   - [ ] Inclusion/exclusion criteria defined
   - [ ] Citation management plan established

   ## Analysis
   - [ ] Analytical frameworks specified
   - [ ] Analysis techniques appropriate for data
   - [ ] Synthesis approach defined
   - [ ] Quality assurance measures in place

   ## Ethics & Rigor
   - [ ] Ethical considerations addressed
   - [ ] Bias mitigation strategies defined
   - [ ] Limitations acknowledged
   - [ ] Conflicts of interest disclosed

   ## Feasibility
   - [ ] Timeline realistic
   - [ ] Resources available
   - [ ] Expertise requirements reasonable
   ```

   **B. Pre-Execution Quality Checklist** (`research/###-topic-name/checklists/pre-execution-quality.md`):
   ```markdown
   # Pre-Execution Quality Checklist

   ## Preparation
   - [ ] Research definition complete and clear
   - [ ] Methodology validated
   - [ ] Tasks broken down and ordered
   - [ ] Tools and resources ready
   - [ ] Citation management set up

   ## Alignment
   - [ ] Tasks cover all research questions
   - [ ] Tasks follow methodology
   - [ ] Dependencies identified
   - [ ] Timeline realistic

   ## Documentation
   - [ ] Templates initialized
   - [ ] Directory structure created
   - [ ] references.bib ready
   - [ ] Research principles reviewed
   ```

   **C. Final Report Quality Checklist** (`research/###-topic-name/checklists/report-quality.md`):
   ```markdown
   # Final Report Quality Checklist

   ## Structure & Completeness
   - [ ] Executive summary present and clear
   - [ ] Research questions restated
   - [ ] Methodology documented
   - [ ] Literature review comprehensive
   - [ ] Findings well-organized
   - [ ] Analysis/discussion present
   - [ ] Conclusions explicit
   - [ ] Limitations acknowledged
   - [ ] References complete

   ## Content Quality
   - [ ] All research questions answered
   - [ ] Claims supported by evidence
   - [ ] Sources properly cited
   - [ ] Multiple perspectives considered
   - [ ] Contradictory evidence addressed
   - [ ] Conclusions justified by findings
   - [ ] Limitations impact assessed

   ## Source Quality
   - [ ] Credible sources used
   - [ ] Primary sources prioritized where appropriate
   - [ ] Source currency appropriate
   - [ ] Sufficient source diversity
   - [ ] Grey literature evaluated carefully
   - [ ] All sources accessible

   ## Citations & References
   - [ ] All claims cited
   - [ ] Citations properly formatted
   - [ ] references.bib complete
   - [ ] No broken or inaccessible sources
   - [ ] Citation style consistent

   ## Rigor & Ethics
   - [ ] Methodology followed
   - [ ] Bias mitigation applied
   - [ ] Ethical standards met
   - [ ] Conflicts of interest disclosed
   - [ ] Alternative explanations considered
   - [ ] Certainty levels appropriate

   ## Presentation
   - [ ] Writing clear and professional
   - [ ] Logical flow maintained
   - [ ] Technical terms defined
   - [ ] Visualizations effective (if present)
   - [ ] Executive summary standalone
   - [ ] Length appropriate for scope

   ## Alignment with Principles
   - [ ] Source quality standards met
   - [ ] Methodology rigor maintained
   - [ ] Ethics & bias guidelines followed
   - [ ] Citation standards adhered to
   - [ ] Analysis quality verified
   - [ ] Report completeness achieved
   ```

3. **Execute checklist validation**:
   - Load relevant documents
   - Check each criterion
   - Mark ✓ (passed), ⚠ (needs attention), or ✗ (failed)
   - Document issues found

4. **Generate validation report**:
   - Pass rate (e.g., "42/48 checks passed")
   - List of failed/warning items
   - Specific recommendations for each issue
   - Priority: Critical → High → Medium → Low

5. **Output summary**:
   - Checklist type generated
   - Overall quality score
   - Number of issues found
   - Critical issues (if any)
   - Recommendations
   - Next steps

**When to Use**:
- `/research.quality` after methodology: Validate methodology before spending time on execution
- `/research.quality` before execution: Ensure everything is ready
- `/research.quality` after writing report: Final validation before delivery
- `/research.quality` anytime: On-demand quality check
