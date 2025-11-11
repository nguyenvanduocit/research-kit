#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [switch]$Help,
    [string]$Type = "report"
)

if ($Help) {
    Write-Output "Usage: setup-publish.ps1 [-Json] [-Type TYPE] [-Help]"
    Write-Output "  -Json    Output results in JSON format"
    Write-Output "  -Type    Publication type (report|paper|presentation|brief)"
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

# Create publications directory structure
$PUBLICATIONS_DIR = Join-Path $RESEARCH_DIR "publications"
$REPORT_DIR = Join-Path $PUBLICATIONS_DIR "report"
$PAPER_DIR = Join-Path $PUBLICATIONS_DIR "paper"
$PRESENTATION_DIR = Join-Path $PUBLICATIONS_DIR "presentation"
$BRIEF_DIR = Join-Path $PUBLICATIONS_DIR "brief"

New-Item -ItemType Directory -Path $REPORT_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $PAPER_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $PRESENTATION_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $BRIEF_DIR -Force | Out-Null

Write-Output "Created publication directories"

# Create publication based on type
switch ($Type) {
    "report" {
        $REPORT_FILE = Join-Path $REPORT_DIR "research_report.md"
        New-Item -ItemType File -Path $REPORT_FILE -Force | Out-Null
        Write-Output "Created research report template at $REPORT_FILE"
    }
    "paper" {
        $PAPER_FILE = Join-Path $PAPER_DIR "manuscript.md"
        $COVER_LETTER = Join-Path $PAPER_DIR "cover_letter.md"
        New-Item -ItemType File -Path $PAPER_FILE -Force | Out-Null
        New-Item -ItemType File -Path $COVER_LETTER -Force | Out-Null
        Write-Output "Created academic paper template at $PAPER_FILE"
    }
    "presentation" {
        $SLIDES_FILE = Join-Path $PRESENTATION_DIR "slides.md"
        New-Item -ItemType File -Path $SLIDES_FILE -Force | Out-Null
        Write-Output "Created presentation template at $SLIDES_FILE"
    }
    "brief" {
        $BRIEF_FILE = Join-Path $BRIEF_DIR "executive_brief.md"
        New-Item -ItemType File -Path $BRIEF_FILE -Force | Out-Null
        Write-Output "Created executive brief template at $BRIEF_FILE"
    }
    default {
        Write-Output "Unknown publication type: $Type. Using default (report)"
    }
}

# Create figures and assets directories
$PUBLICATION_FIGURES = Join-Path $PUBLICATIONS_DIR "figures"
$PUBLICATION_TABLES = Join-Path $PUBLICATIONS_DIR "tables"
$PUBLICATION_ASSETS = Join-Path $PUBLICATIONS_DIR "assets"

New-Item -ItemType Directory -Path $PUBLICATION_FIGURES -Force | Out-Null
New-Item -ItemType Directory -Path $PUBLICATION_TABLES -Force | Out-Null
New-Item -ItemType Directory -Path $PUBLICATION_ASSETS -Force | Out-Null

# Copy existing figures if they exist
$RESEARCH_FIGURES = Join-Path $RESEARCH_DIR "figures"
if (Test-Path $RESEARCH_FIGURES) {
    Write-Output "Copying existing figures to publications..."
    Copy-Item "$RESEARCH_FIGURES/*" $PUBLICATION_FIGURES -Recurse -Force -ErrorAction SilentlyContinue
}

# Copy existing tables if they exist
$RESEARCH_TABLES = Join-Path $RESEARCH_DIR "tables"
if (Test-Path $RESEARCH_TABLES) {
    Write-Output "Copying existing tables to publications..."
    Copy-Item "$RESEARCH_TABLES/*" $PUBLICATION_TABLES -Recurse -Force -ErrorAction SilentlyContinue
}

# Output results
if ($Json) {
    $output = @{
        PUBLICATIONS_DIR = $PUBLICATIONS_DIR
        REPORT_DIR = $REPORT_DIR
        PAPER_DIR = $PAPER_DIR
        PRESENTATION_DIR = $PRESENTATION_DIR
        BRIEF_DIR = $BRIEF_DIR
        PUBLICATION_TYPE = $Type
        RESEARCH_DIR = $RESEARCH_DIR
        BRANCH = $CURRENT_BRANCH
        HAS_GIT = $HAS_GIT.ToString().ToLower()
    }
    ConvertTo-Json $output -Compress
} else {
    Write-Output "PUBLICATIONS_DIR: $PUBLICATIONS_DIR"
    Write-Output "REPORT_DIR: $REPORT_DIR"
    Write-Output "PAPER_DIR: $PAPER_DIR"
    Write-Output "PRESENTATION_DIR: $PRESENTATION_DIR"
    Write-Output "BRIEF_DIR: $BRIEF_DIR"
    Write-Output "PUBLICATION_TYPE: $Type"
    Write-Output "RESEARCH_DIR: $RESEARCH_DIR"
    Write-Output "BRANCH: $CURRENT_BRANCH"
    Write-Output "HAS_GIT: $HAS_GIT"
}