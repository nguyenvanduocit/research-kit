# Quick Start Guide

This guide will help you get started with Systematic Research Development using Research Kit.

## The Research Workflow

### 1. Install Research Kit

Initialize your project with your preferred AI assistant (Claude Code or Codex CLI):

```bash
uvx --from git+https://github.com/nguyenvanduocit/research-kit.git research init <PROJECT_NAME>
# or specify agent explicitly
uvx --from git+https://github.com/nguyenvanduocit/research-kit.git research init <PROJECT_NAME> --ai claude
```

### 2. Define Your Research

Use the `/research.define` command to describe your research topic and questions. Focus on the **what** and **why**, not the methodology yet.

```bash
/research.define Research the impact of large language models on academic research workflows. Specifically investigate how AI assistants affect research productivity, quality, and reproducibility. Examine both benefits (faster literature review, better organization) and risks (over-reliance, bias amplification, citation errors).
```

### 3. Design Your Methodology

Use the `/research.methodology` command to plan your research approach, data sources, and analysis methods.

```bash
/research.methodology This will be a mixed-methods study combining systematic literature review with qualitative interviews. For the literature review, search academic databases (ACM Digital Library, arXiv, Google Scholar) for papers published 2020-2025 on AI in research. For qualitative data, conduct semi-structured interviews with 10-15 researchers who use AI assistants. Use thematic analysis for interview data and narrative synthesis for literature findings.
```

### 4. Execute Research and Analyze Data

The research process now follows four distinct phases:

1. **Execute** (`/research.execute`) - Collect data according to your methodology
2. **Analyze** (`/research.analyze`) - Process and analyze the collected data
3. **Synthesize** (`/research.synthesize`) - Draw conclusions from your findings
4. **Publish** (`/research.publish`) - Create publication-ready outputs

## Detailed Example: Investigating AI Safety Research Trends

Here's a complete example of conducting a literature review research project:

### Step 1: Define Research Topic with `/research.define`

```text
Conduct a systematic literature review on AI safety research trends from 2018-2025.
The research aims to:
1. Identify major themes and research areas within AI safety
2. Track how focus areas have evolved over time
3. Identify gaps in current research
4. Recommend future research directions

Research questions:
- What are the primary research themes in AI safety literature?
- How has the distribution of research focus changed from 2018 to 2025?
- Which safety concerns receive the most/least attention?
- What methodological approaches dominate the field?
- What gaps exist in current research coverage?

This research will inform research prioritization and funding decisions for an AI safety institute.
```

### Step 2: Refine the Research Definition

After the initial definition is created, use `/research.refine` to address any underspecified areas:

```text
For data sources, prioritize:
- arXiv (cs.AI, cs.LG, cs.CY with "safety" keywords)
- ACM Digital Library
- NeurIPS, ICML, ICLR proceedings (safety workshops)
- AI safety-specific venues (AI Safety conference, SafeAI workshop)
- Key research organizations (CHAI, MIRI, DeepMind Safety Team, Anthropic)

Inclusion criteria:
- Published 2018-2025
- Focuses on AI safety, alignment, robustness, or interpretability
- Peer-reviewed or from reputable organizations
- English language

Exclusion criteria:
- General machine learning papers without safety focus
- Opinion pieces without empirical analysis or theoretical contribution
- Duplicate publications
```

Also validate the research definition checklist:

```text
Read the review and acceptance checklist in the research definition, and check off each item if the research definition meets the criteria. Leave it empty if it does not.
```

### Step 3: Design Methodology with `/research.methodology`

Be specific about your research design, data collection approach, and analysis methods:

```text
Research Design: Systematic literature review following PRISMA guidelines (adapted for computer science)

Search Strategy:
- Primary databases: arXiv, ACM DL, Google Scholar, Semantic Scholar
- Search terms: ("AI safety" OR "machine learning safety" OR "AI alignment" OR "AI robustness" OR "AI interpretability" OR "AI explainability") AND ("2018"[year] OR "2019"[year] OR ... "2025"[year])
- Citation tracking: Forward and backward citations from seminal works (Amodei et al. 2016, etc.)

Screening Process:
- Phase 1: Title screening (2000 expected results → ~800 after title screening)
- Phase 2: Abstract screening (~800 → ~300 after abstract review)
- Phase 3: Full-text review (~300 → ~150 final inclusion)

Data Extraction:
- Bibliographic info (authors, year, venue, citations)
- Research theme (categorize using preliminary taxonomy)
- Methodology (theoretical, empirical, survey, etc.)
- AI system type (language models, robotics, autonomous systems, general)
- Safety aspect (alignment, robustness, interpretability, fairness, privacy, etc.)

Analysis Approach:
- Thematic analysis to identify major research themes
- Temporal analysis to track trend evolution (2-year buckets: 2018-2019, 2020-2021, 2022-2023, 2024-2025)
- Network analysis of citation patterns
- Gap analysis using framework synthesis

Tools:
- Zotero for reference management
- Python + pandas for quantitative analysis
- R + ggplot2 for visualization
- NVivo for qualitative coding (if needed)
```

### Step 4: Validate and Conduct Research

Have your AI assistant review the methodology:

```text
Review the methodology document and verify that:
1. The search strategy is comprehensive and reproducible
2. Inclusion/exclusion criteria are clear and objective
3. The screening process follows best practices
4. Data extraction captures all relevant dimensions
5. Analysis approach is appropriate for the research questions
6. Timeline is realistic

Flag any gaps or concerns.
```

Then begin the research with the new four-phase process:

### Step 5: Execute Data Collection with `/research.execute`

```text
Begin data collection according to research/001-ai-safety-trends/methodology.md.
Start with the database searches, document all results in the execution log, and proceed with screening phase 1.
Track all data collection progress and maintain quality metrics.
```

### Step 6: Analyze Data with `/research.analyze`

```text
Analyze the collected papers using the planned approach:
- Apply thematic analysis to identify major research themes
- Conduct temporal analysis to track trend evolution
- Perform network analysis of citation patterns
- Generate statistical summaries and visualizations
Document all analysis decisions and create reproducible analysis scripts.
```

### Step 7: Synthesize Findings with `/research.synthesize`

```text
Synthesize the analysis results to answer the research questions:
- Connect findings to each research question
- Identify emergent themes across the data
- Build theoretical contributions
- Develop practical recommendations
- Assess confidence levels and acknowledge limitations
```

### Step 8: Prepare Publication with `/research.publish`

```text
Create a research report suitable for the AI safety institute:
- Executive summary with key findings
- Comprehensive methodology documentation
- Visual representations of trends
- Evidence-based recommendations for future research priorities
- Properly formatted citations and bibliography
```

## Key Principles

- **Be explicit** about your research questions and scope
- **Don't jump to methodology** during research definition phase
- **Iterate and refine** your research design before data collection
- **Validate** the methodology before investing time in data collection
- **Let the AI assistant help** with systematic execution, but maintain oversight

## Common Research Workflows

### Literature Review
1. `/research.define` → Define research questions and scope
2. `/research.methodology` → Design search strategy and analysis approach
3. `/research.execute` → Conduct searches, screening, and data collection
4. `/research.analyze` → Analyze papers and extract themes
5. `/research.synthesize` → Synthesize findings and draw conclusions
6. `/research.publish` → Prepare literature review paper or report

### Empirical Research (Interviews, Surveys, Experiments)
1. `/research.define` → Define research questions and hypotheses
2. `/research.methodology` → Design study, instruments, and analysis plan
3. Ethics review (if required) → Obtain IRB approval
4. `/research.execute` → Collect data (interviews, surveys, experiments)
5. `/research.analyze` → Process and analyze collected data
6. `/research.synthesize` → Interpret findings and connect to literature
7. `/research.publish` → Write research paper

### Market Research
1. `/research.define` → Define market questions and scope
2. `/research.methodology` → Plan data sources and analysis approach
3. `/research.execute` → Gather market data from sources
4. `/research.analyze` → Analyze market trends and patterns
5. `/research.synthesize` → Draw insights and identify opportunities
6. `/research.publish` → Create market report or presentation

### Technical Research
1. `/research.define` → Define technical questions (e.g., "Which framework is best for X?")
2. `/research.methodology` → Plan evaluation criteria and comparison approach
3. `/research.execute` → Run benchmarks and collect performance data
4. `/research.analyze` → Evaluate options systematically
5. `/research.synthesize` → Compare findings and make recommendations
6. `/research.publish` → Document decision rationale and findings

## Next Steps

- Read the [complete RDI methodology guide](../research-driven.md) for in-depth guidance
- Review the [agent integration guide](../AGENTS.md) for agent-specific details
- Explore the repository structure and templates
- Join the community and contribute!

## Tips for Success

1. **Start small**: Begin with a focused research question, not a massive project
2. **Use the checklist**: The research definition includes a checklist—use it to validate completeness
3. **Iterate**: Don't expect perfection on the first pass; refine your definition and methodology
4. **Document everything**: The AI assistant helps, but you should review and approve all research decisions
5. **Maintain rigor**: The templates guide you through best practices—follow them
6. **Ask for clarification**: Use `/research.refine` liberally to address gaps
7. **Version control**: Commit research artifacts regularly; use branches for different research topics

## Common Pitfalls to Avoid

- ❌ Skipping the methodology phase and jumping straight to analysis
- ❌ Defining research questions that are too broad or vague
- ❌ Not validating the research design before data collection
- ❌ Collecting data without clear analysis plan
- ❌ Confusing exploratory research with confirmatory research
- ❌ Over-relying on AI without critical oversight
- ❌ Ignoring ethical considerations and bias

## Getting Help

If you get stuck:
1. Review the [Research-Driven Investigation methodology guide](../research-driven.md)
2. Check the [agent integration guide](../AGENTS.md) for agent-specific help
3. Open an issue on GitHub
4. Check existing issues for similar questions
