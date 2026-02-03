@echo off
REM Claude Code 配置检查脚本
REM 每周运行一次，检查配置健康状态

setlocal enabledelayedexpansion

echo.
echo ========================================
echo   Claude Code 配置健康检查
echo ========================================
echo.

set /a score=0
set /a total=10

REM [1] 检查配置目录
echo [1/10] 检查配置目录...
if exist "%USERPROFILE%\.claude" (
    echo   ✓ 配置目录存在
    set /a score+=1
) else (
    echo   ✗ 配置目录不存在
)

REM [2] 检查配置文件
echo [2/10] 检查配置文件...
if exist "%USERPROFILE%\.claude\settings.json" (
    echo   ✓ settings.json 存在
    set /a score+=1
) else (
    echo   ✗ settings.json 缺失
)

REM [3] 检查技能目录
echo [3/10] 检查技能目录...
if exist "%USERPROFILE%\.claude\skills" (
    echo   ✓ skills 目录存在
    set /a score+=1
) else (
    echo   ✗ skills 目录缺失
)

REM [4] 统计技能数量
echo [4/10] 统计技能数量...
set /a skill_count=0
for /d %%d in ("%USERPROFILE%\.claude\skills\*") do (
    set /a skill_count+=1
)
echo   发现 !skill_count! 个技能
if !skill_count! gtr 0 (
    set /a score+=1
)

REM [5] 检查规则目录
echo [5/10] 检查规则目录...
if exist "%USERPROFILE%\.claude\rules" (
    echo   ✓ rules 目录存在
    set /a score+=1
) else (
    echo   ✗ rules 目录缺失
)

REM [6] 统计规则数量
echo [6/10] 统计规则数量...
set /a rule_count=0
for %%f in ("%USERPROFILE%\.claude\rules\*.md") do (
    set /a rule_count+=1
)
echo   发现 !rule_count! 个规则
if !rule_count! gtr 0 (
    set /a score+=1
)

REM [7] 检查 Git 仓库
echo [7/10] 检查 Git 仓库...
cd "D:\AI Project\everything-claude-code" 2>nul
if exist ".git" (
    echo   ✓ Git 仓库存在
    set /a score+=1
) else (
    echo   ✗ Git 仓库缺失
)

REM [8] 检查远程连接
echo [8/10] 检查远程连接...
cd "D:\AI Project\everything-claude-code" 2>nul
for /f "tokens=2" %%i in ('git remote -v ^| findstr "origin"') do (
    set remote_url=%%i
)
if defined remote_url (
    echo   ✓ 远程仓库：!remote_url!
    set /a score+=1
) else (
    echo   ✗ 远程仓库未配置
)

REM [9] 检查同步状态
echo [9/10] 检查同步状态...
cd "D:\AI Project\everything-claude-code" 2>nul
for /f %%i in ('git status --short ^| find /c /v ""') do set changes=%%i
if !changes! equ 0 (
    echo   ✓ 工作区干净
    set /a score+=1
) else (
    echo   ⚠ 有 !changes! 个未提交的改动
)

REM [10] 检查 SSH 连接
echo [10/10] 检查 GitHub SSH 连接...
ssh -T git@github.com 2>nul
if %errorlevel% equ 1 (
    echo   ✓ SSH 连接正常
    set /a score+=1
) else (
    echo   ✗ SSH 连接失败
)

REM 计算健康分数
echo.
echo ========================================
echo   健康检查结果
echo ========================================
echo 得分：!score! / !total!
set /a percent=score*10
echo 健康度：!percent!%%

if !score! geq 9 (
    echo 状态：✓ 优秀
    echo.
    echo 你的配置运行良好！
) else if !score! geq 7 (
    echo 状态：⚠ 良好
    echo.
    echo 建议检查失败的项。
) else (
    echo 状态：✗ 需要修复
    echo.
    echo 请按照上面的问题逐项修复。
)

echo.
echo ========================================
echo   详细信息
echo ========================================
echo.
echo 配置目录位置：
echo   %USERPROFILE%\.claude
echo.
echo Git 仓库位置：
echo   D:\AI Project\everything-claude-code
echo.
echo 远程仓库：
cd "D:\AI Project\everything-claude-code" 2>nul
git remote -v
echo.
pause
