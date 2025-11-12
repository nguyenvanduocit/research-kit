---
description: Validate research methodology for feasibility, rigor, and ethics before execution
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command validates the research methodology to ensure it's sound, feasible, and ethical. Run this **after** `/research.methodology` and **before** `/research.tasks`.

1. **Load methodology** from `research/###-topic-name/methodology.md`

2. **Load research definition** from `research/###-topic-name/definition.md`

3. **Load research principles** from `principles/research-principles.md`

4. **Perform validation checks**:

   **A. Methodological Rigor**:
   - ✓ Research design appropriate for research questions
   - ✓ Data sources adequate to answer questions
   - ✓ Analysis approach suitable for data type
   - ✓ Potential biases identified and mitigation planned
   - ✓ Limitations acknowledged
   - ⚠ Flag if methodology unclear or inconsistent

   **B. Feasibility**:
   - ✓ Timeline realistic for scope
   - ✓ Data sources accessible
   - ✓ Required tools/resources available
   - ✓ Expertise requirements reasonable
   - ⚠ Flag if resource/time constraints make research infeasible

   **C. Ethical Compliance**:
   - ✓ Ethics considerations addressed (human subjects, data privacy, etc.)
   - ✓ Conflicts of interest disclosed
   - ✓ Bias mitigation strategies defined
   - ✓ Source credibility criteria established
   - ⚠ Flag if ethical issues unaddressed

   **D. Alignment**:
   - ✓ Methodology addresses all research questions
   - ✓ Approach aligns with success criteria
   - ✓ Deliverables achievable with methodology
   - ✓ Scope boundaries respected
   - ⚠ Flag if misalignment detected

   **E. Completeness**:
   - ✓ All required methodology sections present
   - ✓ Data collection methods specified
   - ✓ Analysis frameworks defined
   - ✓ Timeline/phases outlined
   - ⚠ Flag if critical sections missing

5. **Generate validation report**:
   - Create `research/###-topic-name/validation-report.md`
   - Summary of validation results
   - List of passed checks (✓)
   - List of warnings/concerns (⚠)
   - Recommendations for improvements
   - Go/no-go recommendation

6. **If issues found**:
   - Provide specific recommendations
   - Suggest methodology revisions
   - Highlight critical vs non-critical issues
   - User should address critical issues before proceeding

7. **Output summary**:
   - Validation score (e.g., "18/20 checks passed")
   - Critical issues (if any)
   - Warnings (if any)
   - Recommendation: "Ready to proceed" or "Revisions needed"
   - Next step: If validated, proceed to `/research.tasks`; otherwise revise methodology

**Common Validation Failures**:
- Methodology too ambitious for timeline
- Data sources insufficient or inaccessible
- Analysis approach doesn't match research questions
- Ethical considerations not addressed
- Bias mitigation strategies absent
- No clear path from data collection to conclusions
