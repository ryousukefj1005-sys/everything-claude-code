@echo off
REM Everything Claude Code 自动升级脚本v2.0
REM 从上游原始仓库拉取更新
REM 用法：双击运行或通过Hook自动调用

setlocal EnableDelayedExpansion

set "PLUGIN_ROOT=D:\AI Project\everything-claude-code"
set "LOG_FILE=%PLUGIN_ROOT%\update.log"

echo [%date% %time%] 开始检查上游更新... >> "%LOG_FILE%"

REM 切换到插件目录
cd /d "%PLUGIN_ROOT%"

REM 检查是否有git
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Git 未安装 >> "%LOG_FILE%"
    exit /b 1
)

REM 获取当前分支
for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD') do set CURRENT_BRANCH=%%i
echo [%date% %time%] 当前分支: %CURRENT_BRANCH% >> "%LOG_FILE%"

REM 获取本地commit hash
for /f "tokens=*" %%i in ('git rev-parse HEAD') do set LOCAL_HASH=%%i

REM 检查upstream是否存在，不存在则添加
git remote | findstr "upstream" >nul
if %errorlevel% neq 0 (
    echo [%date% %time%] 添加上游仓库... >> "%LOG_FILE%"
    git remote add upstream https://github.com/AffanMustafa5/everything-claude-code.git
)

REM 获取上游最新commit hash
echo [%date% %time%] 检查上游更新... >> "%LOG_FILE%"
git fetch upstream %CURRENT_BRANCH% >> "%LOG_FILE%" 2>&1

REM 检查上游是否有该分支
git rev-parse upstream/%CURRENT_BRANCH% >nul 2>&1
if %errorlevel% neq 0 (
    echo [%date% %time%] 上游没有 %CURRENT_BRANCH% 分支，尝试 main 分支 >> "%LOG_FILE%"
    set CURRENT_BRANCH=main
    git fetch upstream main >> "%LOG_FILE%" 2>&1
)

for /f "tokens=*" %%i in ('git rev-parse upstream/%CURRENT_BRANCH%') do set UPSTREAM_HASH=%%i

REM 比较是否有更新
if "%LOCAL_HASH%"=="%UPSTREAM_HASH%" (
    echo [%date% %time%] 已是最新版本，无需更新 >> "%LOG_FILE%"
    echo 已是最新版本
    exit /b 0
)

echo[%date% %time%] 发现新版本！>> "%LOG_FILE%"
echo 本地: %LOCAL_HASH:~0,7%
echo 上游: %UPSTREAM_HASH:~0,7%
echo.
echo 正在更新...

REM 合并上游更新
git merge upstream/%CURRENT_BRANCH% --no-edit >> "%LOG_FILE%" 2>&1

if %errorlevel% neq 0 (
    echo [警告] 合并有冲突，尝试重置... >> "%LOG_FILE%"
    git reset --hard upstream/%CURRENT_BRANCH% >> "%LOG_FILE%" 2>&1
)

echo [%date% %time%] 代码更新完成，开始同步配置... >> "%LOG_FILE%"

REM 同步配置到用户目录
echo   - 同步 skills...
xcopy /E /I /Y "%PLUGIN_ROOT%\skills\*" "%USERPROFILE%\.claude\skills" >nul 2>&1

echo   - 同步 rules...
xcopy /E /I /Y "%PLUGIN_ROOT%\rules\*" "%USERPROFILE%\.claude\rules" >nul 2>&1

echo   - 同步 commands...
xcopy /E /I /Y "%PLUGIN_ROOT%\commands\*" "%USERPROFILE%\.claude\commands" >nul 2>&1

echo   - 同步 agents...
xcopy /E /I /Y "%PLUGIN_ROOT%\agents\*" "%USERPROFILE%\.claude\agents" >nul 2>&1

echo [%date% %time%] 更新完成！ >> "%LOG_FILE%"
echo.
echo ========================================
echo   更新完成！
echo   日志: %LOG_FILE%
echo ========================================
echo.
echo 提示：重启 Claude Code 后生效

exit /b 0
