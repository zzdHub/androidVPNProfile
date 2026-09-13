@echo off
cd /d "%~dp0"

echo ===== Running autosPS1.ps1 =====
"C:\Program Files\PowerShell\7\pwsh.exe" -ExecutionPolicy Bypass -File "%~dp0autosPS1.ps1"

REM 检查上一步是否成功，失败就退出
if %errorlevel% neq 0 (
    echo autosPS1.ps1 failed, aborting.
    pause
    exit /b 1
)
"C:\Program Files\PowerShell\7\pwsh.exe" -ExecutionPolicy Bypass -File "%~dp0AutoUpGit.ps1"
pause