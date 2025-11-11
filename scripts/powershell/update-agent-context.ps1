#!/usr/bin/env pwsh
<#!
.SYNOPSIS
Update agent context files with information from methodology.md (PowerShell version)

.DESCRIPTION
Mirrors the behavior of scripts/bash/update-agent-context.sh:
 1. Environment Validation
 2. Methodology Data Extraction (research-specific)
 3. Agent File Management (create from template or update existing)
 4. Content Generation (research description, active research activities, recent findings)
 5. Multi-Agent Support (claude, gemini, copilot, cursor-agent, qwen, opencode, codex, windsurf, kilocode, auggie, roo, amp, q)

.PARAMETER AgentType
Optional agent key to update a single agent. If omitted, updates all existing agent files (creating a default Claude file if none exist).

.EXAMPLE
./update-agent-context.ps1 -AgentType claude

.EXAMPLE
./update-agent-context.ps1   # Updates all existing agent files

.NOTES
Relies on common helper functions in common.ps1
#>
param(
    [Parameter(Position=0)]
    [ValidateSet('claude','gemini','copilot','cursor-agent','qwen','opencode','codex','windsurf','kilocode','auggie','roo','codebuddy','amp','q')]
    [string]$AgentType
)

$ErrorActionPreference = 'Stop'

# Import common helpers
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $ScriptDir 'common.ps1')

# Acquire environment paths
$envData = Get-FeaturePathsEnv
$REPO_ROOT     = $envData.REPO_ROOT
$CURRENT_BRANCH = $envData.CURRENT_BRANCH
$HAS_GIT       = $envData.HAS_GIT
$IMPL_PLAN     = $envData.IMPL_PLAN
$NEW_METHODOLOGY = $IMPL_PLAN

# Agent file paths
$CLAUDE_FILE   = Join-Path $REPO_ROOT 'CLAUDE.md'
$GEMINI_FILE   = Join-Path $REPO_ROOT 'GEMINI.md'
$COPILOT_FILE  = Join-Path $REPO_ROOT '.github/copilot-instructions.md'
$CURSOR_FILE   = Join-Path $REPO_ROOT '.cursor/rules/research-rules.mdc'
$QWEN_FILE     = Join-Path $REPO_ROOT 'QWEN.md'
$AGENTS_FILE   = Join-Path $REPO_ROOT 'AGENTS.md'
$WINDSURF_FILE = Join-Path $REPO_ROOT '.windsurf/rules/research-rules.md'
$KILOCODE_FILE = Join-Path $REPO_ROOT '.kilocode/rules/research-rules.md'
$AUGGIE_FILE   = Join-Path $REPO_ROOT '.augment/rules/research-rules.md'
$ROO_FILE      = Join-Path $REPO_ROOT '.roo/rules/research-rules.md'
$CODEBUDDY_FILE = Join-Path $REPO_ROOT 'CODEBUDDY.md'
$AMP_FILE      = Join-Path $REPO_ROOT 'AGENTS.md'
$Q_FILE        = Join-Path $REPO_ROOT 'AGENTS.md'

$TEMPLATE_FILE = Join-Path $REPO_ROOT '.research/templates/agent-file-template.md'

# Parsed methodology data placeholders
$script:NEW_RESEARCH_TYPE = ''
$script:NEW_RESEARCH_QUESTIONS = ''
$script:NEW_METHODS = ''
$script:NEW_DATA_SOURCES = ''

function Write-Info {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message
    )
    Write-Host "INFO: $Message"
}

function Write-Success {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message
    )
    Write-Host "$([char]0x2713) $Message"
}

function Write-WarningMsg {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message
    )
    Write-Warning $Message
}

function Write-Err {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message
    )
    Write-Host "ERROR: $Message" -ForegroundColor Red
}

function Validate-Environment {
    if (-not $CURRENT_BRANCH) {
        Write-Err 'Unable to determine current research topic'
        if ($HAS_GIT) { Write-Info "Make sure you're on a research topic branch" } else { Write-Info 'Set RESEARCH_TOPIC environment variable or create a research topic first' }
        exit 1
    }
    if (-not (Test-Path $NEW_METHODOLOGY)) {
        Write-Err "No methodology.md found at $NEW_METHODOLOGY"
        Write-Info 'Make sure you are working on a research topic with a corresponding research directory'
        if (-not $HAS_GIT) { Write-Info 'Use: $env:RESEARCH_TOPIC=your-topic-name or create a new research topic first' }
        exit 1
    }
    if (-not (Test-Path $TEMPLATE_FILE)) {
        Write-WarningMsg "Template file not found at $TEMPLATE_FILE"
        Write-WarningMsg 'Creating new agent files will fail'
    }
}

function Extract-MethodologyField {
    param(
        [Parameter(Mandatory=$true)]
        [string]$FieldPattern,
        [Parameter(Mandatory=$true)]
        [string]$MethodologyFile
    )
    if (-not (Test-Path $MethodologyFile)) { return '' }
    # Lines like **Research Type**: Academic Literature Review
    $regex = "^\*\*$([Regex]::Escape($FieldPattern))\*\*: (.+)$"
    Get-Content -LiteralPath $MethodologyFile -Encoding utf8 | ForEach-Object {
        if ($_ -match $regex) {
            $val = $Matches[1].Trim()
            if ($val -notin @('NEEDS CLARIFICATION','N/A')) { return $val }
        }
    } | Select-Object -First 1
}

function Parse-MethodologyData {
    param(
        [Parameter(Mandatory=$true)]
        [string]$MethodologyFile
    )
    if (-not (Test-Path $MethodologyFile)) { Write-Err "Methodology file not found: $MethodologyFile"; return $false }
    Write-Info "Parsing research data from $MethodologyFile"
    $script:NEW_RESEARCH_TYPE     = Extract-MethodologyField -FieldPattern 'Research Type' -MethodologyFile $MethodologyFile
    $script:NEW_RESEARCH_QUESTIONS = Extract-MethodologyField -FieldPattern 'Research Questions' -MethodologyFile $MethodologyFile
    $script:NEW_METHODS           = Extract-MethodologyField -FieldPattern 'Research Methods' -MethodologyFile $MethodologyFile
    $script:NEW_DATA_SOURCES      = Extract-MethodologyField -FieldPattern 'Data Sources' -MethodologyFile $MethodologyFile

    if ($NEW_RESEARCH_TYPE) { Write-Info "Found research type: $NEW_RESEARCH_TYPE" } else { Write-WarningMsg 'No research type information found in methodology' }
    if ($NEW_RESEARCH_QUESTIONS) { Write-Info "Found research questions: $NEW_RESEARCH_QUESTIONS" }
    if ($NEW_METHODS) { Write-Info "Found research methods: $NEW_METHODS" }
    if ($NEW_DATA_SOURCES -and $NEW_DATA_SOURCES -ne 'N/A') { Write-Info "Found data sources: $NEW_DATA_SOURCES" }
    return $true
}

function Format-ResearchDescription {
    param(
        [Parameter(Mandatory=$false)]
        [string]$ResearchType,
        [Parameter(Mandatory=$false)]
        [string]$ResearchQuestions
    )
    $parts = @()
    if ($ResearchType -and $ResearchType -ne 'NEEDS CLARIFICATION') { $parts += $ResearchType }
    if ($ResearchQuestions -and $ResearchQuestions -notin @('NEEDS CLARIFICATION','N/A')) { $parts += $ResearchQuestions }
    if (-not $parts) { return '' }
    return ($parts -join ' - ')
}

function Get-ResearchPrinciples {
    $principlesFile = Join-Path $REPO_ROOT 'principles/research-principles.md'
    if ((Test-Path $principlesFile)) {
        try {
            # Extract first 5 lines after a heading as a summary
            $lines = Get-Content -LiteralPath $principlesFile -Encoding utf8
            $afterHeading = $false
            $count = 0
            $result = @()
            foreach ($line in $lines) {
                if ($line -match '^#') {
                    $afterHeading = $true
                    continue
                }
                if ($afterHeading -and $count -lt 5) {
                    $result += $line
                    $count++
                }
            }
            if ($result.Count -gt 0) {
                return ($result -join [Environment]::NewLine)
            }
        } catch {
            # Fall through to default
        }
    }
    return 'Follow rigorous research methodology and ethical guidelines'
}

function Get-ResearchActivities {
    param(
        [Parameter(Mandatory=$false)]
        [string]$ResearchType
    )
    switch -Regex ($ResearchType) {
        'Academic' { return "- Literature review in academic databases`n- Critical analysis of peer-reviewed sources`n- Synthesis of theoretical frameworks" }
        'Market' { return "- Industry report analysis`n- Competitive landscape mapping`n- Trend identification and validation" }
        'Technical' { return "- Documentation review`n- Technical feasibility assessment`n- Implementation comparison" }
        default { return "- Source identification and evaluation`n- Data collection and organization`n- Synthesis and reporting" }
    }
}

function New-AgentFile {
    param(
        [Parameter(Mandatory=$true)]
        [string]$TargetFile,
        [Parameter(Mandatory=$true)]
        [string]$ProjectName,
        [Parameter(Mandatory=$true)]
        [datetime]$Date
    )
    if (-not (Test-Path $TEMPLATE_FILE)) { Write-Err "Template not found at $TEMPLATE_FILE"; return $false }
    $temp = New-TemporaryFile
    Copy-Item -LiteralPath $TEMPLATE_FILE -Destination $temp -Force

    $researchPrinciples = Get-ResearchPrinciples
    $researchActivities = Get-ResearchActivities -ResearchType $NEW_RESEARCH_TYPE

    $escaped_type = $NEW_RESEARCH_TYPE
    $escaped_questions = $NEW_RESEARCH_QUESTIONS
    $escaped_branch = $CURRENT_BRANCH

    $content = Get-Content -LiteralPath $temp -Raw -Encoding utf8
    $content = $content -replace '\[PROJECT_NAME\]',$ProjectName
    $content = $content -replace '\[DATE\]',$Date.ToString('yyyy-MM-dd')
    $content = $content -replace '\[RESEARCH_PRINCIPLES\]',$researchPrinciples

    # Build the research description string safely
    $researchDescForTemplate = ""
    if ($escaped_type -and $escaped_questions) {
        $researchDescForTemplate = "- $escaped_type - $escaped_questions ($escaped_branch)"
    } elseif ($escaped_type) {
        $researchDescForTemplate = "- $escaped_type ($escaped_branch)"
    } elseif ($escaped_questions) {
        $researchDescForTemplate = "- $escaped_questions ($escaped_branch)"
    } else {
        $researchDescForTemplate = "- ($escaped_branch)"
    }

    $content = $content -replace '\[EXTRACTED_FROM_ALL_METHODOLOGY_FILES\]',$researchDescForTemplate
    $content = $content -replace '\[ACTIVE_RESEARCH_ACTIVITIES\]',$researchActivities

    # Build the recent research string safely
    $recentResearchForTemplate = ""
    if ($escaped_type -and $escaped_questions) {
        $recentResearchForTemplate = "- ${escaped_branch}: Completed ${escaped_type} research - ${escaped_questions}"
    } elseif ($escaped_type) {
        $recentResearchForTemplate = "- ${escaped_branch}: Completed ${escaped_type} research"
    } elseif ($escaped_questions) {
        $recentResearchForTemplate = "- ${escaped_branch}: Addressed research question - ${escaped_questions}"
    } else {
        $recentResearchForTemplate = "- ${escaped_branch}: Completed research"
    }

    $content = $content -replace '\[LAST_3_TOPICS_AND_KEY_FINDINGS\]',$recentResearchForTemplate
    # Convert literal \n sequences to actual newlines
    $content = $content -replace '`n',[Environment]::NewLine

    $parent = Split-Path -Parent $TargetFile
    if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent | Out-Null }
    Set-Content -LiteralPath $TargetFile -Value $content -NoNewline -Encoding utf8
    Remove-Item $temp -Force
    return $true
}

function Update-ExistingAgentFile {
    param(
        [Parameter(Mandatory=$true)]
        [string]$TargetFile,
        [Parameter(Mandatory=$true)]
        [datetime]$Date
    )
    if (-not (Test-Path $TargetFile)) { return (New-AgentFile -TargetFile $TargetFile -ProjectName (Split-Path $REPO_ROOT -Leaf) -Date $Date) }

    $researchDesc = Format-ResearchDescription -ResearchType $NEW_RESEARCH_TYPE -ResearchQuestions $NEW_RESEARCH_QUESTIONS
    $newResearchEntries = @()
    $newRecentEntry = ''

    # Prepare new research topic entries
    if ($researchDesc) {
        $escapedResearchDesc = [Regex]::Escape($researchDesc)
        if (-not (Select-String -Pattern $escapedResearchDesc -Path $TargetFile -Quiet)) {
            $newResearchEntries += "- $researchDesc ($CURRENT_BRANCH)"
        }
    }
    if ($NEW_METHODS -and $NEW_METHODS -notin @('N/A','NEEDS CLARIFICATION')) {
        $escapedMethods = [Regex]::Escape($NEW_METHODS)
        if (-not (Select-String -Pattern $escapedMethods -Path $TargetFile -Quiet)) {
            $newResearchEntries += "- Methods: $NEW_METHODS ($CURRENT_BRANCH)"
        }
    }

    # Prepare new recent research entry
    if ($researchDesc) {
        $newRecentEntry = "- ${CURRENT_BRANCH}: Completed ${researchDesc}"
    } elseif ($NEW_METHODS -and $NEW_METHODS -notin @('N/A','NEEDS CLARIFICATION')) {
        $newRecentEntry = "- ${CURRENT_BRANCH}: Used methods - ${NEW_METHODS}"
    }

    # Check if sections exist in the file
    $hasActiveResearch = $false
    $hasRecentResearch = $false
    $content = Get-Content -LiteralPath $TargetFile -Encoding utf8 -Raw
    if ($content -match '(?m)^## Active Research Topics') { $hasActiveResearch = $true }
    if ($content -match '(?m)^## Recent Research') { $hasRecentResearch = $true }

    $lines = Get-Content -LiteralPath $TargetFile -Encoding utf8
    $output = New-Object System.Collections.Generic.List[string]
    $inResearch = $false; $inRecent = $false; $researchAdded = $false; $recentAdded = $false; $existingRecentCount = 0

    for ($i=0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]

        # Handle Active Research Topics section
        if ($line -eq '## Active Research Topics') {
            $output.Add($line)
            $inResearch = $true
            continue
        }
        if ($inResearch -and $line -match '^##\s') {
            if (-not $researchAdded -and $newResearchEntries.Count -gt 0) {
                $newResearchEntries | ForEach-Object { $output.Add($_) }
                $researchAdded = $true
            }
            $output.Add($line)
            $inResearch = $false
            continue
        }
        if ($inResearch -and [string]::IsNullOrWhiteSpace($line)) {
            if (-not $researchAdded -and $newResearchEntries.Count -gt 0) {
                $newResearchEntries | ForEach-Object { $output.Add($_) }
                $researchAdded = $true
            }
            $output.Add($line)
            continue
        }

        # Handle Recent Research section
        if ($line -eq '## Recent Research') {
            $output.Add($line)
            if ($newRecentEntry) {
                $output.Add($newRecentEntry)
                $recentAdded = $true
            }
            $inRecent = $true
            continue
        }
        if ($inRecent -and $line -match '^##\s') {
            $output.Add($line)
            $inRecent = $false
            continue
        }
        if ($inRecent -and $line -match '^- ') {
            if ($existingRecentCount -lt 2) {
                $output.Add($line)
                $existingRecentCount++
            }
            continue
        }

        # Update timestamp
        if ($line -match '\*\*Last updated\*\*:.*\d{4}-\d{2}-\d{2}' -or $line -match 'Last updated:.*\d{4}-\d{2}-\d{2}') {
            $output.Add(($line -replace '\d{4}-\d{2}-\d{2}',$Date.ToString('yyyy-MM-dd')))
            continue
        }
        $output.Add($line)
    }

    # Post-loop check: if we're still in Active Research Topics section and haven't added new entries
    if ($inResearch -and -not $researchAdded -and $newResearchEntries.Count -gt 0) {
        $newResearchEntries | ForEach-Object { $output.Add($_) }
        $researchAdded = $true
    }

    # If sections don't exist, add them at the end of the file
    if (-not $hasActiveResearch -and $newResearchEntries.Count -gt 0) {
        $output.Add('')
        $output.Add('## Active Research Topics')
        $newResearchEntries | ForEach-Object { $output.Add($_) }
        $researchAdded = $true
    }

    if (-not $hasRecentResearch -and $newRecentEntry) {
        $output.Add('')
        $output.Add('## Recent Research')
        $output.Add($newRecentEntry)
        $recentAdded = $true
    }

    Set-Content -LiteralPath $TargetFile -Value ($output -join [Environment]::NewLine) -Encoding utf8
    return $true
}

function Update-AgentFile {
    param(
        [Parameter(Mandatory=$true)]
        [string]$TargetFile,
        [Parameter(Mandatory=$true)]
        [string]$AgentName
    )
    if (-not $TargetFile -or -not $AgentName) { Write-Err 'Update-AgentFile requires TargetFile and AgentName'; return $false }
    Write-Info "Updating $AgentName context file: $TargetFile"
    $projectName = Split-Path $REPO_ROOT -Leaf
    $date = Get-Date

    $dir = Split-Path -Parent $TargetFile
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }

    if (-not (Test-Path $TargetFile)) {
        if (New-AgentFile -TargetFile $TargetFile -ProjectName $projectName -Date $date) { Write-Success "Created new $AgentName context file" } else { Write-Err 'Failed to create new agent file'; return $false }
    } else {
        try {
            if (Update-ExistingAgentFile -TargetFile $TargetFile -Date $date) { Write-Success "Updated existing $AgentName context file" } else { Write-Err 'Failed to update agent file'; return $false }
        } catch {
            Write-Err "Cannot access or update existing file: $TargetFile. $_"
            return $false
        }
    }
    return $true
}

function Update-SpecificAgent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Type
    )
    switch ($Type) {
        'claude'   { Update-AgentFile -TargetFile $CLAUDE_FILE   -AgentName 'Claude Code' }
        'gemini'   { Update-AgentFile -TargetFile $GEMINI_FILE   -AgentName 'Gemini CLI' }
        'copilot'  { Update-AgentFile -TargetFile $COPILOT_FILE  -AgentName 'GitHub Copilot' }
        'cursor-agent' { Update-AgentFile -TargetFile $CURSOR_FILE   -AgentName 'Cursor IDE' }
        'qwen'     { Update-AgentFile -TargetFile $QWEN_FILE     -AgentName 'Qwen Code' }
        'opencode' { Update-AgentFile -TargetFile $AGENTS_FILE   -AgentName 'opencode' }
        'codex'    { Update-AgentFile -TargetFile $AGENTS_FILE   -AgentName 'Codex CLI' }
        'windsurf' { Update-AgentFile -TargetFile $WINDSURF_FILE -AgentName 'Windsurf' }
        'kilocode' { Update-AgentFile -TargetFile $KILOCODE_FILE -AgentName 'Kilo Code' }
        'auggie'   { Update-AgentFile -TargetFile $AUGGIE_FILE   -AgentName 'Auggie CLI' }
        'roo'      { Update-AgentFile -TargetFile $ROO_FILE      -AgentName 'Roo Code' }
        'codebuddy' { Update-AgentFile -TargetFile $CODEBUDDY_FILE -AgentName 'CodeBuddy CLI' }
        'amp'      { Update-AgentFile -TargetFile $AMP_FILE      -AgentName 'Amp' }
        'q'        { Update-AgentFile -TargetFile $Q_FILE        -AgentName 'Amazon Q Developer CLI' }
        default { Write-Err "Unknown agent type '$Type'"; Write-Err 'Expected: claude|gemini|copilot|cursor-agent|qwen|opencode|codex|windsurf|kilocode|auggie|roo|codebuddy|amp|q'; return $false }
    }
}

function Update-AllExistingAgents {
    $found = $false
    $ok = $true
    if (Test-Path $CLAUDE_FILE)   { if (-not (Update-AgentFile -TargetFile $CLAUDE_FILE   -AgentName 'Claude Code')) { $ok = $false }; $found = $true }
    if (Test-Path $GEMINI_FILE)   { if (-not (Update-AgentFile -TargetFile $GEMINI_FILE   -AgentName 'Gemini CLI')) { $ok = $false }; $found = $true }
    if (Test-Path $COPILOT_FILE)  { if (-not (Update-AgentFile -TargetFile $COPILOT_FILE  -AgentName 'GitHub Copilot')) { $ok = $false }; $found = $true }
    if (Test-Path $CURSOR_FILE)   { if (-not (Update-AgentFile -TargetFile $CURSOR_FILE   -AgentName 'Cursor IDE')) { $ok = $false }; $found = $true }
    if (Test-Path $QWEN_FILE)     { if (-not (Update-AgentFile -TargetFile $QWEN_FILE     -AgentName 'Qwen Code')) { $ok = $false }; $found = $true }
    if (Test-Path $AGENTS_FILE)   { if (-not (Update-AgentFile -TargetFile $AGENTS_FILE   -AgentName 'Codex/opencode')) { $ok = $false }; $found = $true }
    if (Test-Path $WINDSURF_FILE) { if (-not (Update-AgentFile -TargetFile $WINDSURF_FILE -AgentName 'Windsurf')) { $ok = $false }; $found = $true }
    if (Test-Path $KILOCODE_FILE) { if (-not (Update-AgentFile -TargetFile $KILOCODE_FILE -AgentName 'Kilo Code')) { $ok = $false }; $found = $true }
    if (Test-Path $AUGGIE_FILE)   { if (-not (Update-AgentFile -TargetFile $AUGGIE_FILE   -AgentName 'Auggie CLI')) { $ok = $false }; $found = $true }
    if (Test-Path $ROO_FILE)      { if (-not (Update-AgentFile -TargetFile $ROO_FILE      -AgentName 'Roo Code')) { $ok = $false }; $found = $true }
    if (Test-Path $CODEBUDDY_FILE) { if (-not (Update-AgentFile -TargetFile $CODEBUDDY_FILE -AgentName 'CodeBuddy CLI')) { $ok = $false }; $found = $true }
    if (Test-Path $Q_FILE)        { if (-not (Update-AgentFile -TargetFile $Q_FILE        -AgentName 'Amazon Q Developer CLI')) { $ok = $false }; $found = $true }
    if (-not $found) {
        Write-Info 'No existing agent files found, creating default Claude file...'
        if (-not (Update-AgentFile -TargetFile $CLAUDE_FILE -AgentName 'Claude Code')) { $ok = $false }
    }
    return $ok
}

function Print-Summary {
    Write-Host ''
    Write-Info 'Summary of research context updates:'
    if ($NEW_RESEARCH_TYPE) { Write-Host "  - Research type: $NEW_RESEARCH_TYPE" }
    if ($NEW_RESEARCH_QUESTIONS) { Write-Host "  - Research questions: $NEW_RESEARCH_QUESTIONS" }
    if ($NEW_METHODS) { Write-Host "  - Research methods: $NEW_METHODS" }
    if ($NEW_DATA_SOURCES -and $NEW_DATA_SOURCES -ne 'N/A') { Write-Host "  - Data sources: $NEW_DATA_SOURCES" }
    Write-Host ''
    Write-Info 'Agent context files updated with current research information'
    Write-Host ''
    Write-Info 'Usage: ./update-agent-context.ps1 [-AgentType claude|gemini|copilot|cursor-agent|qwen|opencode|codex|windsurf|kilocode|auggie|roo|codebuddy|amp|q]'
}

function Main {
    Validate-Environment
    Write-Info "=== Updating agent context files for research topic $CURRENT_BRANCH ==="
    if (-not (Parse-MethodologyData -MethodologyFile $NEW_METHODOLOGY)) { Write-Err 'Failed to parse methodology data'; exit 1 }
    $success = $true
    if ($AgentType) {
        Write-Info "Updating specific agent: $AgentType"
        if (-not (Update-SpecificAgent -Type $AgentType)) { $success = $false }
    }
    else {
        Write-Info 'No agent specified, updating all existing agent files...'
        if (-not (Update-AllExistingAgents)) { $success = $false }
    }
    Print-Summary
    if ($success) { Write-Success 'Agent context update completed successfully'; exit 0 } else { Write-Err 'Agent context update completed with errors'; exit 1 }
}

Main
