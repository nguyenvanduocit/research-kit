---
description: Interactively refine research scope through structured questions to clarify ambiguous areas before methodology design
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command helps refine the research definition by asking targeted questions to clarify ambiguous areas, narrow scope, or identify hidden assumptions. Run this **after** `/research.define` and **before** `/research.methodology`.

1. **Load the research definition** from `research/###-topic-name/definition.md`

2. **Identify areas needing clarification**:
   - Ambiguous scope boundaries
   - Unclear research questions
   - Missing context or constraints
   - Undefined terminology
   - Unstated assumptions
   - Ethical considerations not addressed
   - Resource/time constraints not specified

3. **Generate targeted questions** (maximum 5-8 questions):
   - Each question should be specific and actionable
   - Focus on high-impact clarifications
   - Avoid trivial details
   - Group related questions
   - Prioritize by: scope impact > methodology impact > resource impact > technical details

4. **Present questions to user** in an interactive format

5. **Update research definition** based on answers:
   - Refine scope section
   - Clarify research questions
   - Document assumptions explicitly
   - Add constraints section if needed
   - Update success criteria based on clarifications

6. **Output summary**:
   - Number of clarifications addressed
   - Updated sections in definition
   - Key decisions documented
   - **Next step**: Proceed to `/research.methodology` to design the research approach

**Question Types**:
- **Scope Boundaries**: "Should this research cover X or is that out of scope?"
- **Depth vs Breadth**: "Should we go deep on X or cover X, Y, Z at high level?"
- **Time Period**: "What time period should this research focus on?"
- **Geographic/Domain**: "Should this be limited to specific regions/domains?"
- **Source Types**: "Should we prioritize academic sources, industry reports, or both?"
- **Ethical**: "Are there ethical considerations around data sources or topics?"
- **Resource Constraints**: "What's the target depth - quick overview vs comprehensive analysis?"
