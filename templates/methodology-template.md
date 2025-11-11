# Research Methodology: [TOPIC_NAME]

**Branch**: `[###-topic-name]` | **Date**: [DATE] | **Spec**: [link]
**Input**: Research specification from `/research/[###-topic-name]/definition.md`

**Note**: This template is filled in by the `/researchkit.methodology` command. See `.specify/templates/commands/methodology.md` for the execution workflow.

## Summary

[Extract from research spec: primary research question + methodological approach from initial scoping]

## Research Context

<!--
  ACTION REQUIRED: Replace the content in this section with the research details
  for this topic. The structure here is presented in advisory capacity to guide
  the methodology development process.
-->

**Research Type**: [Academic / Market / Technical / General or NEEDS CLARIFICATION]
**Discipline/Domain**: [e.g., Computer Science, Public Health, Economics or NEEDS CLARIFICATION]
**Research Design**: [Qualitative / Quantitative / Mixed Methods or NEEDS CLARIFICATION]
**Approach**: [Exploratory / Descriptive / Explanatory / Evaluative or NEEDS CLARIFICATION]
**Timeline**: [e.g., 2 weeks, 3 months, 6 months or NEEDS CLARIFICATION]
**Resources Available**: [time, budget, access to databases, tools or NEEDS CLARIFICATION]
**Intended Audience**: [e.g., academic peers, stakeholders, general public or NEEDS CLARIFICATION]
**Output Format**: [e.g., academic paper, report, presentation, blog post or NEEDS CLARIFICATION]
**Scope Boundaries**: [what's included/excluded from this research or NEEDS CLARIFICATION]

## Principles Check

*GATE: Must pass before Phase 0 literature review. Re-check after Phase 1 methodology design.*

[Gates determined based on principles file - research quality standards, ethical requirements, bias mitigation protocols]

## Research Structure

### Documentation (this research topic)

```text
specs/[###-topic]/
├── methodology.md       # This file (/researchkit.methodology command output)
├── literature-review.md # Phase 0 output (/researchkit.methodology command)
├── data-schema.md       # Phase 1 output (if data collection involved)
├── analysis-methodology.md     # Phase 1 output (/researchkit.methodology command)
├── protocols/           # Phase 1 output (interview guides, survey instruments, etc.)
└── tasks.md             # Phase 2 output (/researchkit.tasks command - NOT created by /researchkit.methodology)
```

### Data Organization (repository root)
<!--
  ACTION REQUIRED: Replace the placeholder structure below with the concrete layout
  for this research project. Delete unused options and expand the chosen structure with
  real paths. The delivered methodology must not include Option labels.
-->

```text
# [REMOVE IF UNUSED] Option 1: Literature-based research (DEFAULT)
data/
├── sources/
│   ├── academic-papers/
│   ├── reports/
│   └── web-sources/
├── notes/
│   ├── reading-notes/
│   └── synthesis/
└── references/
    └── bibliography.bib

analysis/
├── themes/
├── frameworks/
└── findings/

# [REMOVE IF UNUSED] Option 2: Primary data collection (surveys, interviews, experiments)
data/
├── raw/
│   ├── survey-responses/
│   ├── interview-transcripts/
│   └── experimental-data/
├── processed/
│   ├── coded-data/
│   └── anonymized/
├── sources/              # Secondary sources
└── references/

analysis/
├── qualitative/
│   ├── coding/
│   └── themes/
├── quantitative/
│   ├── statistical/
│   └── visualizations/
└── synthesis/

protocols/
├── interview-guides/
├── survey-instruments/
└── consent-forms/

# [REMOVE IF UNUSED] Option 3: Mixed methods (combining literature + primary data)
data/
├── primary/
│   ├── raw/
│   └── processed/
├── secondary/
│   ├── academic-papers/
│   ├── reports/
│   └── web-sources/
├── notes/
└── references/

analysis/
├── qualitative/
├── quantitative/
├── integration/         # Where mixed methods are integrated
└── synthesis/

protocols/
```

**Structure Decision**: [Document the selected structure and reference the real
directories captured above]

## Complexity Tracking

> **Fill ONLY if Principles Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., Primary data collection beyond literature review] | [specific research question requires original data] | [existing literature insufficient because...] |
| [e.g., Complex statistical modeling] | [research design requires it] | [simpler descriptive stats insufficient because...] |

## Research Design

### Design Type Justification

**Chosen Design**: [Qualitative / Quantitative / Mixed Methods]

**Justification**: [Explain why this design is appropriate for the research questions. Consider:
- Nature of research questions (exploratory vs. confirmatory)
- Type of data needed to answer questions
- Epistemological assumptions
- Practical constraints]

### Research Approach

**Chosen Approach**: [Exploratory / Descriptive / Explanatory / Evaluative]

**Justification**: [Explain why this approach fits:
- Level of existing knowledge in the field
- Goals of the research
- Whether building theory or testing theory]

### Theoretical Framework

[If applicable, specify the theoretical lens or conceptual framework guiding this research]

**Framework**: [Name of framework or theory]

**Application**: [How this framework will be applied to guide data collection and analysis]

## Data Sources

### Primary Sources

> **Complete this section if collecting original data**

**Type**: [Interviews / Surveys / Experiments / Observations / Archival research / N/A]

**Sample Design**:
- **Size**: [number of participants/observations or NEEDS CLARIFICATION]
- **Selection Method**: [Random / Stratified / Purposive / Convenience / Snowball or NEEDS CLARIFICATION]
- **Rationale**: [Why this sampling approach is appropriate]

**Inclusion Criteria**:
- [Criterion 1]
- [Criterion 2]
- [etc.]

**Exclusion Criteria**:
- [Criterion 1]
- [Criterion 2]
- [etc.]

**Recruitment Strategy**: [How participants will be identified and recruited or N/A]

### Secondary Sources

> **Literature and existing data sources**

**Academic Databases**:
- [Google Scholar - for broad academic coverage]
- [PubMed - for health/medical research]
- [IEEE Xplore - for engineering/computer science]
- [JSTOR - for humanities/social sciences]
- [Web of Science - for citation tracking]
- [Scopus - for comprehensive coverage]
- [Domain-specific databases or NEEDS CLARIFICATION]

**Industry & Professional Sources**:
- [Gartner / Forrester - for market research]
- [Industry association reports]
- [Company whitepapers and technical documentation]
- [Professional publications or NEEDS CLARIFICATION]

**Government & Institutional Data**:
- [Statistical agencies - e.g., Census, BLS, WHO]
- [Government reports and policy documents]
- [NGO publications]
- [International organization data or NEEDS CLARIFICATION]

**Books & Monographs**:
- [Seminal works in the field]
- [Recent comprehensive treatments]
- [Edited volumes or NEEDS CLARIFICATION]

**News & Media Sources**:
- [Reputable news outlets for current events context]
- [Trade publications]
- [Criteria for media source credibility or NEEDS CLARIFICATION]

### Source Quality Criteria

**Credibility Assessment Framework**:
- **Academic sources**: Peer-review status, journal impact factor, author credentials, institutional affiliation
- **Industry sources**: Author expertise, organizational reputation, methodology transparency, potential conflicts of interest
- **Government/institutional**: Authoritative body status, data collection methodology, transparency
- **News/media**: Editorial standards, fact-checking processes, source attribution, bias assessment

**Recency Requirements**:
- **Core literature**: [e.g., last 10 years for foundational understanding]
- **Recent developments**: [e.g., last 2-3 years for current state]
- **Seminal works**: [Include regardless of age if field-defining]
- **Justification for exceptions**: [When older sources are necessary]

**Bias Identification & Mitigation**:
- **Source bias**: [How to identify funding bias, ideological bias, methodological bias]
- **Selection bias**: [Strategies to avoid cherry-picking supportive sources]
- **Publication bias**: [Consider grey literature, unpublished studies]
- **Researcher bias**: [Reflexivity practices, peer debriefing]

## Data Collection Methods

### Literature Review Strategy

**Search Strategy**:

**Keywords & Search Terms**:
```text
Primary terms: [term1], [term2], [term3]
Secondary terms: [term4], [term5]
Boolean combinations: ([term1] OR [term2]) AND [term3]
Synonyms/variants: [alternative terms to capture]
Exclusion terms: NOT [term6] (if needed to filter)
```

**Database-Specific Strategies**:
- [Google Scholar: broad initial scoping]
- [Specific databases: focused searches with controlled vocabulary]
- [Citation tracking: forward and backward citation searching]

**Inclusion Criteria**:
- [Criterion 1: e.g., published in peer-reviewed journals]
- [Criterion 2: e.g., empirical studies only]
- [Criterion 3: e.g., specific population or context]
- [Language: e.g., English only or multilingual]

**Exclusion Criteria**:
- [Criterion 1: e.g., opinion pieces without data]
- [Criterion 2: e.g., studies outside date range]
- [Criterion 3: e.g., irrelevant contexts]

**Screening Process**:

```text
Phase 1: Title screening
├── Export all search results
├── Review titles for obvious exclusions
└── Flag for abstract review

Phase 2: Abstract screening
├── Review abstracts of flagged articles
├── Apply inclusion/exclusion criteria
└── Flag for full-text review

Phase 3: Full-text review
├── Obtain full texts of remaining articles
├── Read and apply detailed criteria
├── Make final inclusion decisions
└── Document reasons for exclusion

Phase 4: Quality appraisal
├── Assess methodological quality
├── Evaluate relevance to research questions
└── Prioritize sources for synthesis
```

**Saturation Assessment**: [How to determine when sufficient literature has been reviewed]

### Primary Data Collection

> **Complete this section if conducting original data collection**

**Data Collection Instruments**:

**[Instrument Type 1]**: [e.g., Semi-structured interview protocol]
- **Content areas**: [Topics to be covered]
- **Sample questions**: [Key questions to be asked]
- **Pilot testing**: [How instrument will be tested and refined]
- **Location**: `protocols/[filename]` or NEEDS DEVELOPMENT

**[Instrument Type 2]**: [e.g., Survey questionnaire]
- **Scales used**: [Validated scales if applicable]
- **Question types**: [Open-ended, Likert, multiple choice, etc.]
- **Estimated completion time**: [time]
- **Location**: `protocols/[filename]` or NEEDS DEVELOPMENT

**Data Collection Procedures**:

**Timeline**:
- **Preparation phase**: [dates] - [activities]
- **Collection phase**: [dates] - [activities]
- **Follow-up phase**: [dates] - [activities if needed]

**Setting**: [Where data collection will occur - online, in-person, hybrid]

**Consent Process**: [How informed consent will be obtained]

**Compensation**: [If applicable, participant compensation details]

**Quality Control**:
- [Procedure to ensure data quality during collection]
- [Training for data collectors if multiple people involved]
- [Regular audits or checks]

### Documentation Approach

**Note-Taking System**:
- **Format**: [Markdown files / LaTeX / Plain text / Research software]
- **Organization**: [By source / By theme / Chronological]
- **Template**: [Consistent structure for notes]
- **Linking**: [How notes will be cross-referenced]

**Citation Management**:
- **Tool**: [Zotero / Mendeley / EndNote / BibTeX directly]
- **Citation Style**: [APA / MLA / Chicago / IEEE / Domain-specific]
- **Library Organization**: [Folder structure, tagging system]
- **Bibliography File**: `data/references/bibliography.bib`

**Data Organization**:

```text
Naming Convention:
├── Sources: YYYY-MM-DD_AuthorLastName_ShortTitle.pdf
├── Notes: YYYY-MM-DD_note_topic.md
├── Analysis: YYYY-MM-DD_analysis_theme.md
└── Data files: YYYY-MM-DD_data_description.csv

Folder Structure:
[Reference the chosen structure from "Research Structure" section above]

Version Control:
├── Git for tracking changes to analysis and writing
├── Backup strategy: [cloud storage, external drives]
└── Data preservation: [long-term archival plan]
```

**Research Log/Journal**:
- **Purpose**: [Track decisions, reflections, methodological choices]
- **Frequency**: [Daily / After each work session / Weekly]
- **Location**: `analysis/research-journal.md`

## Analysis Approach

### Analytical Frameworks

**Framework 1**: [Name of framework]
- **Description**: [What this framework does]
- **Application**: [How it will be applied to this research]
- **Justification**: [Why this framework is appropriate]
- **Reference**: [Citation for framework]

**Framework 2**: [Name of framework if multiple]
- **Description**: [What this framework does]
- **Application**: [How it will be applied to this research]
- **Justification**: [Why this framework is appropriate]
- **Reference**: [Citation for framework]

### Analysis Techniques

**[Primary Technique]**: [e.g., Thematic analysis / Content analysis / Statistical analysis / Comparative case study]

**Process**:
```text
Step 1: [Description]
├── Activities: [specific tasks]
├── Output: [what this step produces]
└── Tools: [software or methods used]

Step 2: [Description]
├── Activities: [specific tasks]
├── Output: [what this step produces]
└── Tools: [software or methods used]

Step 3: [Description]
├── Activities: [specific tasks]
├── Output: [what this step produces]
└── Tools: [software or methods used]

[Continue as needed]
```

**Coding Scheme** (if applicable):
- **Development**: [Deductive / Inductive / Combined]
- **Codebook**: [Where maintained - `analysis/codebook.md`]
- **Inter-coder reliability**: [If multiple coders, how agreement will be assessed]

**Statistical Analysis** (if applicable):
- **Descriptive statistics**: [What will be calculated]
- **Inferential tests**: [Which tests will be used and why]
- **Software**: [R / Python / SPSS / Stata / etc.]
- **Significance level**: [e.g., α = 0.05]
- **Power analysis**: [If conducted, what informed sample size]

### Synthesis Method

**Integration Strategy**: [How findings from different sources or methods will be synthesized]

**Synthesis Approach**:
- [Narrative synthesis / Meta-analysis / Thematic synthesis / Framework synthesis]
- [How contradictory findings will be handled]
- [How context will be considered in synthesis]

**Visualization**: [Tables, figures, concept maps to present synthesized findings]

### Quality Assurance

**Rigor Criteria**:

**For Qualitative Research**:
- **Credibility**: [Strategies like member checking, peer debriefing, triangulation]
- **Transferability**: [Thick description, context documentation]
- **Dependability**: [Audit trail, clear documentation of process]
- **Confirmability**: [Reflexivity, bracketing assumptions]

**For Quantitative Research**:
- **Internal validity**: [Control for confounds, appropriate design]
- **External validity**: [Generalizability considerations]
- **Reliability**: [Measurement consistency]
- **Objectivity**: [Standardized procedures]

**For Mixed Methods**:
- **Integration quality**: [How well methods are combined]
- **Complementarity**: [How findings complement each other]
- **Divergence handling**: [Protocol for contradictory findings]

**Audit Trail**: [Documentation of all methodological decisions and changes]

## Tools & Platforms

**Research Management**:
- [Zotero / Mendeley / EndNote - for reference management]
- [Research notebook system - physical or digital]
- [Project management tool - if team research]

**Data Collection**:
- [Qualtrics / Google Forms - for surveys]
- [Zoom / Teams - for remote interviews]
- [Recording equipment - for audio/video]
- [NVivo / Atlas.ti - for qualitative data management]

**Analysis Software**:
- [NVivo / Atlas.ti / MAXQDA - for qualitative analysis]
- [R / Python / SPSS / Stata - for quantitative analysis]
- [Excel / Google Sheets - for data organization]
- [Tableau / Power BI - for visualization]

**Citation & Writing**:
- [BibTeX / BibLaTeX - for bibliography management]
- [LaTeX / Markdown / Word - for writing]
- [Overleaf / VS Code - for collaborative writing]
- [Grammarly / LanguageTool - for writing assistance]

**Collaboration** (if applicable):
- [GitHub / GitLab - for version control]
- [Slack / Discord - for team communication]
- [Shared drives - for data sharing]

**Backup & Security**:
- [Cloud storage - encrypted if sensitive data]
- [External drives - for local backup]
- [Password manager - for secure credential storage]

## Ethical Considerations

### Ethics Approval

**IRB/Ethics Review**: [Required / Not required / Uncertain]

**If Required**:
- **Submitting institution**: [Which IRB or ethics board]
- **Application timeline**: [When to submit, expected review time]
- **Protocol elements**: [What needs to be included]
- **Approval required before**: [Which activities cannot start before approval]

**If Not Required**:
- **Justification**: [Why ethics review is not needed]
- **Self-audit**: [Internal ethical review process]

### Data Privacy & Confidentiality

**Personal Information**:
- **What is collected**: [Types of personal data if any]
- **Legal framework**: [GDPR / HIPAA / FERPA / Other applicable regulations]
- **Anonymization**: [How identifiable information will be removed or protected]
- **Data retention**: [How long data will be kept, disposal procedures]

**Confidentiality Measures**:
- **Storage**: [Encrypted devices, secure servers, access controls]
- **Access**: [Who has access to identifiable data]
- **Reporting**: [How to report findings without compromising confidentiality]
- **Identifiers**: [Use of pseudonyms, aggregate reporting]

### Informed Consent

**Consent Process** (if applicable):
- **Information provided**: [What participants will be told]
- **Voluntary participation**: [Clear statement of right to refuse/withdraw]
- **Consent documentation**: [Written / Verbal / Electronic]
- **Consent form location**: `protocols/consent-form.md` or NEEDS DEVELOPMENT

### Conflicts of Interest

**Researcher Conflicts**:
- **Financial**: [Any financial interests related to research topic]
- **Professional**: [Career advancement tied to specific outcomes]
- **Personal**: [Personal beliefs or relationships affecting objectivity]
- **Disclosure**: [How conflicts will be disclosed in publications]

**Funding Source**:
- **Funder**: [Who is funding this research or self-funded]
- **Funder influence**: [Any constraints or expectations from funder]
- **Disclosure**: [How funding will be acknowledged]

### Bias Mitigation

**Researcher Positionality**:
- **Background**: [Researcher's relevant background and assumptions]
- **Potential biases**: [Identified potential biases]
- **Reflexivity practices**: [How researcher will maintain awareness of bias]

**Methodological Bias Prevention**:
- **Selection bias**: [Strategies to ensure representative sampling/sourcing]
- **Confirmation bias**: [Active searching for disconfirming evidence]
- **Interpretation bias**: [Peer review, alternative explanations]

**Reporting**:
- **Transparency**: [Full disclosure of methodology, limitations, decisions]
- **Preregistration**: [If applicable, where protocol is registered]

### Research Integrity

**Data Integrity**:
- **Fabrication prevention**: [How to ensure data is genuine]
- **Falsification prevention**: [Accurate representation of data]
- **Plagiarism prevention**: [Proper citation, originality checks]

**Authorship**: [If collaborative, authorship criteria and order]

## Timeline & Phases

### Phase 0: Research Design & Preparation

**Duration**: [estimate - e.g., 1-2 weeks]

**Key Activities**:
- Finalize research questions
- Complete methodology design
- Develop data collection instruments
- Obtain ethics approval (if required)
- Set up tools and systems

**Milestones**:
- [ ] Research design document complete
- [ ] Ethics approval obtained (if required)
- [ ] Data collection instruments ready
- [ ] Systems and tools configured

**Dependencies**: [Must complete before Phase 1]

### Phase 1: Literature Review & Secondary Source Analysis

**Duration**: [estimate - e.g., 2-4 weeks]

**Key Activities**:
- Execute search strategy across databases
- Screen and select relevant sources
- Read and take notes on selected sources
- Begin initial synthesis and theme identification
- Update bibliography continuously

**Milestones**:
- [ ] Initial literature search complete ([n] sources identified)
- [ ] Screening process complete ([n] sources selected)
- [ ] Reading and note-taking complete
- [ ] Initial themes and gaps identified
- [ ] Literature review draft complete

**Outputs**:
- `specs/[###-topic]/literature-review.md`
- Updated `data/references/bibliography.bib`
- Reading notes in `data/notes/`

**Dependencies**: [Influences Phase 2 approach]

### Phase 2: Primary Data Collection

> **Complete only if conducting original data collection**

**Duration**: [estimate - e.g., 3-6 weeks]

**Key Activities**:
- Recruit participants (if applicable)
- Conduct interviews/surveys/experiments
- Collect and organize data
- Perform ongoing quality checks
- Maintain research journal

**Milestones**:
- [ ] Recruitment target achieved ([n] participants)
- [ ] Data collection [X]% complete
- [ ] Data collection 100% complete
- [ ] Initial data organization complete
- [ ] Quality checks passed

**Outputs**:
- Raw data in `data/raw/` or `data/primary/raw/`
- Research journal entries
- Initial field notes or memos

**Dependencies**: [Must complete before Phase 3 analysis]

### Phase 3: Data Analysis

**Duration**: [estimate - e.g., 2-4 weeks]

**Key Activities**:
- Process and prepare data for analysis
- Apply analytical techniques
- Code data (if qualitative)
- Run statistical tests (if quantitative)
- Identify patterns, themes, or significant findings
- Iterative refinement of analysis

**Milestones**:
- [ ] Data processing complete
- [ ] Initial analysis complete
- [ ] Coding/statistical analysis complete
- [ ] Preliminary findings identified
- [ ] Analysis quality checks complete

**Outputs**:
- Processed data in `data/processed/`
- Analysis files in `analysis/`
- Coded data and codebook (if applicable)
- Statistical outputs (if applicable)
- `specs/[###-topic]/analysis-methodology.md`

**Dependencies**: [Requires Phase 1 and Phase 2 data]

### Phase 4: Synthesis & Interpretation

**Duration**: [estimate - e.g., 1-2 weeks]

**Key Activities**:
- Synthesize findings across data sources
- Interpret findings in light of research questions
- Connect findings to existing literature
- Identify implications and applications
- Address limitations

**Milestones**:
- [ ] Cross-source synthesis complete
- [ ] Interpretation framework applied
- [ ] Connections to literature documented
- [ ] Limitations fully articulated
- [ ] Synthesis document complete

**Outputs**:
- Synthesis in `analysis/synthesis/`
- Draft findings and implications

**Dependencies**: [Requires Phase 3 complete]

### Phase 5: Writing & Reporting

**Duration**: [estimate - e.g., 2-3 weeks]

**Key Activities**:
- Draft research report/paper
- Create visualizations and tables
- Write discussion and conclusions
- Revise and edit
- Prepare for submission/presentation

**Milestones**:
- [ ] First draft complete
- [ ] Peer review (internal or external)
- [ ] Revisions complete
- [ ] Final formatting complete
- [ ] Submission/presentation ready

**Outputs**:
- Final research report/paper
- Supplementary materials
- Presentation (if applicable)

**Dependencies**: [Requires all previous phases]

### Buffer & Contingency

**Buffer Time**: [e.g., 10-20% additional time for unexpected delays]

**Contingency Plans**:
- [If recruitment is slow...]
- [If data collection faces barriers...]
- [If analysis reveals unexpected complexity...]
- [If timeline must be compressed...]

## Limitations

### Scope Limitations

**What is NOT Covered**:
- [Aspect 1 that is out of scope]
- [Aspect 2 that is out of scope]
- [Rationale for scope boundaries]

**Geographic/Cultural Limitations**:
- [If research is limited to specific regions or cultures]
- [Impact on generalizability]

**Temporal Limitations**:
- [Time period covered]
- [Impact of studying a specific time period]

### Resource Limitations

**Time Constraints**:
- [How time limitations affect scope]
- [Activities that are compressed or eliminated]

**Budget Constraints**:
- [If limited budget affects data collection options]
- [If cannot access certain databases or sources]

**Access Limitations**:
- [Databases or sources not accessible]
- [Populations or settings not accessible]
- [Impact on research design]

**Expertise Limitations**:
- [Areas where additional expertise would be beneficial]
- [How lack of expertise is mitigated]

### Methodological Limitations

**Design Limitations**:
- [Inherent weaknesses of chosen research design]
- [Trade-offs made and their implications]
- [Why design is still appropriate despite limitations]

**Sampling Limitations** (if applicable):
- [Non-random sampling impacts]
- [Sample size limitations]
- [Representativeness concerns]

**Measurement Limitations**:
- [Validity or reliability concerns with measures]
- [Self-report biases]
- [Lack of validated instruments]

**Analytical Limitations**:
- [Subjectivity in qualitative interpretation]
- [Statistical power or assumption violations]
- [Complexity that cannot be fully captured]

### Impact of Limitations

**Threats to Validity**:
- [Internal validity concerns]
- [External validity concerns]
- [How threats are minimized]

**Generalizability**:
- [To whom or what contexts findings can be generalized]
- [Where caution is needed in applying findings]

**Alternative Explanations**:
- [Plausible alternative explanations for findings]
- [Why primary explanation is most likely]

## Validation Strategy

### Triangulation

**Data Triangulation**:
- [Multiple data sources: e.g., combining interviews, surveys, documents]
- [How different sources complement each other]

**Methodological Triangulation**:
- [Multiple methods: e.g., qualitative + quantitative]
- [How methods compensate for each other's weaknesses]

**Investigator Triangulation** (if applicable):
- [Multiple researchers analyzing same data]
- [Inter-rater reliability or consensus building]

**Theoretical Triangulation**:
- [Multiple frameworks to interpret findings]
- [How different perspectives enhance understanding]

### Member Checking

> **If conducting primary research with participants**

**Process**:
- [Sharing findings with participants for feedback]
- [How feedback will be incorporated]
- [Timeline for member checking]

### Peer Review

**Internal Review**:
- [Colleagues or advisors reviewing methodology and findings]
- [Frequency of review]

**External Review**:
- [Conference presentations for feedback]
- [Submission to peer-reviewed venues]

### Consistency Checks

**Internal Consistency**:
- [Checking that findings align across different parts of data]
- [Looking for contradictions or anomalies]
- [Revisiting original data to verify interpretations]

**Logical Consistency**:
- [Ensuring arguments are coherent]
- [Checking that conclusions follow from evidence]

**Replication** (if feasible):
- [Whether others could replicate the study]
- [Documentation quality for replication]

### Negative Case Analysis

**Disconfirming Evidence**:
- [Actively searching for evidence that contradicts emerging findings]
- [How contradictions are resolved or explained]
- [Refining interpretations based on negative cases]

### Audit Trail

**Documentation**:
- [Comprehensive record of all decisions]
- [Versions of analysis as it evolves]
- [Memos and reflections on process]

**Purpose**:
- [Allow others to follow decision-making process]
- [Enable assessment of research quality]
- [Support replication efforts]

---

**Methodology Author**: [NAME]
**Created**: [DATE]
**Last Updated**: [DATE]
**Approved By**: [If team research - supervisor/advisor name]

**Revision History**:
| Date | Changes | Author |
|------|---------|--------|
| [DATE] | Initial methodology design | [NAME] |
| [DATE] | [Description of changes] | [NAME] |
