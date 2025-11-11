#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [switch]$Help
)

if ($Help) {
    Write-Output "Usage: setup-execution.ps1 [-Json] [-Help]"
    Write-Output "  -Json    Output results in JSON format"
    Write-Output "  -Help    Show this help message"
    exit 0
}

# Get script directory and load common functions
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir/common.ps1"

# Get paths and variables
$paths = Get-ResearchPaths
foreach ($key in $paths.Keys) {
    Set-Variable -Name $key -Value $paths[$key] -Scope Script
}

# Check if we're on a proper research branch (only for git repos)
if (-not (Check-ResearchBranch -Branch $CURRENT_BRANCH -HasGit $HAS_GIT)) {
    exit 1
}

# Ensure the research directory exists
New-Item -ItemType Directory -Path $RESEARCH_DIR -Force | Out-Null

# Define execution file path
$EXECUTION_FILE = Join-Path $RESEARCH_DIR "execution.md"

# Copy execution template if it exists
$EXECUTION_TEMPLATE = Join-Path $REPO_ROOT ".research/templates/execution-template.md"
if (Test-Path $EXECUTION_TEMPLATE) {
    Copy-Item $EXECUTION_TEMPLATE $EXECUTION_FILE -Force
    Write-Output "Copied execution template to $EXECUTION_FILE"
} else {
    # Create a basic execution file if template doesn't exist
    $executionContent = @"
# Research Execution Log

## Execution Overview
- Start Date: $(Get-Date -Format "yyyy-MM-dd")
- Status: In Progress
- Completion: 0/0 tasks

## Data Collection Progress

### Source 1: [NAME]
- Status: [Pending]
- Records Collected: 0
- Quality Score: [TBD]
- Issues: None
- Location: ``data/raw/[filename]``

## Experiment Execution

### Experiment 1: [NAME]
- Date: [TBD]
- Conditions: [TBD]
- Observations: [TBD]
- Data Location: ``data/raw/exp1/``
- Deviations: None

## Literature Collection
- Papers Reviewed: 0
- Papers Included: 0
- Search Queries Used: []
- Databases Searched: []

## Execution Issues & Resolutions

None reported.

## Next Steps

1. Begin data collection from primary sources
2. Set up experimental conditions
3. Start literature search

## Quality Metrics
- Data Completeness: 0%
- Protocol Adherence: 100%
- Time on Schedule: Yes
"@
    Set-Content -Path $EXECUTION_FILE -Value $executionContent
    Write-Output "Created execution log at $EXECUTION_FILE"
}

# Create data collection directories
$DATA_RAW_DIR = Join-Path $RESEARCH_DIR "data/raw"
$DATA_PROCESSED_DIR = Join-Path $RESEARCH_DIR "data/processed"
$LOGS_DIR = Join-Path $RESEARCH_DIR "logs"
$NOTEBOOKS_DIR = Join-Path $RESEARCH_DIR "notebooks"
$SCRIPTS_DIR = Join-Path $RESEARCH_DIR "scripts"

New-Item -ItemType Directory -Path $DATA_RAW_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $DATA_PROCESSED_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $LOGS_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $NOTEBOOKS_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $SCRIPTS_DIR -Force | Out-Null

Write-Output "Created execution directories:"
Write-Output "  - data/raw/ for raw collected data"
Write-Output "  - data/processed/ for cleaned data"
Write-Output "  - logs/ for execution logs"
Write-Output "  - notebooks/ for analysis notebooks"
Write-Output "  - scripts/ for collection scripts"

# Create initial log file
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$EXECUTION_LOG = Join-Path $LOGS_DIR "execution_$timestamp.log"
$logContent = @"
# Execution Log
Started: $(Get-Date)
Branch: $CURRENT_BRANCH
Research Dir: $RESEARCH_DIR

## Setup Complete
- Created execution tracking file
- Initialized data directories
- Ready for data collection

"@
Set-Content -Path $EXECUTION_LOG -Value $logContent
Write-Output "Created execution log at $EXECUTION_LOG"

# Create data inventory file
$DATA_INVENTORY = Join-Path $DATA_RAW_DIR "DATA_INVENTORY.md"
$inventoryContent = @"
# Data Inventory

## Raw Data Files

| File | Description | Date Collected | Size | Format | Quality Check |
|------|-------------|----------------|------|--------|---------------|
| | | | | | |

## Data Sources Summary

| Source | Total Records | Date Range | Completeness | Issues |
|--------|---------------|------------|--------------|--------|
| | | | | |

## Metadata Standards
- All files should include collection timestamp
- Document any preprocessing applied
- Note collection parameters and conditions
- Include data dictionary for variables
"@
Set-Content -Path $DATA_INVENTORY -Value $inventoryContent
Write-Output "Created data inventory at $DATA_INVENTORY"

# Output results
if ($Json) {
    $output = @{
        EXECUTION_FILE = $EXECUTION_FILE
        DATA_RAW_DIR = $DATA_RAW_DIR
        DATA_PROCESSED_DIR = $DATA_PROCESSED_DIR
        LOGS_DIR = $LOGS_DIR
        NOTEBOOKS_DIR = $NOTEBOOKS_DIR
        SCRIPTS_DIR = $SCRIPTS_DIR
        EXECUTION_LOG = $EXECUTION_LOG
        DATA_INVENTORY = $DATA_INVENTORY
        RESEARCH_DIR = $RESEARCH_DIR
        BRANCH = $CURRENT_BRANCH
        HAS_GIT = $HAS_GIT.ToString().ToLower()
    }
    ConvertTo-Json $output -Compress
} else {
    Write-Output "EXECUTION_FILE: $EXECUTION_FILE"
    Write-Output "DATA_RAW_DIR: $DATA_RAW_DIR"
    Write-Output "DATA_PROCESSED_DIR: $DATA_PROCESSED_DIR"
    Write-Output "LOGS_DIR: $LOGS_DIR"
    Write-Output "NOTEBOOKS_DIR: $NOTEBOOKS_DIR"
    Write-Output "SCRIPTS_DIR: $SCRIPTS_DIR"
    Write-Output "EXECUTION_LOG: $EXECUTION_LOG"
    Write-Output "DATA_INVENTORY: $DATA_INVENTORY"
    Write-Output "RESEARCH_DIR: $RESEARCH_DIR"
    Write-Output "BRANCH: $CURRENT_BRANCH"
    Write-Output "HAS_GIT: $HAS_GIT"
}