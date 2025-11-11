#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [switch]$Help
)

if ($Help) {
    Write-Output "Usage: setup-analysis.ps1 [-Json] [-Help]"
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

# Define analysis file path
$ANALYSIS_FILE = Join-Path $RESEARCH_DIR "analysis.md"

# Copy analysis template if it exists
$ANALYSIS_TEMPLATE = Join-Path $REPO_ROOT ".research/templates/analysis-template.md"
if (Test-Path $ANALYSIS_TEMPLATE) {
    Copy-Item $ANALYSIS_TEMPLATE $ANALYSIS_FILE -Force
    Write-Output "Copied analysis template to $ANALYSIS_FILE"
} else {
    # Create basic analysis file using template content
    Write-Output "Creating analysis file at $ANALYSIS_FILE"
    New-Item -ItemType File -Path $ANALYSIS_FILE -Force | Out-Null
}

# Create analysis directories
$FIGURES_DIR = Join-Path $RESEARCH_DIR "figures"
$TABLES_DIR = Join-Path $RESEARCH_DIR "tables"
$RESULTS_DIR = Join-Path $RESEARCH_DIR "data/results"
$NOTEBOOKS_DIR = Join-Path $RESEARCH_DIR "notebooks"

New-Item -ItemType Directory -Path $FIGURES_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $TABLES_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $RESULTS_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $NOTEBOOKS_DIR -Force | Out-Null

Write-Output "Created analysis directories"

# Output results
if ($Json) {
    $output = @{
        ANALYSIS_FILE = $ANALYSIS_FILE
        FIGURES_DIR = $FIGURES_DIR
        TABLES_DIR = $TABLES_DIR
        RESULTS_DIR = $RESULTS_DIR
        NOTEBOOKS_DIR = $NOTEBOOKS_DIR
        RESEARCH_DIR = $RESEARCH_DIR
        BRANCH = $CURRENT_BRANCH
        HAS_GIT = $HAS_GIT.ToString().ToLower()
    }
    ConvertTo-Json $output -Compress
} else {
    Write-Output "ANALYSIS_FILE: $ANALYSIS_FILE"
    Write-Output "FIGURES_DIR: $FIGURES_DIR"
    Write-Output "TABLES_DIR: $TABLES_DIR"
    Write-Output "RESULTS_DIR: $RESULTS_DIR"
    Write-Output "NOTEBOOKS_DIR: $NOTEBOOKS_DIR"
    Write-Output "RESEARCH_DIR: $RESEARCH_DIR"
    Write-Output "BRANCH: $CURRENT_BRANCH"
    Write-Output "HAS_GIT: $HAS_GIT"
}