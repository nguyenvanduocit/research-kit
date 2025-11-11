---
description: Create or update the research definition from a natural language research topic description.
scripts:
  sh: scripts/bash/create-new-research.sh --json "{ARGS}"
  ps: scripts/powershell/create-new-research.ps1 -Json "{ARGS}"
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/research.define` in the triggering message **is** the research topic description. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that research topic description, do this:

1. **Generate a concise short name** (2-4 words) for the branch:
   - Analyze the research description and extract the most meaningful keywords
   - Create a 2-4 word short name that captures the essence of the research
   - Use descriptive format (e.g., "ai-market-analysis", "blockchain-security")
   - Preserve technical terms and acronyms (AI, ML, IoT, etc.)
   - Keep it concise but descriptive enough to understand the research at a glance
   - Examples:
     - "I want to research AI market trends in healthcare" → "ai-healthcare-trends"
     - "Analyze blockchain security vulnerabilities" → "blockchain-security"
     - "Study remote work productivity impact" → "remote-work-productivity"

2. **Check for existing branches before creating new one**:

   a. First, fetch all remote branches to ensure we have the latest information:
      ```bash
      git fetch --all --prune
      ```

   b. Find the highest research number across all sources for the short-name:
      - Remote branches: `git ls-remote --heads origin | grep -E 'refs/heads/[0-9]+-<short-name>$'`
      - Local branches: `git branch | grep -E '^[* ]*[0-9]+-<short-name>$'`
      - Research directories: Check for directories matching `research/[0-9]+-<short-name>`

   c. Determine the next available number:
      - Extract all numbers from all three sources
      - Find the highest number N
      - Use N+1 for the new branch number

   d. Run the script `{SCRIPT}` with the calculated number and short-name:
      - Pass `--number N+1` and `--short-name "your-short-name"` along with the research description
      - Bash example: `{SCRIPT} --json --number 5 --short-name "ai-healthcare" "Research AI trends in healthcare"`
      - PowerShell example: `{SCRIPT} -Json -Number 5 -ShortName "ai-healthcare" "Research AI trends in healthcare"`

   **IMPORTANT**:
   - Check all three sources (remote branches, local branches, research directories) to find the highest number
   - Only match branches/directories with the exact short-name pattern
   - If no existing branches/directories found with this short-name, start with number 1
   - You must only ever run this script once per research topic
   - The JSON is provided in the terminal as output - always refer to it to get the actual content you're looking for
   - The JSON output will contain BRANCH_NAME and DEFINITION_FILE paths
   - For single quotes in args, use escape syntax: e.g 'I'\''m' (or double-quote if possible: "I'm")

3. Load `templates/research-definition-template.md` to understand required sections.

4. Follow this execution flow:

    1. Parse user description from Input
       If empty: ERROR "No research topic provided"
    2. Extract key concepts from description
       Identify: research type, domain, key questions, scope
    3. Determine Research Type:
       - Academic Research (theory, literature review, scholarly output)
       - Market/Business Research (market analysis, competitive intelligence, trends)
       - Technical Research (technology evaluation, feasibility, comparisons)
       - General Investigation (topic exploration, knowledge synthesis)
    4. For unclear aspects:
       - Make informed assumptions based on context
       - Mark with [NEEDS CLARIFICATION: specific question] if:
         - The research scope is ambiguous
         - Multiple interpretations exist with different resource implications
         - Ethical considerations need explicit guidance
       - **LIMIT: Maximum 3 [NEEDS CLARIFICATION] markers total**
       - Prioritize clarifications by impact: scope > methodology > ethical considerations > technical details
    5. Define Research Questions:
       - Primary question (1)
       - Sub-questions (2-5)
       Each question must be specific, answerable, and relevant
    6. Define Research Objectives:
       What this research aims to achieve
       Each objective must be measurable and aligned with questions
    7. Define Scope:
       - What's included (explicit boundaries)
       - What's excluded (explicit out-of-scope items)
       - Time boundaries (if applicable)
       - Geographic/domain boundaries (if applicable)
    8. Define Expected Deliverables:
       - Literature review document
       - Data analysis/findings
       - Final research report
       - Supporting materials (datasets, appendices, etc.)
    9. Define Success Criteria:
       - Research completeness metrics
       - Quality standards to meet
       - Source credibility requirements
    10. Return: SUCCESS (research definition ready for methodology design)

5. Write the research definition to DEFINITION_FILE using the template structure, replacing placeholders with concrete details derived from the research description while preserving section order and headings.

6. **Research Definition Quality Validation**: After writing the initial definition, validate it against quality criteria:

   a. Check for:
      - Clear, specific research questions
      - Well-defined scope boundaries
      - Realistic objectives
      - Appropriate research type selection
      - Ethical considerations addressed (if applicable)
      - Source quality standards defined

   b. If any critical elements are missing or unclear, flag them with [REVIEW NEEDED: reason]

7. Output summary to user:
   - Research topic short name
   - Branch name created
   - Research type identified
   - Number of research questions defined
   - Key scope boundaries
   - Next step: Use `/research.refine` if clarifications needed, otherwise proceed to `/research.methodology`

**Research Type Guidance**:

- **Academic Research**: Use when output should be scholarly, with extensive literature review, theoretical frameworks, and citations. Focus on contributing to academic knowledge.

- **Market/Business Research**: Use when analyzing markets, competitors, trends, customer insights. Focus on actionable business intelligence.

- **Technical Research**: Use when evaluating technologies, architectures, tools, or technical approaches. Focus on feasibility, trade-offs, and technical recommendations.

- **General Investigation**: Use for broad topic exploration, fact-checking, due diligence, or knowledge synthesis. Focus on comprehensive understanding.

**Key Differences from Code Specifications**:
- Research definitions focus on *questions to answer* rather than *features to build*
- Scope defines *knowledge boundaries* rather than *functional boundaries*
- Success criteria focus on *research quality* rather than *acceptance criteria*
- Deliverables are *documents and insights* rather than *working software*
