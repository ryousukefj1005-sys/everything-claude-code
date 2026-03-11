# Everything Claude Code Auto-Update Script v2.2
# 从上游原始仓库拉取更新并自动生成文档

param([switch]$Silent)

$PLUGIN_ROOT = "D:\AI Project\everything-claude-code"
$LOG_FILE = Join-Path $PLUGIN_ROOT "update.log"

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LOG_FILE -Value "[$timestamp] $Message"
    if (-not $Silent) { Write-Host $Message }
}

function Update-Doc {
    Write-Host "Generating documentation..."-ForegroundColor Cyan

    # Count tools
    $skillCount = (Get-ChildItem -Path "$PLUGIN_ROOT\skills" -Directory).Count
    $commandCount = (Get-ChildItem -Path "$PLUGIN_ROOT\commands" -Filter "*.md").Count
    $agentCount = (Get-ChildItem -Path "$PLUGIN_ROOT\agents" -Filter "*.md").Count

    Write-Host "  Skills: $skillCount"
    Write-Host "  Commands: $commandCount"
    Write-Host "  Agents: $agentCount"

    # Get current date
    $currentDate = Get-Date -Format "yyyy-MM-dd"

    # Read template and update counts
    $docPath = "$PLUGIN_ROOT\工具说明文档.md"
    if (Test-Path $docPath) {
        $content = Get-Content $docPath -Raw
        $content = $content -replace "(\*\*\d+个技能)", "**$skillCount个技能"
        $content = $content -replace "(\*\*\d+个命令)", "**$commandCount个命令"
        $content = $content -replace "(\*\*\d+个代理)", "**$agentCount个代理"
        $content = $content -replace "#date: \d{4}-\d{2}-\d{2}", "#date: $currentDate"
        $content | Set-Content $docPath -Encoding UTF8
        Write-Host "  Documentation updated!"
    }
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
    Update-Doc
    exit 0
}

Write-Log "New version found! Updating..."
$localShort = $LOCAL.Substring(0,7)
$upstreamShort = $UPSTREAM.Substring(0,7)
Write-Host "Local: $localShort"
Write-Host "Upstream: $upstreamShort"
Write-Host ""

# Reset to upstream
Write-Host "Updating code..." -ForegroundColor Yellow
git reset --hard upstream/main 2>&1 | Out-Null

# Sync to user directory
$userClaude = "$env:USERPROFILE\.claude"
Write-Host "Syncing configs..." -ForegroundColor Cyan

$dirs = @("skills", "rules", "commands", "agents")
foreach ($dir in $dirs) {
    $src = Join-Path $PLUGIN_ROOT $dir
    $dst = Join-Path $userClaude $dir
    if (Test-Path $src) {
        Write-Host "  - $dir"
        Copy-Item -Path "$src\*" -Destination $dst -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Update documentation
Update-Doc

Write-Log "Update complete!"
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Update complete!" -ForegroundColor Green
Write-Host "  Local: $localShort -> $upstreamShort"
Write-Host "  Log: $LOG_FILE"
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Restart Claude Code to apply changes." -ForegroundColor Yellow
exit 0
