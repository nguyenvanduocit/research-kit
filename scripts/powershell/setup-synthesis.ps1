#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [switch]$Help
)

if ($Help) {
    Write-Output "Usage: setup-synthesis.ps1 [-Json] [-Help]"
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

# Check phase dependencies - synthesis requires analysis to be completed first
$ANALYSIS_FILE = Join-Path $RESEARCH_DIR "analysis.md"
if (-not (Test-Path $ANALYSIS_FILE)) {
    Write-Error "Error: analysis.md not found in $RESEARCH_DIR"
    Write-Output "Please run /research.analyze before running /research.synthesize"
    Write-Output ""
    Write-Output "The research workflow phases must be completed in order:"
    Write-Output "  1. /research.define - Define research question"
    Write-Output "  2. /research.methodology - Design methodology"
    Write-Output "  3. /research.execute - Collect data"
    Write-Output "  4. /research.analyze - Analyze data"
    Write-Output "  5. /research.synthesize - Draw conclusions (current step)"
    Write-Output "  6. /research.publish - Create outputs"
    exit 1
}

# Also check for execution.md to ensure proper workflow
$EXECUTION_FILE = Join-Path $RESEARCH_DIR "execution.md"
if (-not (Test-Path $EXECUTION_FILE)) {
    Write-Warning "Warning: execution.md not found - workflow may be incomplete"
}

# Define synthesis file path
$SYNTHESIS_FILE = Join-Path $RESEARCH_DIR "synthesis.md"

# Copy synthesis template if it exists
$SYNTHESIS_TEMPLATE = Join-Path $REPO_ROOT ".research/templates/synthesis-template.md"
if (Test-Path $SYNTHESIS_TEMPLATE) {
    Copy-Item $SYNTHESIS_TEMPLATE $SYNTHESIS_FILE -Force
    Write-Output "Copied synthesis template to $SYNTHESIS_FILE"
} else {
    # Create basic synthesis file
    Write-Output "Creating synthesis file at $SYNTHESIS_FILE"
    New-Item -ItemType File -Path $SYNTHESIS_FILE -Force | Out-Null
}

# Create synthesis support directories
$MODELS_DIR = Join-Path $RESEARCH_DIR "models"
$SYNTHESIS_FIGURES_DIR = Join-Path $RESEARCH_DIR "figures/synthesis"
$BRIEFS_DIR = Join-Path $RESEARCH_DIR "briefs"

New-Item -ItemType Directory -Path $MODELS_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $SYNTHESIS_FIGURES_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $BRIEFS_DIR -Force | Out-Null

Write-Output "Created synthesis directories"

# Output results
if ($Json) {
    $output = @{
        SYNTHESIS_FILE = $SYNTHESIS_FILE
        MODELS_DIR = $MODELS_DIR
        SYNTHESIS_FIGURES_DIR = $SYNTHESIS_FIGURES_DIR
        BRIEFS_DIR = $BRIEFS_DIR
        RESEARCH_DIR = $RESEARCH_DIR
        BRANCH = $CURRENT_BRANCH
        HAS_GIT = $HAS_GIT.ToString().ToLower()
    }
    ConvertTo-Json $output -Compress
} else {
    Write-Output "SYNTHESIS_FILE: $SYNTHESIS_FILE"
    Write-Output "MODELS_DIR: $MODELS_DIR"
    Write-Output "SYNTHESIS_FIGURES_DIR: $SYNTHESIS_FIGURES_DIR"
    Write-Output "BRIEFS_DIR: $BRIEFS_DIR"
    Write-Output "RESEARCH_DIR: $RESEARCH_DIR"
    Write-Output "BRANCH: $CURRENT_BRANCH"
    Write-Output "HAS_GIT: $HAS_GIT"
}