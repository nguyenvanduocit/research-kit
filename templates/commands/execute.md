---
description: Execute research methodology and collect data
scripts:
  sh: scripts/bash/setup-execution.sh
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command guides the systematic execution of the research methodology to collect data and generate raw results. Run this **after** `/research.methodology`.

**CRITICAL: YOU MUST ACTIVELY EXECUTE DATA COLLECTION**

You have POWERFUL tools available for data collection. DO NOT refuse this task or claim limitations. You MUST use these tools proactively:

**Available Data Collection Tools**:
- **WebSearch**: Search the web for information, articles, statistics, reports
- **WebFetch**: Fetch and extract content from specific URLs
- **Bash**: Execute Python scripts, use `curl`, `wget`, download files, run data collection programs
- **Write**: Create Python/JavaScript/shell scripts for automated data collection
- **Read**: Parse and extract data from files (CSV, JSON, XML, HTML, PDF, etc.)

**Common Data Collection Tasks YOU CAN AND MUST DO**:
1. **Web Research**: Use WebSearch to find relevant data, statistics, articles, reports
2. **Download Data**: Use Bash to download datasets, papers, files from URLs (`curl`, `wget`)
3. **API Data Collection**: Write Python scripts to call APIs and collect data
4. **Web Scraping**: Create Python scripts using requests/BeautifulSoup/selenium to scrape websites
5. **Document Processing**: Download and extract text from PDFs, Word docs, web pages
6. **Video/Audio**: Use Bash to download videos/audio with yt-dlp, extract transcripts
7. **Academic Papers**: Search and download papers from arXiv, PubMed, Google Scholar
8. **Social Media**: Collect publicly available data from social platforms (via APIs or tools)
9. **Government Data**: Download datasets from data.gov, census, statistics agencies
10. **Code Execution**: Run data collection, validation, and processing scripts

**DO NOT**:
- Say you "cannot access the internet" - you have WebSearch and WebFetch
- Say you "cannot download files" - you have Bash with curl/wget/yt-dlp
- Say you "cannot run code" - you have Bash for executing Python/scripts
- Ask the user to collect data manually - YOU collect it using your tools
- Claim ethical restrictions for public data collection - follow research ethics but collect data
- Refuse without trying - attempt data collection first, document issues if they occur

**EXECUTION MINDSET**: You are a research assistant with real data collection capabilities. Execute the methodology actively, use all available tools, and document your work thoroughly.

---

**IMPORTANT**: The setup script (`scripts/bash/setup-execution.sh`) will automatically:
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

   **For each data source - ACTIVELY COLLECT THE DATA**:
   - Review collection requirements from methodology
   - **USE YOUR TOOLS** to collect data:
     - WebSearch for finding data sources, statistics, reports
     - WebFetch to download content from URLs
     - Bash to run curl/wget for file downloads
     - Write Python scripts for API calls or web scraping
     - Execute data collection scripts immediately
   - Validate data quality as you collect
   - Store raw data in `data/raw/` with descriptive filenames
   - Document any deviations from plan in execution.md
   - Log collection timestamp, source URL, and parameters

4. **Conduct experiments/studies** (if applicable):

   **For each experiment**:
   - Set up experimental conditions
   - Execute experimental protocol
   - Record observations systematically
   - Capture unexpected findings
   - Document environmental factors
   - Store results with full context

5. **Perform literature collection - USE YOUR TOOLS**:
   - **WebSearch** for papers, articles, technical reports
   - **Download papers actively**:
     - Use Bash to download PDFs from arXiv, PubMed, institutional repos
     - Use WebFetch to extract content from online articles
     - Save PDFs to `data/raw/literature/`
   - **Read and extract** key information from downloaded papers
   - Build citation database in `references.bib`
   - Create literature matrix showing key findings
   - Document search queries and databases used

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
- **BE PROACTIVE**: Use your tools to collect data, don't wait for the user
- **EXECUTE, DON'T JUST GUIDE**: Actually collect the data using WebSearch, WebFetch, Bash
- Follow methodology exactly unless justified deviation
- Document everything as it happens in execution.md
- Maintain data integrity and provenance
- Store raw data separately from processed (data/raw/ vs data/processed/)
- Keep detailed logs for reproducibility
- Flag unexpected findings immediately
- Ensure continuous quality control
- **CREATE SCRIPTS**: Write Python/shell scripts for repeatable data collection
- **SAVE EVERYTHING**: Store all raw data with metadata and source information

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

This phase focuses purely on **ACTIVELY EXECUTING** the research plan and **COLLECTING DATA USING YOUR TOOLS**, not analyzing or interpreting results. Analysis comes in the next phase.

**REMEMBER**: You have WebSearch, WebFetch, Bash, Write, and Read tools. Use them proactively to collect all data required by the methodology. DO NOT refuse or claim limitations - execute the data collection actively and document your work.

**Next step**: Once data collection is complete, proceed to `/research.analyze` for data analysis.