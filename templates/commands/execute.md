---
description: Execute research methodology and collect data
scripts:
  sh: scripts/bash/setup-execution.sh
  ps: scripts/powershell/setup-execution.ps1
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command guides the systematic execution of the research methodology to collect data and generate raw results. Run this **after** `/research.methodology`.

**IMPORTANT**: The setup script (`scripts/bash/setup-execution.sh` or `scripts/powershell/setup-execution.ps1`) will automatically:
- Create all necessary directories (`data/raw/`, `data/processed/`, `logs/`, `notebooks/`, `scripts/`)
- Initialize execution tracking file (`execution.md`)
- Create data inventory template
- Verify prerequisite phases have been completed

**DO NOT manually create these directories or files - let the script handle it!**

1. **Load research context**:
   - Research definition from `research/###-topic-name/definition.md`
   - Methodology from `research/###-topic-name/methodology.md`
   - Existing execution log if present

2. **Initialize execution tracking**:
   - Create/update `research/###-topic-name/execution.md`
   - Set up data collection directories:
     - `research/###-topic-name/data/raw/` - raw collected data
     - `research/###-topic-name/data/processed/` - cleaned/formatted data
     - `research/###-topic-name/logs/` - execution logs
     - `research/###-topic-name/notebooks/` - analysis notebooks

3. **Execute data collection plan** (from methodology):

   **For each data source**:
   - Review collection requirements
   - Execute collection procedure
   - Validate data quality immediately
   - Store raw data with metadata
   - Document any deviations from plan
   - Log collection timestamp and parameters

4. **Conduct experiments/studies** (if applicable):

   **For each experiment**:
   - Set up experimental conditions
   - Execute experimental protocol
   - Record observations systematically
   - Capture unexpected findings
   - Document environmental factors
   - Store results with full context

5. **Perform literature collection**:
   - Search academic databases
   - Download relevant papers
   - Extract key information
   - Build citation database
   - Create literature matrix
   - Update `references.bib` continuously

6. **Quality control during execution**:
   - Verify data completeness
   - Check for collection errors
   - Validate against methodology requirements
   - Ensure ethical compliance
   - Monitor resource usage
   - Track time expenditure

7. **Document execution progress**:

   Update `execution.md` with:
   ```markdown
   # Research Execution Log

   ## Execution Overview
   - Start Date: [DATE]
   - Status: [In Progress/Complete]
   - Completion: [X/Y tasks]

   ## Data Collection Progress

   ### Source 1: [NAME]
   - Status: [Collected/Pending/Failed]
   - Records Collected: [N]
   - Quality Score: [1-10]
   - Issues: [Any problems]
   - Location: `data/raw/[filename]`

   ## Experiment Execution

   ### Experiment 1: [NAME]
   - Date: [DATE]
   - Conditions: [Details]
   - Observations: [Key findings]
   - Data Location: `data/raw/exp1/`
   - Deviations: [Any protocol changes]

   ## Literature Collection
   - Papers Reviewed: [N]
   - Papers Included: [N]
   - Search Queries Used: [List]
   - Databases Searched: [List]

   ## Execution Issues & Resolutions

   ## Next Steps
   ```

8. **Generate execution artifacts**:
   - Data collection scripts (`scripts/collect_*.py`)
   - Data validation reports (`logs/validation_*.log`)
   - Execution timeline (`logs/timeline.md`)
   - Resource usage report
   - Issue tracking log

9. **Prepare for analysis phase**:
   - Organize raw data by type
   - Create data inventory
   - Document data formats
   - Generate data dictionary
   - Prepare analysis environment
   - Create initial notebooks

10. **Output execution summary**:
    - Total data points collected
    - Experiments completed
    - Literature items gathered
    - Execution time elapsed
    - Issues encountered and resolved
    - Data quality assessment
    - Readiness for analysis phase

**Execution Principles**:
- Follow methodology exactly unless justified deviation
- Document everything as it happens
- Maintain data integrity and provenance
- Store raw data separately from processed
- Keep detailed logs for reproducibility
- Flag unexpected findings immediately
- Ensure continuous quality control

**Common Execution Challenges**:
- Data source unavailability → Document and find alternatives
- Protocol deviations → Record reasons and impacts
- Quality issues → Flag for analysis phase consideration
- Resource constraints → Prioritize critical data
- Time overruns → Focus on primary research questions
- Technical failures → Maintain backup procedures

**Data Organization Standards**:
- Use consistent naming conventions
- Include metadata with all data files
- Maintain version control for scripts
- Create README files in data directories
- Use standard formats (CSV, JSON, etc.)
- Implement data validation checks
- Ensure backup of all raw data

This phase focuses purely on EXECUTING the research plan and COLLECTING data, not analyzing or interpreting results. Analysis comes in the next phase.