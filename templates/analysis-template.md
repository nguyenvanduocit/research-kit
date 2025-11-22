# Research Analysis

## IMPORTANT: Citation Rules

> **All evidence MUST cite local source files with line numbers.**
> **Citation format: `sources/path/file.md:line` or `data/raw/file.csv:row`**
> **NEVER cite URLs directly - all sources must be downloaded locally first.**

## Analysis Overview
- **Analysis Start Date**: [DATE]
- **Analysis End Date**: [TBD]
- **Primary Analyst**: [NAME]
- **Analysis Tools Used**: [Software/Languages]
- **Research Questions**: [From definition.md]
- **Sources Index**: See `sources/SOURCES_INDEX.md`

## Data Preparation

### Data Inventory
| Dataset | Source | Records | Variables | Date Range | Quality Score |
|---------|--------|---------|-----------|------------|---------------|
| [Name] | [Source] | [N] | [N] | [Range] | [1-10] |

### Data Cleaning Summary
- **Original Records**: [N]
- **Records After Cleaning**: [N]
- **Records Removed**: [N] ([%])
- **Reasons for Removal**:
  - Missing critical data: [N]
  - Outside scope: [N]
  - Quality issues: [N]
  - Duplicates: [N]

### Data Transformations
1. **Transformation 1**: [Description and rationale]
2. **Transformation 2**: [Description and rationale]

## Exploratory Data Analysis

### Descriptive Statistics

#### Continuous Variables
| Variable | N | Mean | SD | Min | Q1 | Median | Q3 | Max | Skewness | Kurtosis |
|----------|---|------|----|----|----|---------|----|-----|----------|----------|
| [Var1] | | | | | | | | | | |

#### Categorical Variables
| Variable | Categories | Mode | Frequency (%) | Chi-square | p-value |
|----------|-----------|------|---------------|------------|---------|
| [Var1] | [N] | [Category] | [%] | [χ²] | [p] |

### Distribution Analysis
- **Normal Distributions**: [List variables]
- **Skewed Distributions**: [List variables and direction]
- **Outliers Identified**: [Variables and treatment]

### Missing Data Analysis
| Variable | Missing (N) | Missing (%) | Pattern | Imputation Method |
|----------|-------------|-------------|---------|-------------------|
| [Var1] | [N] | [%] | [MCAR/MAR/MNAR] | [Method or N/A] |

## Statistical Analysis

### Hypothesis Testing

#### Test 1: [Test Name]
- **Hypothesis**:
  - H₀: [Null hypothesis]
  - H₁: [Alternative hypothesis]
- **Test Type**: [t-test/ANOVA/Chi-square/etc.]
- **Assumptions Checked**:
  - [ ] Normality
  - [ ] Homogeneity of variance
  - [ ] Independence
- **Test Statistic**: [Value]
- **Degrees of Freedom**: [df]
- **p-value**: [p]
- **Effect Size**: [Cohen's d/η²/Cramér's V]
- **Conclusion**: [Reject/Fail to reject H₀]
- **Interpretation**: [Plain language interpretation]

#### Test 2: [Test Name]
[Repeat structure]

### Correlation Analysis

#### Correlation Matrix
| Variable | Var1 | Var2 | Var3 | Var4 |
|----------|------|------|------|------|
| Var1 | 1.00 | | | |
| Var2 | [r] | 1.00 | | |
| Var3 | [r] | [r] | 1.00 | |
| Var4 | [r] | [r] | [r] | 1.00 |

**Significant Correlations** (p < 0.05):
1. Var1 & Var2: r = [value], p = [value]
2. [Continue list]

### Regression Analysis

#### Model 1: [Outcome Variable]
- **Model Type**: [Linear/Logistic/Poisson/etc.]
- **Predictors**: [List]
- **Model Fit**:
  - R² / Pseudo-R²: [Value]
  - Adjusted R²: [Value]
  - F-statistic: [Value], p = [value]
  - AIC/BIC: [Values]

**Coefficients Table**:
| Predictor | B | SE | β | t/z | p | 95% CI |
|-----------|---|----|----|-----|---|---------]
| (Intercept) | | | | | | |
| [Var1] | | | | | | |

**Model Diagnostics**:
- [ ] Linearity assumption met
- [ ] Residuals normally distributed
- [ ] Homoscedasticity confirmed
- [ ] No multicollinearity (VIF < 10)
- [ ] No influential outliers

## Pattern Analysis

### Cluster Analysis
- **Method**: [K-means/Hierarchical/DBSCAN]
- **Number of Clusters**: [N]
- **Cluster Validation**:
  - Silhouette Score: [Value]
  - Davies-Bouldin Index: [Value]

**Cluster Characteristics**:
| Cluster | N | Key Features | Interpretation |
|---------|---|--------------|----------------|
| 1 | [N] | [Features] | [Meaning] |

### Factor Analysis
- **Method**: [PCA/EFA/CFA]
- **Factors Extracted**: [N]
- **Variance Explained**: [%]
- **KMO Measure**: [Value]
- **Bartlett's Test**: χ² = [Value], p = [value]

**Factor Loadings**:
| Variable | Factor 1 | Factor 2 | Factor 3 |
|----------|----------|----------|----------|
| [Var1] | [Loading] | | |

## Key Findings

### Finding 1: [Clear Statement]
- **Evidence Type**: [Statistical/Qualitative/Mixed]
- **Supporting Data** (with file:line citations):
  - Statistical test: [Result] (data/processed/analysis.csv:row)
  - Effect size: [Value]
  - Confidence interval: [CI]
- **Source Evidence**:
  > "Supporting quote from downloaded source" (sources/papers/author-year.md:123-125)
- **Visualization**: `figures/finding1_plot.png`
- **Robustness Check**: [Method and result]
- **Interpretation**: [What this means in context]

### Finding 2: [Clear Statement]
[Repeat structure with file:line citations]

### Finding 3: [Clear Statement]
[Repeat structure with file:line citations]

## Comparison with Literature

### Confirmatory Findings
1. **Finding**: [Statement]
   - **Aligns with**: Smith (2024) (sources/papers/smith-2024.md:78-85)
   - **Strength of alignment**: [Strong/Moderate/Weak]
   - **Quote**: "relevant quote" (sources/papers/smith-2024.md:82)

### Contradictory Findings
1. **Finding**: [Statement]
   - **Contradicts**: Jones (2023) (sources/papers/jones-2023.md:145)
   - **Possible explanations**: [List]

### Novel Findings
1. **Finding**: [Statement]
   - **Novelty**: [Why this is new - no similar findings in sources/papers/]
   - **Implications**: [What this suggests]

## Sensitivity Analysis

### Robustness Checks
1. **Alternative specifications**: [Results hold/change]
2. **Outlier influence**: [Minimal/Substantial]
3. **Different time periods**: [Consistent/Variable]
4. **Subsample analysis**: [Results by subgroup]

## Limitations of Analysis

### Data Limitations
- [Limitation 1 and impact]
- [Limitation 2 and impact]

### Methodological Limitations
- [Limitation 1 and impact]
- [Limitation 2 and impact]

### Generalizability Constraints
- [Constraint 1]
- [Constraint 2]

## Visualizations

### Figures Generated
1. `fig_01_distributions.png` - Distribution plots of key variables
2. `fig_02_correlations.png` - Correlation heatmap
3. `fig_03_main_effect.png` - Main effect visualization
4. `fig_04_interactions.png` - Interaction effects
5. `fig_05_clusters.png` - Cluster analysis results

### Tables Generated
1. `table_01_descriptive.csv` - Descriptive statistics
2. `table_02_correlations.csv` - Correlation matrix
3. `table_03_regression.csv` - Regression results
4. `table_04_comparisons.csv` - Group comparisons

## Analysis Code and Reproducibility

### Scripts Created
- `01_data_cleaning.R/py` - Data preparation script
- `02_exploratory.R/py` - EDA script
- `03_statistical_tests.R/py` - Hypothesis testing
- `04_models.R/py` - Regression and advanced models
- `05_visualizations.R/py` - Figure generation

### Reproducibility Checklist
- [ ] Random seed set for all analyses
- [ ] Package versions documented
- [ ] Data dictionary created
- [ ] Analysis pipeline documented
- [ ] Results independently verified

## Next Steps for Synthesis

### Priority Areas for Synthesis
1. [Area 1 - why important]
2. [Area 2 - why important]
3. [Area 3 - why important]

### Questions for Synthesis Phase
1. How do findings relate to research questions?
2. What theoretical implications emerge?
3. What practical recommendations follow?

## Analysis Sign-off

### Quality Review
- **Statistical Review**: [Name, Date]
- **Domain Expert Review**: [Name, Date]
- **Reproducibility Check**: [Name, Date]
- **Status**: ✅ Approved | ⏳ Pending | 🔄 Revisions Needed

### Revision History
| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | [DATE] | Initial analysis | [Name] |

## Citation Verification Checklist

- [ ] All findings cite source data with file:line format
- [ ] All literature comparisons cite downloaded sources (sources/papers/)
- [ ] No direct URL citations in document
- [ ] All quotes have exact line number references
- [ ] Sources index is current (`sources/SOURCES_INDEX.md`)

---

*This document presents the complete analysis of research data. All findings are based on the methods described and have been validated through appropriate statistical techniques. All citations reference locally downloaded sources with file:line format.*