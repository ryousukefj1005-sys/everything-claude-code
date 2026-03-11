# Everything Claude Code Auto-Update Script v2.1

param([switch]$Silent)

$PLUGIN_ROOT = "D:\AI Project\everything-claude-code"
$LOG_FILE = Join-Path $PLUGIN_ROOT "update.log"

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LOG_FILE -Value "[$timestamp] $Message"
    if (-not $Silent) { Write-Host $Message }
}

Write-Log "Starting update check..."
Set-Location $PLUGIN_ROOT

# Check upstream remote
$remotes = git remote
if ($remotes -notcontains "upstream") {
    Write-Log "Adding upstream remote..."
    git remote add upstream https://github.com/affaan-m/everything-claude-code.git
}

# Fetch upstream
Write-Log "Fetching upstream..."
git fetch upstream main 2>&1 | Out-Null

# Compare commits
try {
    $LOCAL = git rev-parse HEAD
    $UPSTREAM = git rev-parse upstream/main
} catch {
    Write-Log "Error: Cannot get commit info"
    exit 1
}

if ($LOCAL -eq $UPSTREAM) {
    Write-Log "Already up to date"
    exit 0
}

Write-Log "New version found! Updating..."
$localShort = $LOCAL.Substring(0,7)
$upstreamShort = $UPSTREAM.Substring(0,7)
Write-Host "Local: $localShort"
Write-Host "Upstream: $upstreamShort"
Write-Host ""

# Reset to upstream
Write-Host "Updating code..."
git reset --hard upstream/main 2>&1 | Out-Null

# Sync to user directory
$userClaude = "$env:USERPROFILE\.claude"
Write-Host "Syncing configs..."

$dirs = @("skills", "rules", "commands", "agents")
foreach ($dir in $dirs) {
    $src = Join-Path $PLUGIN_ROOT $dir
    $dst = Join-Path $userClaude $dir
    if (Test-Path $src) {
        Write-Host "  - $dir"
        Copy-Item -Path "$src\*" -Destination $dst -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Log "Update complete!"
Write-Host ""
Write-Host "========================================"
Write-Host "  Update complete!"
Write-Host "  Local: $localShort -> $upstreamShort"
Write-Host "  Log: $LOG_FILE"
Write-Host "========================================"
Write-Host ""
Write-Host "Restart Claude Code to apply changes."
exit 0
