#!/usr/bin/env pwsh
# Common PowerShell functions analogous to common.sh

function Get-RepoRoot {
    try {
        $result = git rev-parse --show-toplevel 2>$null
        if ($LASTEXITCODE -eq 0) {
            return $result
        }
    } catch {
        # Git command failed
    }

    # Fall back to script location for non-git repos
    return (Resolve-Path (Join-Path $PSScriptRoot "../../..")).Path
}

function Get-CurrentBranch {
    # First check if RESEARCH_TOPIC environment variable is set
    if ($env:RESEARCH_TOPIC) {
        return $env:RESEARCH_TOPIC
    }

    # Backward compatibility: check legacy SPECIFY_FEATURE variable
    if ($env:SPECIFY_FEATURE) {
        return $env:SPECIFY_FEATURE
    }

    # Then check git if available
    try {
        $result = git rev-parse --abbrev-ref HEAD 2>$null
        if ($LASTEXITCODE -eq 0) {
            return $result
        }
    } catch {
        # Git command failed
    }

    # For non-git repos, try to find the latest research directory
    $repoRoot = Get-RepoRoot
    $researchDir = Join-Path $repoRoot "research"

    # Fall back to specs directory for backward compatibility
    $specsDir = Join-Path $repoRoot "specs"

    # Try research directory first, then specs
    $searchDir = $researchDir
    if (-not (Test-Path $researchDir) -and (Test-Path $specsDir)) {
        $searchDir = $specsDir
    }

    if (Test-Path $searchDir) {
        $latestTopic = ""
        $highest = 0

        Get-ChildItem -Path $searchDir -Directory | ForEach-Object {
            if ($_.Name -match '^(\d{3})-') {
                $num = [int]$matches[1]
                if ($num -gt $highest) {
                    $highest = $num
                    $latestTopic = $_.Name
                }
            }
        }

        if ($latestTopic) {
            return $latestTopic
        }
    }

    # Final fallback
    return "main"
}

function Test-HasGit {
    try {
        git rev-parse --show-toplevel 2>$null | Out-Null
        return ($LASTEXITCODE -eq 0)
    } catch {
        return $false
    }
}

function Check-ResearchBranch {
    param(
        [string]$Branch,
        [bool]$HasGit = $true
    )

    # For non-git repos, we can't enforce branch naming but still provide output
    if (-not $HasGit) {
        Write-Warning "[research-kit] Warning: Git repository not detected; skipped branch validation"
        return $true
    }

    if ($Branch -notmatch '^[0-9]{3}-') {
        Write-Output "ERROR: Not on a research branch. Current branch: $Branch"
        Write-Output "Research branches should be named like: 001-topic-name"
        return $false
    }
    return $true
}

# Legacy alias for backward compatibility
function Test-FeatureBranch {
    param(
        [string]$Branch,
        [bool]$HasGit = $true
    )
    Check-ResearchBranch -Branch $Branch -HasGit $HasGit
}

function Get-ResearchDir {
    param([string]$RepoRoot, [string]$Branch)

    # Try research/ first, then fall back to specs/ for backward compatibility
    $researchPath = Join-Path $RepoRoot "research/$Branch"
    $specsPath = Join-Path $RepoRoot "specs/$Branch"

    if (Test-Path (Join-Path $RepoRoot "research")) {
        return $researchPath
    } else {
        return $specsPath
    }
}

# Legacy alias for backward compatibility
function Get-FeatureDir {
    param([string]$RepoRoot, [string]$Branch)
    Get-ResearchDir -RepoRoot $RepoRoot -Branch $Branch
}

# Find research directory by numeric prefix instead of exact branch match
# This allows multiple branches to work on the same research topic (e.g., 004-analysis, 004-methodology)
function Find-ResearchDirByPrefix {
    param([string]$RepoRoot, [string]$BranchName)

    # Try research/ first, then fall back to specs/ for backward compatibility
    $researchDir = Join-Path $RepoRoot "research"
    $specsDir = Join-Path $RepoRoot "specs"
    $searchDir = $researchDir

    if (-not (Test-Path $researchDir) -and (Test-Path $specsDir)) {
        $searchDir = $specsDir
    }

    # Extract numeric prefix from branch (e.g., "004" from "004-whatever")
    if ($BranchName -notmatch '^(\d{3})-') {
        # If branch doesn't have numeric prefix, fall back to exact match
        return Join-Path $searchDir $BranchName
    }

    $prefix = $matches[1]

    # Search for directories that start with this prefix
    $matches = @()
    if (Test-Path $searchDir) {
        $matches = Get-ChildItem -Path $searchDir -Directory -Filter "$prefix-*" | Select-Object -ExpandProperty Name
    }

    # Handle results
    if ($matches.Count -eq 0) {
        # No match found - return the branch name path (will fail later with clear error)
        return Join-Path $searchDir $BranchName
    } elseif ($matches.Count -eq 1) {
        # Exactly one match - perfect!
        return Join-Path $searchDir $matches[0]
    } else {
        # Multiple matches - this shouldn't happen with proper naming convention
        Write-Error "ERROR: Multiple research directories found with prefix '$prefix': $($matches -join ', ')"
        Write-Error "Please ensure only one research directory exists per numeric prefix."
        return Join-Path $searchDir $BranchName  # Return something to avoid breaking the script
    }
}

# Legacy alias for backward compatibility
function Find-FeatureDirByPrefix {
    param([string]$RepoRoot, [string]$BranchName)
    Find-ResearchDirByPrefix -RepoRoot $RepoRoot -BranchName $BranchName
}

function Get-ResearchPaths {
    $repoRoot = Get-RepoRoot
    $currentBranch = Get-CurrentBranch
    $hasGit = Test-HasGit

    # Use prefix-based lookup to support multiple branches per research topic
    $researchDir = Find-ResearchDirByPrefix -RepoRoot $repoRoot -BranchName $currentBranch

    [PSCustomObject]@{
        REPO_ROOT              = $repoRoot
        CURRENT_BRANCH         = $currentBranch
        HAS_GIT                = $hasGit
        RESEARCH_DIR           = $researchDir
        RESEARCH_DEFINITION    = Join-Path $researchDir 'definition.md'
        RESEARCH_METHODOLOGY   = Join-Path $researchDir 'methodology.md'
        RESEARCH_TASKS         = Join-Path $researchDir 'tasks.md'
        RESEARCH_NOTES         = Join-Path $researchDir 'research.md'
        RESEARCH_DATA          = Join-Path $researchDir 'data-model.md'
        RESEARCH_QUICKSTART    = Join-Path $researchDir 'quickstart.md'
        RESEARCH_CONTRACTS_DIR = Join-Path $researchDir 'contracts'
    }
}

# Legacy alias for backward compatibility - outputs old variable names
function Get-FeaturePathsEnv {
    $repoRoot = Get-RepoRoot
    $currentBranch = Get-CurrentBranch
    $hasGit = Test-HasGit

    # Use prefix-based lookup to support multiple branches per research topic
    $featureDir = Find-ResearchDirByPrefix -RepoRoot $repoRoot -BranchName $currentBranch

    [PSCustomObject]@{
        REPO_ROOT     = $repoRoot
        CURRENT_BRANCH = $currentBranch
        HAS_GIT       = $hasGit
        FEATURE_DIR   = $featureDir
        FEATURE_SPEC  = Join-Path $featureDir 'spec.md'
        IMPL_PLAN     = Join-Path $featureDir 'plan.md'
        TASKS         = Join-Path $featureDir 'tasks.md'
        RESEARCH      = Join-Path $featureDir 'research.md'
        DATA_MODEL    = Join-Path $featureDir 'data-model.md'
        QUICKSTART    = Join-Path $featureDir 'quickstart.md'
        CONTRACTS_DIR = Join-Path $featureDir 'contracts'
    }
}

# Legacy alias for backward compatibility
function Get-FeaturePaths {
    Get-FeaturePathsEnv
}

function Test-FileExists {
    param([string]$Path, [string]$Description)
    if (Test-Path -Path $Path -PathType Leaf) {
        Write-Output "  ✓ $Description"
        return $true
    } else {
        Write-Output "  ✗ $Description"
        return $false
    }
}

function Test-DirHasFiles {
    param([string]$Path, [string]$Description)
    if ((Test-Path -Path $Path -PathType Container) -and (Get-ChildItem -Path $Path -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer } | Select-Object -First 1)) {
        Write-Output "  ✓ $Description"
        return $true
    } else {
        Write-Output "  ✗ $Description"
        return $false
    }
}
