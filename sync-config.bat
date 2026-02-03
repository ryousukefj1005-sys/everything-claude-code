@echo off
REM Claude Code 配置同步脚本 (Windows)
REM 用法：双击运行或命令行执行 sync-config.bat

echo ========================================
echo   Claude Code 配置同步脚本
echo ========================================
echo.

REM 检查当前目录
if not exist ".git" (
    echo [错误] 当前目录不是 Git 仓库
    echo 请在 everything-claude-code 目录下运行此脚本
    pause
    exit /b 1
)

echo [1/4] 复制你的配置到项目...
echo.

REM 复制 skills
echo   - 复制 skills...
xcopy /E /I /Y "%USERPROFILE%\.claude\skills" skills\ >nul 2>&1

REM 复制 rules
echo   - 复制 rules...
xcopy /E /I /Y "%USERPROFILE%\.claude\rules" rules\ >nul 2>&1

REM 复制 commands
echo   - 复制 commands...
xcopy /E /I /Y "%USERPROFILE%\.claude\commands" commands\ >nul 2>&1

REM 复制 agents
echo   - 复制 agents...
xcopy /E /I /Y "%USERPROFILE%\.claude\agents" agents\ >nul 2>&1

echo.
echo [2/4] 检查 Git 状态...
git status --short

echo.
echo [3/4] 提交更改...
git add .
git commit -m "sync: 配置自动同步 %date% %time%" 2>nul
if %errorlevel% equ 0 (
    echo   ✓ 已提交
) else (
    echo   ⚠ 没有新的更改
)

echo.
echo [4/4] 推送到 GitHub...
git push

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo   ✓ 配置同步完成！
    echo ========================================
) else (
    echo.
    echo ========================================
    echo   ⚠ 推送失败，请检查网络连接
    echo ========================================
)

echo.
pause
