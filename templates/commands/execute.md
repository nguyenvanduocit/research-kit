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

**CRITICAL: Download Sources & Cite with file:line**

- **NEVER cite a URL directly** - Always download content locally first
- **Use markitdown** to convert web content: `markitdown "URL" > sources/web/filename.md`
- **Read local files** - Always read from `sources/` folder, not from web
- **Cite with file:line** - Every insight/evidence MUST cite `sources/path/file.md:line`

**Available Data Collection Tools**:
- **WebSearch**: Search the web to find URLs for articles, statistics, reports
- **Bash**: Run `markitdown` to download content, curl, wget, Python scripts
- **Write**: Create collection scripts, save downloaded content
- **Read**: Parse downloaded LOCAL files (CSV, JSON, XML, HTML, PDF, etc.)

**Common Data Collection Tasks YOU CAN AND MUST DO**:
1. **Web Research**: Use WebSearch to find relevant URLs, then download with markitdown
2. **Download Content**: Use `markitdown "URL" > sources/web/filename.md` to save web content locally
3. **Download Data**: Use Bash with curl/wget for datasets, markitdown for articles
4. **API Data Collection**: Write Python scripts to call APIs and collect data
5. **Web Scraping**: Create Python scripts using requests/BeautifulSoup/selenium
6. **Document Processing**: Use markitdown to extract text from PDFs, web pages
7. **Video/Audio**: Use Bash to download videos/audio with yt-dlp, extract transcripts
8. **Academic Papers**: Search and download papers using markitdown to `sources/papers/`
9. **Government Data**: Download datasets from data.gov, census, statistics agencies
10. **Code Execution**: Run data collection, validation, and processing scripts

**Source Download Workflow**:
```bash
# 1. Find source with WebSearch
# 2. Download with markitdown
markitdown "https://example.com/article" > sources/web/article-name.md
# 3. Read local file
# 4. Cite with file:line format: sources/web/article-name.md:45
```

**DO NOT**:
- **CITE URLs DIRECTLY** - ALWAYS download first, then cite file:line
- Say you "cannot access the internet" - you have WebSearch
- Say you "cannot download files" - you have markitdown and curl/wget
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
     - `research/###-topic-name/sources/web/` - downloaded web articles (markitdown)
     - `research/###-topic-name/sources/papers/` - downloaded academic papers
     - `research/###-topic-name/sources/reports/` - downloaded reports

3. **Execute data collection plan** (from methodology):

   **For each data source - ACTIVELY COLLECT THE DATA**:
   - Review collection requirements from methodology
   - **USE YOUR TOOLS** to collect data:
     - WebSearch for finding URLs to data sources, articles, reports
     - **markitdown to download web content**: `markitdown "URL" > sources/web/filename.md`
     - Bash to run curl/wget for binary file downloads
     - Write Python scripts for API calls or web scraping
     - Execute data collection scripts immediately
   - **Read downloaded local files** - NEVER read from web directly
   - Validate data quality as you collect
   - Store raw data in `data/raw/` with descriptive filenames
   - **Store downloaded sources in `sources/`** with markitdown
   - **Update `sources/SOURCES_INDEX.md`** with all downloads
   - Document any deviations from plan in execution.md
   - **Cite all findings with file:line format**: `sources/web/article.md:45`

4. **Conduct experiments/studies** (if applicable):

   **For each experiment**:
   - Set up experimental conditions
   - Execute experimental protocol
   - Record observations systematically
   - Capture unexpected findings
   - Document environmental factors
   - Store results with full context

5. **Perform literature collection - DOWNLOAD BEFORE CITING**:
   - **WebSearch** to find papers, articles, technical reports
   - **Download ALL sources locally with markitdown**:
     ```bash
     # Academic papers
     markitdown "https://arxiv.org/abs/2301.00001" > sources/papers/author-year-title.md

     # Web articles
     markitdown "https://example.com/article" > sources/web/article-name.md

     # Reports
     markitdown "https://example.com/report.pdf" > sources/reports/report-name.md
     ```
   - **Read downloaded local files** - NEVER read from web directly
   - **Extract key information with file:line citations**
   - Update `sources/SOURCES_INDEX.md` with all downloads
   - Build citation database in `references.bib` with localfile field
   - Create literature matrix showing key findings with file:line citations
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

   ## Downloaded Sources (with file:line citations)

   ### Web Articles
   | File | Original URL | Key Findings |
   |------|--------------|--------------|
   | sources/web/article.md | https://... | Finding (sources/web/article.md:45) |

   ### Papers
   | File | DOI/URL | Key Findings |
   |------|---------|--------------|
   | sources/papers/smith-2024.md | https://... | Finding (sources/papers/smith-2024.md:78) |

   ## Experiment Execution

   ### Experiment 1: [NAME]
   - Date: [DATE]
   - Conditions: [Details]
   - Observations: [Key findings with file:line citations]
   - Data Location: `data/raw/exp1/`
   - Deviations: [Any protocol changes]

   ## Literature Collection
   - Papers Downloaded: [N]
   - Papers Reviewed: [N]
   - Papers Included: [N]
   - Sources Index: `sources/SOURCES_INDEX.md`
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
- **DOWNLOAD BEFORE CITING**: Use markitdown to save ALL web content locally
- **CITE WITH file:line**: Every insight MUST reference `sources/path/file.md:line`
- **NEVER CITE URLs DIRECTLY**: Always download first, then cite local file
- **BE PROACTIVE**: Use your tools to collect data, don't wait for the user
- **EXECUTE, DON'T JUST GUIDE**: Actually collect data using WebSearch + markitdown + Bash
- Follow methodology exactly unless justified deviation
- Document everything as it happens in execution.md
- Maintain data integrity and provenance
- Store raw data separately from processed (data/raw/ vs data/processed/)
- Store downloaded sources in `sources/` folder
- Keep detailed logs for reproducibility
- Flag unexpected findings immediately
- Ensure continuous quality control
- **CREATE SCRIPTS**: Write Python/shell scripts for repeatable data collection
- **SAVE EVERYTHING**: Store all raw data with metadata and source information
- **UPDATE SOURCES INDEX**: Track all downloads in `sources/SOURCES_INDEX.md`

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

**REMEMBER**: You have WebSearch, markitdown, Bash, Write, and Read tools. Use them proactively to collect all data required by the methodology. DO NOT refuse or claim limitations - execute the data collection actively and document your work.

**CRITICAL CITATION RULES**:
1. **Find URL** → WebSearch to find relevant sources
2. **Download locally** → `markitdown "URL" > sources/web/filename.md`
3. **Read local file** → Use Read tool on downloaded file
4. **Cite with file:line** → `(sources/web/filename.md:45-48)`

**NEVER DO THIS**: `According to https://example.com/article...` ❌
**ALWAYS DO THIS**: `According to the analysis (sources/web/article.md:45)...` ✓

**Specialized agents**: Use `@agent-data-collector` for complex scraping/API tasks. Use `@agent-literature-specialist` for systematic source discovery.

**Next step**: Once data collection is complete, proceed to `/research.analyze` for data analysis.