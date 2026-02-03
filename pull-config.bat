@echo off
REM Claude Code 配置拉取脚本 (Windows)
REM 用法：双击运行或命令行执行 pull-config.bat

echo ========================================
echo   Claude Code 配置拉取脚本
echo ========================================
echo.

echo [1/3] 从 GitHub 拉取最新配置...
git pull

echo.
echo [2/3] 复制配置到 Claude Code...
echo.

REM 复制 skills
echo   - 复制 skills...
xcopy /E /I /Y skills\ "%USERPROFILE%\.claude\skills" >nul 2>&1

REM 复制 rules
echo   - 复制 rules...
xcopy /E /I /Y rules\ "%USERPROFILE%\.claude\rules" >nul 2>&1

REM 复制 commands
echo   - 复制 commands...
xcopy /E /I /Y commands\ "%USERPROFILE%\.claude\commands" >nul 2>&1

REM 复制 agents
echo   - 复制 agents...
xcopy /E /I /Y agents\ "%USERPROFILE%\.claude\agents" >nul 2>&1

echo.
echo [3/3] 完成！
echo.
echo ========================================
echo   ✓ 配置已同步到本地
echo ========================================
echo.
echo 提示：重启 Claude Code 后生效
echo.

pause
