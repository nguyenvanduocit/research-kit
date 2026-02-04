---
description: Analyze collected data and generate insights
scripts:
  sh: scripts/bash/setup-analysis.sh
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command guides the systematic analysis of collected data to generate insights and findings. Run this **after** `/research.execute`.

**IMPORTANT**: The setup script (`scripts/bash/setup-analysis.sh`) will automatically:
- Create all necessary directories (`figures/`, `tables/`, `data/results/`, `notebooks/`)
- Set up analysis templates and notebooks
- Initialize tracking files
- Verify prerequisite phases have been completed

**DO NOT manually create these directories or files - let the script handle it!**

1. **Quality Gate: AI Verification** (after script gate passes)

   Read `execution.md`, `sources/SOURCES_INDEX.md`, and scan `sources/` directory. Verify ALL of the following.

   **REQUIRED checks**:
   - [ ] At least 20 sources downloaded locally and indexed in SOURCES_INDEX.md
   - [ ] At least 30% of sources are Tier 1 (peer-reviewed journals, official statistics, primary data)
   - [ ] Zero URL-only citations in execution.md (all citations use file:line format)
   - [ ] Data collection status documented for every source listed in methodology.md
   - [ ] Every research question has at least 3 relevant sources collected
   - [ ] Quality score documented for at least 1 dataset
   - [ ] Failed/unavailable sources documented with reasons

   **Output format:**
   ```
   QUALITY GATE: execute → analyze (AI Verification)
   REQUIRED: ✓/✗ [check]
   RESULT: PASSED / BLOCKED
   ```

   If BLOCKED: Tell user which checks failed, suggest continuing `/research.execute` to collect more data.

2. **Load research context**:
   - Research definition from `research/###-topic-name/definition.md`
   - Methodology from `research/###-topic-name/methodology.md`
   - Execution log from `research/###-topic-name/execution.md`
   - Data inventory from execution phase

3. **Initialize analysis environment**:
   - Create/update `research/###-topic-name/analysis.md`
   - Set up analysis notebooks in `notebooks/`
   - Load data from `data/raw/` and `data/processed/`
   - Prepare visualization directory `figures/`

4. **Data preparation and cleaning**:

   **For each data source**:
   - Load raw data
   - Check data quality and completeness
   - Handle missing values appropriately
   - Remove duplicates and outliers
   - Transform and normalize as needed
   - Save processed data with documentation

5. **Exploratory data analysis (EDA)**:

   **Generate initial insights**:
   - Descriptive statistics for all variables
   - Distribution analysis and visualizations
   - Correlation analysis between variables
   - Pattern identification
   - Anomaly detection
   - Initial hypothesis testing

6. **Statistical analysis** (as per methodology):

   **Apply planned analyses**:
   - Run specified statistical tests
   - Calculate confidence intervals
   - Perform regression analyses if applicable
   - Conduct comparative analyses
   - Apply machine learning models if planned
   - Validate all statistical assumptions

7. **Literature integration**:

   **Compare with existing research**:
   - Map findings to literature review
   - Identify confirmatory findings
   - Highlight contradictory results
   - Note novel discoveries
   - Update theoretical framework
   - Strengthen evidence chains

8. **Generate visualizations**:

   Create figures for:
   - Key data distributions
   - Relationship plots
   - Trend analyses
   - Comparison charts
   - Statistical results
   - Conceptual diagrams

   Save all to `figures/` with naming convention: `fig_XX_description.png`

9. **Document analysis results**:

   Update `analysis.md` with:
   ```markdown
   # Research Analysis

   ## Analysis Overview
   - Analysis Date: [DATE]
   - Data Sources Analyzed: [List]
   - Analysis Methods Used: [List]

   ## Data Quality Assessment

   ### Dataset 1: [NAME]
   - Total Records: [N]
   - Valid Records: [N]
   - Missing Data: [%]
   - Quality Score: [1-10]
   - Processing Applied: [List]

   ## Key Findings

   ### Finding 1: [Clear statement]
   - Supporting Evidence: [Data/statistics]
   - Statistical Significance: [p-value if applicable]
   - Effect Size: [if applicable]
   - Visualization: `figures/fig_01_finding1.png`
   - Interpretation: [What this means]

   ### Finding 2: [Clear statement]
   - Supporting Evidence: [Data/statistics]
   - Statistical Significance: [p-value if applicable]
   - Effect Size: [if applicable]
   - Visualization: `figures/fig_02_finding2.png`
   - Interpretation: [What this means]

   ## Statistical Results

   ### Test 1: [Name]
   - Hypothesis: [H0 and H1]
   - Test Statistic: [value]
   - p-value: [value]
   - Conclusion: [Accept/Reject H0]

   ## Pattern Analysis

   ### Pattern 1: [Description]
   - Evidence: [Data points]
   - Strength: [Strong/Moderate/Weak]
   - Implications: [What this suggests]

   ## Comparison with Literature
   - Confirmatory Findings: [List]
   - Contradictory Findings: [List]
   - Novel Findings: [List]

   ## Limitations of Analysis
   - [Limitation 1 and impact]
   - [Limitation 2 and impact]

   ## Next Steps for Synthesis
   ```

10. **Create analysis notebooks**:

   Generate Jupyter notebooks for:
   - `01_data_preparation.ipynb` - cleaning and processing
   - `02_exploratory_analysis.ipynb` - EDA and visualizations
   - `03_statistical_analysis.ipynb` - hypothesis testing
   - `04_findings_validation.ipynb` - robustness checks

11. **Quality validation**:

    Check analysis for:
    - Statistical validity
    - Assumption violations
    - Multiple testing corrections
    - Effect size interpretation
    - Replication potential
    - Code reproducibility

12. **Generate analysis artifacts**:
    - Statistical summary tables (`tables/`)
    - Analysis scripts (`scripts/analyze_*.py`)
    - Results datasets (`data/results/`)
    - Validation reports (`logs/analysis_validation.log`)

13. **Output analysis summary**:
    - Number of findings identified
    - Statistical tests performed
    - Visualizations created
    - Patterns discovered
    - Literature alignments found
    - Quality metrics achieved
    - Readiness for synthesis phase

**Analysis Principles**:
- Let data speak for itself
- Avoid p-hacking or cherry-picking
- Report all results, not just significant ones
- Use appropriate statistical methods
- Consider practical significance, not just statistical
- Document all analysis decisions
- Ensure full reproducibility

**Common Analysis Pitfalls**:
- Correlation ≠ Causation
- Multiple comparisons problem → Apply corrections
- Violated assumptions → Use appropriate alternatives
- Overfitting models → Cross-validate
- Ignoring effect sizes → Report with p-values
- Selective reporting → Document all analyses
- Poor visualization choices → Follow best practices

**Reproducibility Standards**:
- Version control all analysis code
- Document package versions and environment
- Use seed values for random processes
- Save intermediate results
- Create analysis pipeline scripts
- Include data dictionary
- Provide clear README files

This phase focuses on ANALYZING data to generate findings, not drawing final conclusions. Synthesis and interpretation come in the next phase.

**Specialized agents**: Use `@agent-analysis-expert` for complex statistical analysis or visualization tasks.

**Next step**: Once analysis is complete, proceed to `/research.synthesize` to draw conclusions. For quality review, ask `@agent-research-reviewer` to validate analysis.