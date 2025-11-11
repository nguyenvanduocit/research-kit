#!/usr/bin/env pwsh

# Consolidated prerequisite checking script (PowerShell)
#
# This script provides unified prerequisite checking for Research Kit workflow.
# It replaces the functionality previously spread across multiple scripts.
#
# Usage: ./check-prerequisites.ps1 [OPTIONS]
#
# OPTIONS:
#   -Json               Output in JSON format
#   -RequireTasks       Require tasks.md to exist (for execution phase)
#   -IncludeTasks       Include tasks.md in AVAILABLE_DOCS list
#   -PathsOnly          Only output path variables (no validation)
#   -Help, -h           Show help message

[CmdletBinding()]
param(
    [switch]$Json,
    [switch]$RequireTasks,
    [switch]$IncludeTasks,
    [switch]$PathsOnly,
    [switch]$Help
)

$ErrorActionPreference = 'Stop'

# Show help if requested
if ($Help) {
    Write-Output @"
Usage: check-prerequisites.ps1 [OPTIONS]

Consolidated prerequisite checking for Research Kit workflow.

OPTIONS:
  -Json               Output in JSON format
  -RequireTasks       Require tasks.md to exist (for execution phase)
  -IncludeTasks       Include tasks.md in AVAILABLE_DOCS list
  -PathsOnly          Only output path variables (no prerequisite validation)
  -Help, -h           Show this help message

EXAMPLES:
  # Check task prerequisites (methodology.md required)
  .\check-prerequisites.ps1 -Json

  # Check execution prerequisites (methodology.md + tasks.md required)
  .\check-prerequisites.ps1 -Json -RequireTasks -IncludeTasks

  # Get research paths only (no validation)
  .\check-prerequisites.ps1 -PathsOnly

"@
    exit 0
}

# Source common functions
. "$PSScriptRoot/common.ps1"

# Get research paths and validate branch
$paths = Get-ResearchPathsEnv

if (-not (Test-ResearchBranch -Branch $paths.CURRENT_BRANCH -HasGit:$paths.HAS_GIT)) {
    exit 1
}

# If paths-only mode, output paths and exit (support combined -Json -PathsOnly)
if ($PathsOnly) {
    if ($Json) {
        [PSCustomObject]@{
            REPO_ROOT           = $paths.REPO_ROOT
            BRANCH              = $paths.CURRENT_BRANCH
            RESEARCH_DIR        = $paths.RESEARCH_DIR
            RESEARCH_DEFINITION = $paths.RESEARCH_DEFINITION
            METHODOLOGY         = $paths.METHODOLOGY
            TASKS               = $paths.TASKS
        } | ConvertTo-Json -Compress
    } else {
        Write-Output "REPO_ROOT: $($paths.REPO_ROOT)"
        Write-Output "BRANCH: $($paths.CURRENT_BRANCH)"
        Write-Output "RESEARCH_DIR: $($paths.RESEARCH_DIR)"
        Write-Output "RESEARCH_DEFINITION: $($paths.RESEARCH_DEFINITION)"
        Write-Output "METHODOLOGY: $($paths.METHODOLOGY)"
        Write-Output "TASKS: $($paths.TASKS)"
    }
    exit 0
}

# Validate required directories and files
if (-not (Test-Path $paths.RESEARCH_DIR -PathType Container)) {
    Write-Output "ERROR: Research directory not found: $($paths.RESEARCH_DIR)"
    Write-Output "Run /researchkit.define first to create the research structure."
    exit 1
}

if (-not (Test-Path $paths.METHODOLOGY -PathType Leaf)) {
    Write-Output "ERROR: methodology.md not found in $($paths.RESEARCH_DIR)"
    Write-Output "Run /researchkit.methodology first to create the research methodology."
    exit 1
}

# Check for tasks.md if required
if ($RequireTasks -and -not (Test-Path $paths.TASKS -PathType Leaf)) {
    Write-Output "ERROR: tasks.md not found in $($paths.RESEARCH_DIR)"
    Write-Output "Run /researchkit.tasks first to create the task list."
    exit 1
}

# Build list of available documents
$docs = @()

# Always check these optional docs
if (Test-Path $paths.LITERATURE_REVIEW) { $docs += 'literature-review.md' }
if (Test-Path $paths.DATA_ANALYSIS) { $docs += 'data-analysis.md' }

# Check references directory (only if it exists and has files)
if ((Test-Path $paths.REFERENCES_DIR) -and (Get-ChildItem -Path $paths.REFERENCES_DIR -ErrorAction SilentlyContinue | Select-Object -First 1)) {
    $docs += 'references/'
}

if (Test-Path $paths.REFERENCES_BIB) { $docs += 'references.bib' }
if (Test-Path $paths.QUICKSTART) { $docs += 'quickstart.md' }

# Include tasks.md if requested and it exists
if ($IncludeTasks -and (Test-Path $paths.TASKS)) {
    $docs += 'tasks.md'
}

# Output results
if ($Json) {
    # JSON output
    [PSCustomObject]@{
        RESEARCH_DIR = $paths.RESEARCH_DIR
        AVAILABLE_DOCS = $docs
    } | ConvertTo-Json -Compress
} else {
    # Text output
    Write-Output "RESEARCH_DIR:$($paths.RESEARCH_DIR)"
    Write-Output "AVAILABLE_DOCS:"

    # Show status of each potential document
    Test-FileExists -Path $paths.LITERATURE_REVIEW -Description 'literature-review.md' | Out-Null
    Test-FileExists -Path $paths.DATA_ANALYSIS -Description 'data-analysis.md' | Out-Null
    Test-DirHasFiles -Path $paths.REFERENCES_DIR -Description 'references/' | Out-Null
    Test-FileExists -Path $paths.REFERENCES_BIB -Description 'references.bib' | Out-Null
    Test-FileExists -Path $paths.QUICKSTART -Description 'quickstart.md' | Out-Null

    if ($IncludeTasks) {
        Test-FileExists -Path $paths.TASKS -Description 'tasks.md' | Out-Null
    }
}
