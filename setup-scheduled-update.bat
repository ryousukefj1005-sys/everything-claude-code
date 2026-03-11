@echo off
REM 创建Windows定时任务 - 每周检查Everything Claude Code更新
REM 需要管理员权限运行

echo ========================================
echo   设置Everything Claude Code自动更新任务
echo ========================================
echo.

REM 检查管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 请右键点击此脚本，选择"以管理员身份运行"
    pause
    exit /b 1
)

REM 删除旧任务（如果存在）
schtasks /delete /tn "EverythingClaudeCode-WeeklyUpdate" /f >nul 2>&1

REM 创建新任务 - 每周一早上9点运行
schtasks /create ^
    /tn "EverythingClaudeCode-WeeklyUpdate" ^
    /tr "D:\AI Project\everything-claude-code\auto-update.bat" ^
    /sc weekly ^
    /d MON ^
    /st 09:00 ^
    /rl HIGHEST ^
    /f

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo   定时任务创建成功！
    echo ========================================
    echo.
    echo   任务名称: EverythingClaudeCode-WeeklyUpdate
    echo   执行时间: 每周一 09:00
    echo   执行脚本: auto-update.bat
    echo.
    echo   手动测试命令:
    echo   schtasks /run /tn "EverythingClaudeCode-WeeklyUpdate"
    echo.
    echo   查看任务状态:
    echo   schtasks /query /tn "EverythingClaudeCode-WeeklyUpdate"
    echo.
) else (
    echo [错误] 创建定时任务失败
)

pause
