---
description: Synthesize findings and draw conclusions
scripts:
  sh: scripts/bash/setup-synthesis.sh
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command guides the synthesis of analysis findings to draw conclusions and answer research questions. Run this **after** `/research.analyze`.

**IMPORTANT**: The setup script (`scripts/bash/setup-synthesis.sh`) will automatically:
- Create synthesis directories (`models/`, `figures/synthesis/`, `briefs/`)
- Initialize synthesis tracking file (`synthesis.md`)
- Set up synthesis templates and checklists
- Verify prerequisite phases have been completed (especially `analysis.md`)

**DO NOT manually create these directories or files - let the script handle it!**

1. **Quality Gate: AI Verification** (after script gate passes)

   Read `analysis.md` and scan `figures/` directory. Verify ALL of the following. If any REQUIRED check fails, STOP and report to user. User can say "skip gate" to override (log bypass in output).

   **REQUIRED checks** (block unless user says "skip gate"):
   - [ ] At least 8 key findings documented in analysis.md
   - [ ] Every finding has: supporting evidence, file:line citation, interpretation
   - [ ] At least 70% of findings have evidence strength rating (statistical significance or qualitative strength)
   - [ ] Data quality assessment completed with quality score for every dataset analyzed
   - [ ] Comparison with literature documented for at least 5 findings
   - [ ] Contradictory findings explicitly addressed (not ignored)
   - [ ] At least 3 visualizations created in figures/
   - [ ] Analysis methods documented sufficiently for replication

   **Output format:**
   ```
   QUALITY GATE: analyze → synthesize (AI Verification)
   REQUIRED: ✓/✗ [check]
   RESULT: PASSED / BLOCKED
   ```

   If BLOCKED: Tell user which checks failed, suggest continuing `/research.analyze`.

2. **Load complete research context**:
   - Research definition and questions from `definition.md`
   - Methodology framework from `methodology.md`
   - Execution outcomes from `execution.md`
   - Analysis findings from `analysis.md`
   - Literature review insights

3. **Initialize synthesis framework**:
   - Create/update `research/###-topic-name/synthesis.md`
   - Map findings to research questions
   - Identify cross-cutting themes
   - Prepare conclusion structure

4. **Connect findings to research questions**:

   **For each research question**:
   - Gather all relevant findings
   - Assess strength of evidence
   - Identify supporting and contradicting data
   - Determine confidence level in answer
   - Note any gaps or limitations

5. **Identify emergent themes**:

   **Thematic synthesis**:
   - Group related findings
   - Identify patterns across data sources
   - Recognize unexpected connections
   - Build conceptual relationships
   - Create theme hierarchy
   - Document theme evidence

6. **Build theoretical contributions**:

   **Theory development**:
   - Compare findings with existing theories
   - Identify theoretical extensions
   - Propose modifications to frameworks
   - Highlight novel theoretical insights
   - Create conceptual models
   - Define new constructs if applicable

7. **Develop practical implications**:

   **Application synthesis**:
   - Translate findings to practice
   - Identify actionable recommendations
   - Consider implementation contexts
   - Assess feasibility and impact
   - Prioritize recommendations
   - Link to stakeholder needs

8. **Assess research impact**:

   **Contribution assessment**:
   - Scientific contributions
   - Practical applications
   - Policy implications
   - Social/economic impact
   - Future research directions
   - Knowledge gaps addressed

9. **Document synthesis**:

   Update `synthesis.md` with:
   ```markdown
   # Research Synthesis

   ## Synthesis Overview
   - Date: [DATE]
   - Research Questions Addressed: [X/Y]
   - Key Themes Identified: [N]
   - Confidence Level: [High/Medium/Low]

   ## Answers to Research Questions

   ### RQ1: [Research Question]
   **Answer**: [Clear, concise answer]
   - **Supporting Evidence**:
     - Finding 1 (strong support)
     - Finding 3 (moderate support)
     - Finding 5 (weak support)
   - **Contradicting Evidence**:
     - Finding 2 (explain contradiction)
   - **Confidence Level**: [High/Medium/Low]
   - **Remaining Gaps**: [What we still don't know]

   ### RQ2: [Research Question]
   **Answer**: [Clear, concise answer]
   - **Supporting Evidence**: [List]
   - **Confidence Level**: [High/Medium/Low]

   ## Emergent Themes

   ### Theme 1: [Name]
   **Description**: [What this theme represents]
   - **Supporting Findings**: [List with references]
   - **Cross-Data Evidence**: [Multiple sources]
   - **Theoretical Link**: [Connection to theory]
   - **Practical Relevance**: [Why it matters]

   ### Theme 2: [Name]
   [Similar structure]

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

   ### Implication 2: [For whom/what]
   [Similar structure]

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
   ```

10. **Create synthesis visualizations**:

   Generate conceptual diagrams for:
   - Research question answer map
   - Theme relationship network
   - Theoretical framework evolution
   - Evidence strength matrix
   - Implication priority matrix

11. **Validate synthesis logic**:

    Check for:
    - Logical consistency
    - Evidence sufficiency
    - Overgeneralization
    - Appropriate caveats
    - Clear causal claims
    - Balanced interpretation

12. **Generate synthesis artifacts**:
    - Conceptual models (`models/`)
    - Summary tables (`tables/synthesis_*.csv`)
    - Integration diagrams (`figures/synthesis_*.png`)
    - Executive summary document
    - Stakeholder briefs

13. **Output synthesis summary**:
    - Research questions answered: X/Y
    - Confidence in conclusions: [Level]
    - Key themes identified: [Count]
    - Theoretical contributions: [Count]
    - Practical recommendations: [Count]
    - Knowledge gaps remaining: [Count]
    - Readiness for publication phase

**Synthesis Principles**:
- Ground all conclusions in evidence
- Acknowledge contradictions honestly
- Avoid overstatement
- Consider alternative explanations
- Maintain theoretical rigor
- Balance detail with clarity
- Connect micro findings to macro insights

**Common Synthesis Challenges**:
- Confirmation bias → Actively seek disconfirming evidence
- Overgeneralization → Stay within data boundaries
- Weak inference → Strengthen evidence chains
- Missing connections → Look for relationships
- Unclear implications → Make explicit links
- Limited creativity → Consider multiple interpretations
- Poor integration → Build coherent narrative

**Quality Criteria**:
- Conclusions follow from evidence
- All research questions addressed
- Limitations acknowledged
- Practical value demonstrated
- Theoretical contribution clear
- Future directions justified
- Synthesis tells coherent story

This phase focuses on SYNTHESIZING findings into conclusions and implications, not on writing the final publication. Publication formatting comes in the next phase.

**Specialized agents**: Use `@agent-analysis-expert` for additional statistical validation or `@agent-research-reviewer` to validate synthesis quality.

**Next step**: Once synthesis is complete, proceed to `/research.publish` to create publication-ready outputs. Use `@agent-academic-writer` for professional formatting and citation management.