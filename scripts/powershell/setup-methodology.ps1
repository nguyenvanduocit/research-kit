#!/usr/bin/env pwsh
# Setup methodology for a research feature

[CmdletBinding()]
param(
    [switch]$Json,
    [switch]$Help
)

$ErrorActionPreference = 'Stop'

# Show help if requested
if ($Help) {
    Write-Output "Usage: ./setup-methodology.ps1 [-Json] [-Help]"
    Write-Output "  -Json     Output results in JSON format"
    Write-Output "  -Help     Show this help message"
    exit 0
}

# Load common functions
. "$PSScriptRoot/common.ps1"

# Get all paths and variables from common functions
$paths = Get-FeaturePathsEnv

# Check if we're on a proper feature branch (only for git repos)
if (-not (Test-FeatureBranch -Branch $paths.CURRENT_BRANCH -HasGit $paths.HAS_GIT)) {
    exit 1
}

# Ensure the research directory exists
New-Item -ItemType Directory -Path $paths.FEATURE_DIR -Force | Out-Null

# Define methodology file path
$MethodologyFile = Join-Path $paths.FEATURE_DIR 'methodology.md'

# Copy methodology template if it exists
$MethodologyTemplate = Join-Path $paths.REPO_ROOT '.research/templates/methodology-template.md'
if (Test-Path $MethodologyTemplate) {
    Copy-Item $MethodologyTemplate $MethodologyFile -Force
    Write-Output "Copied methodology template to $MethodologyFile"
} else {
    Write-Warning "Methodology template not found at $MethodologyTemplate"
    # Create a basic methodology file if template doesn't exist
    New-Item -ItemType File -Path $MethodologyFile -Force | Out-Null
}

# Copy literature review template if it exists
$LiteratureReviewTemplate = Join-Path $paths.REPO_ROOT '.research/templates/literature-review-template.md'
$LiteratureReviewFile = Join-Path $paths.FEATURE_DIR 'literature-review.md'
if (Test-Path $LiteratureReviewTemplate) {
    Copy-Item $LiteratureReviewTemplate $LiteratureReviewFile -Force
    Write-Output "Copied literature review template to $LiteratureReviewFile"
} else {
    Write-Warning "Literature review template not found at $LiteratureReviewTemplate"
}

# Copy references template if it exists
$ReferencesTemplate = Join-Path $paths.REPO_ROOT '.research/templates/references.bib'
$ReferencesFile = Join-Path $paths.FEATURE_DIR 'references.bib'
if (Test-Path $ReferencesTemplate) {
    Copy-Item $ReferencesTemplate $ReferencesFile -Force
    Write-Output "Copied references template to $ReferencesFile"
} else {
    Write-Warning "References template not found at $ReferencesTemplate"
}

# Create data-sources.md placeholder (no template exists yet)
$DataSourcesFile = Join-Path $paths.FEATURE_DIR 'data-sources.md'
if (-not (Test-Path $DataSourcesFile)) {
    @'
# Data Sources

## Overview
List and describe all data sources used in this research.

## Primary Sources

### Source 1
- **Name**:
- **Type**:
- **Access Method**:
- **Relevant Variables**:
- **Quality Assessment**:
- **Limitations**:

## Secondary Sources

### Source 1
- **Name**:
- **Type**:
- **Access Method**:
- **Relevant Variables**:
- **Quality Assessment**:
- **Limitations**:

## Data Collection Methods

## Ethical Considerations

## Data Management Plan
'@ | Out-File -FilePath $DataSourcesFile -Encoding utf8 -NoNewline
    Write-Output "Created data sources file at $DataSourcesFile"
}

# Create findings.md placeholder (no template exists yet)
$FindingsFile = Join-Path $paths.FEATURE_DIR 'findings.md'
if (-not (Test-Path $FindingsFile)) {
    @'
# Research Findings

## Overview
Document key findings as they emerge during the research process.

## Preliminary Findings

## Key Results

## Unexpected Observations

## Implications

## Next Steps
'@ | Out-File -FilePath $FindingsFile -Encoding utf8 -NoNewline
    Write-Output "Created findings file at $FindingsFile"
}

# Create research-specific subdirectories
$ProtocolsDir = Join-Path $paths.FEATURE_DIR 'protocols'
$DataDir = Join-Path $paths.FEATURE_DIR 'data'
$AnalysisDir = Join-Path $paths.FEATURE_DIR 'analysis'

New-Item -ItemType Directory -Path $ProtocolsDir -Force | Out-Null
New-Item -ItemType Directory -Path $DataDir -Force | Out-Null
New-Item -ItemType Directory -Path $AnalysisDir -Force | Out-Null

Write-Output "Created research subdirectories:"
Write-Output "  - protocols/ for research protocols"
Write-Output "  - data/ for collected data"
Write-Output "  - analysis/ for analysis outputs"

# Output results
if ($Json) {
    $result = [PSCustomObject]@{
        DEFINITION_FILE = $paths.FEATURE_SPEC
        METHODOLOGY_FILE = $MethodologyFile
        LITERATURE_REVIEW = $LiteratureReviewFile
        DATA_SOURCES = $DataSourcesFile
        FINDINGS = $FindingsFile
        REFERENCES = $ReferencesFile
        RESEARCH_DIR = $paths.FEATURE_DIR
        PROTOCOLS_DIR = $ProtocolsDir
        DATA_DIR = $DataDir
        ANALYSIS_DIR = $AnalysisDir
        BRANCH = $paths.CURRENT_BRANCH
        HAS_GIT = $paths.HAS_GIT
    }
    $result | ConvertTo-Json -Compress
} else {
    Write-Output "DEFINITION_FILE: $($paths.FEATURE_SPEC)"
    Write-Output "METHODOLOGY_FILE: $MethodologyFile"
    Write-Output "LITERATURE_REVIEW: $LiteratureReviewFile"
    Write-Output "DATA_SOURCES: $DataSourcesFile"
    Write-Output "FINDINGS: $FindingsFile"
    Write-Output "REFERENCES: $ReferencesFile"
    Write-Output "RESEARCH_DIR: $($paths.FEATURE_DIR)"
    Write-Output "PROTOCOLS_DIR: $ProtocolsDir"
    Write-Output "DATA_DIR: $DataDir"
    Write-Output "ANALYSIS_DIR: $AnalysisDir"
    Write-Output "BRANCH: $($paths.CURRENT_BRANCH)"
    Write-Output "HAS_GIT: $($paths.HAS_GIT)"
}
