---
description: Create publication-ready research outputs
scripts:
  sh: scripts/bash/setup-publish.sh
  ps: scripts/powershell/setup-publish.ps1
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command guides the creation of publication-ready research outputs including reports, papers, and presentations. Run this **after** `/research.synthesize`.

**IMPORTANT**: The setup script (`scripts/bash/setup-publish.sh` or `scripts/powershell/setup-publish.ps1`) will automatically:
- Create publication directories (`publications/report/`, `publications/paper/`, `publications/presentation/`, `publications/brief/`)
- Initialize publication templates based on type
- Copy figures and tables from analysis phase
- Set up metadata and checklist files
- Verify prerequisite phases have been completed (especially `synthesis.md`)

**DO NOT manually create these directories or files - let the script handle it!**

1. **Load complete research materials**:
   - Definition, methodology, execution log
   - Analysis results and synthesis
   - All figures, tables, and references
   - Determine publication format from user input

2. **Initialize publication structure**:
   - Create `research/###-topic-name/publications/` directory
   - Set up format-specific subdirectories:
     - `publications/report/` - comprehensive research report
     - `publications/paper/` - academic paper
     - `publications/presentation/` - slide deck
     - `publications/brief/` - executive summary

3. **Determine publication format**:

   Based on user input or ask:
   - **Research Report**: Comprehensive documentation
   - **Academic Paper**: Journal/conference submission
   - **Presentation**: Slide deck for talks
   - **Executive Brief**: 2-3 page summary
   - **Blog Post**: Public-facing article
   - **Policy Brief**: Government/organization focus

4. **Generate Research Report** (if selected):

   Create `publications/report/research_report.md`:
   ```markdown
   # [TITLE]: [Research Topic]

   ## Executive Summary
   [1-2 page overview of entire research]
   - Context and motivation
   - Key research questions
   - Methodology overview
   - Major findings
   - Main conclusions
   - Recommendations

   ## 1. Introduction
   ### 1.1 Background
   [Context and problem statement]
   ### 1.2 Research Questions
   [Formal statement of questions]
   ### 1.3 Objectives
   [Specific research objectives]
   ### 1.4 Scope and Limitations
   [Boundaries of the research]

   ## 2. Literature Review
   [Synthesized from literature review]
   ### 2.1 Theoretical Framework
   ### 2.2 Previous Research
   ### 2.3 Research Gaps

   ## 3. Methodology
   [From methodology.md]
   ### 3.1 Research Design
   ### 3.2 Data Collection
   ### 3.3 Analysis Methods
   ### 3.4 Ethical Considerations

   ## 4. Results
   [From analysis.md]
   ### 4.1 Data Overview
   ### 4.2 Key Findings
   ### 4.3 Statistical Results
   [Include figures and tables]

   ## 5. Discussion
   [From synthesis.md]
   ### 5.1 Interpretation of Findings
   ### 5.2 Theoretical Implications
   ### 5.3 Practical Applications
   ### 5.4 Limitations

   ## 6. Conclusions
   ### 6.1 Summary of Findings
   ### 6.2 Answering Research Questions
   ### 6.3 Contributions
   ### 6.4 Future Research

   ## 7. Recommendations
   [Actionable recommendations]

   ## References
   [Complete bibliography]

   ## Appendices
   - A. Detailed Methodology
   - B. Additional Analyses
   - C. Data Tables
   - D. Research Instruments
   ```

5. **Generate Academic Paper** (if selected):

   Create `publications/paper/manuscript.md`:
   - Follow target journal format
   - Include: Abstract, Introduction, Methods, Results, Discussion, Conclusion
   - Limit to publication word count
   - Format citations per style guide
   - Create separate files for:
     - `cover_letter.md`
     - `highlights.md`
     - `supplementary_materials.md`

6. **Generate Presentation** (if selected):

   Create `publications/presentation/` with **Sli.dev** format:

   **Files Created**:
   - `slides.md` - Main presentation file in Sli.dev format
   - `package.json` - Node.js dependencies for Sli.dev
   - `README.md` - Instructions for running the presentation

   **Sli.dev Presentation Structure** (15-17 slides):
   ```markdown
   # Slide 1: Title (layout: cover)
   - Title, Authors, Date, Institution
   - Interactive navigation hints

   # Slide 2: Agenda (layout: two-cols)
   - Research Foundation
   - Findings & Impact
   - Duration estimate

   # Slide 3: Background (layout: image-right)
   - Problem statement with bullet points
   - Visual context
   - Impact statement highlight

   # Slide 4: Research Questions (layout: center)
   - Color-coded questions
   - Progressive reveal with v-clicks

   # Slide 5: Methodology (layout: two-cols)
   - Approach, data, analysis
   - Mermaid diagram flowchart

   # Slides 6-8: Key Findings (layout: image-left)
   - Finding with visualization
   - Evidence and impact
   - Key insight callout box

   # Slide 9: Discussion (layout: grid)
   - Confirms/Challenges/Reveals
   - Color-coded insight boxes

   # Slide 10: Limitations (layout: quote)
   - Study boundaries
   - Impact assessment

   # Slide 11: Conclusions (layout: statement)
   - Numbered key takeaways
   - Color-coded importance

   # Slide 12: Recommendations (layout: default)
   - Immediate/Short-term/Long-term
   - Action-oriented with icons

   # Slide 13: Future Research (layout: default)
   - Research directions with icons
   - Progressive reveal

   # Slide 14: Thank You (layout: end)
   - Contact information
   - Resource links

   # Slides 15+: Backup Slides
   - Additional detail for Q&A
   ```

   **Running the Presentation**:
   ```bash
   # Install dependencies (use bun or npm)
   bun install

   # Start development server
   bun run dev

   # Export to PDF
   bun run export-pdf

   # Export to PowerPoint
   bun run export-pptx
   ```

   **Sli.dev Features**:
   - Web-based presentation framework
   - Interactive animations and transitions
   - Presenter mode with notes
   - Export to PDF, PowerPoint, PNG
   - Code highlighting with Shiki
   - Mermaid diagram support
   - Dark mode toggle
   - Responsive layouts

7. **Generate Executive Brief** (if selected):

   Create `publications/brief/executive_brief.md`:
   - 2-3 pages maximum
   - Focus on actionable insights
   - Minimal technical detail
   - Clear recommendations
   - Visual summary if helpful

8. **Prepare publication assets**:

   **Figures and Tables**:
   - Copy all figures to `publications/[format]/figures/`
   - Format tables for publication
   - Create figure captions file
   - Ensure high resolution (300+ DPI)
   - Generate vector formats if needed

   **References**:
   - Format bibliography per style guide
   - Check all citations
   - Ensure DOIs included
   - Verify author names and years

9. **Apply publication standards**:

   **Quality checks**:
   - Grammar and spelling
   - Consistent terminology
   - Logical flow
   - Clear argumentation
   - Proper attribution
   - Format compliance

   **Style considerations**:
   - Active voice where appropriate
   - Concise writing
   - Clear section transitions
   - Appropriate tone for audience
   - Technical accuracy

10. **Generate metadata and supplementary files**:

    Create publication metadata:
    ```yaml
    # publications/metadata.yml
    title: [Full title]
    authors: [List]
    date: [Publication date]
    type: [Report/Paper/Brief]
    keywords: [List]
    abstract: [If applicable]
    doi: [If assigned]
    license: [CC-BY, etc.]
    ```

11. **Create submission package** (if applicable):

    For journal submissions:
    - Main manuscript (blinded if required)
    - Cover letter
    - Highlights/significance statement
    - Author information forms
    - Supplementary materials
    - Data availability statement

12. **Output publication summary**:
    - Publication type created
    - Total length (words/pages)
    - Number of figures/tables
    - References cited
    - Files generated
    - Submission readiness
    - Recommended next steps

**Publication Standards**:
- Accuracy above all else
- Clear and concise writing
- Proper attribution always
- Reproducibility enabled
- Accessibility considered
- Ethical compliance maintained
- Target audience focus

**Format-Specific Guidelines**:

**Research Report**:
- Comprehensive coverage
- Detailed methodology
- Full results presentation
- Extensive discussion

**Academic Paper**:
- Concise and focused
- Novel contribution emphasis
- Rigorous peer review ready
- Journal guidelines compliance

**Presentation**:
- Visual storytelling
- Key points only
- Engaging narrative
- Time-conscious design

**Executive Brief**:
- Decision-maker focused
- Action-oriented
- Minimal jargon
- Clear recommendations

**Common Publication Pitfalls**:
- Overstatement of findings → Stay within evidence
- Poor structure → Follow standard formats
- Missing citations → Check all claims
- Inconsistent data → Verify all numbers
- Weak conclusions → Strengthen with evidence
- Too technical/simple → Know your audience
- Format violations → Check guidelines carefully

This phase creates PUBLICATION-READY outputs, transforming the research into formats suitable for different audiences and purposes.