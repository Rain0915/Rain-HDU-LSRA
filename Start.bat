@echo off
title HDU Library Reservation Assistant
color 0A

set CORE=%~dp0HDUlib_Reserve-main

cd /d "%CORE%"

set PATH=%CORE%\node;%PATH%
set PLAYWRIGHT_BROWSERS_PATH=0

if not exist logs mkdir logs

for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmmss"') do set NOW=%%i
set LOGFILE=logs\run-%NOW%.log

cls
echo ==================================================
echo.
echo        HDU Library Reservation Assistant
echo.
echo ==================================================
echo.
echo 当前时间：%date% %time%
echo.
echo 开始前请确认：
echo.
echo   1. 已连接网络
echo   2. 已完成 login.bat 登录
echo   3. 电脑不会进入睡眠
echo   4. requests/default.json 配置正确
echo.
echo 按 Enter 开始运行...
echo.

set /p start=

cls
echo ==================================================
echo.
echo        HDU Library Reservation Assistant
echo.
echo ==================================================
echo.
echo 正在等待预约启动时间...
echo.
echo ==================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "$target = Get-Date -Hour 19 -Minute 59 -Second 30; while($true){ $now = Get-Date; $left = $target - $now; if($left.TotalSeconds -le 0){ break }; Clear-Host; Write-Host '=================================================='; Write-Host ''; Write-Host '      HDU Library Reservation Assistant'; Write-Host ''; Write-Host '=================================================='; Write-Host ''; Write-Host ('当前时间：' + $now.ToString('HH:mm:ss')); Write-Host ''; Write-Host ('距离启动还有：' + $left.ToString('hh\:mm\:ss')); Write-Host ''; Write-Host '脚本将在指定时间自动启动...'; Start-Sleep -Milliseconds 500 }"

cls
echo ==================================================
echo.
echo        HDU Library Reservation Assistant
echo.
echo ==================================================
echo.
echo 正在启动预约脚本...
echo.
echo 日志位置：
echo %LOGFILE%
echo.
echo ==================================================
echo.

echo ================================================== >> "%LOGFILE%"
echo 启动时间：%date% %time% >> "%LOGFILE%"
echo 运行模式：正式预约 >> "%LOGFILE%"
echo ================================================== >> "%LOGFILE%"

call node\npm.cmd run reserve >> "%LOGFILE%" 2>&1

cls
echo ==================================================
echo.
echo        HDU Library Reservation Assistant
echo.
echo ==================================================
echo.
echo 正在分析预约结果...
echo.

findstr /c:"预约成功：" "%LOGFILE%" >nul

if %errorlevel%==0 (
    color 0A
    echo [预约结果] 预约成功！
    echo.
    echo 预约信息：
    for /f "tokens=2 delims=：" %%a in ('findstr /c:"预约成功：" "%LOGFILE%"') do echo %%a
) else (
    color 0C
    echo [预约结果] 预约失败或未检测到成功信息。
    echo.
    echo 关键失败信息：
    echo --------------------------------------------------
    findstr /i "提交失败 ParamError fail 请求太频繁 不可自动重试 已停止 超出可预约 未登录 401 403 timeout error" "%LOGFILE%"
    echo --------------------------------------------------
)

echo.
echo 完整日志位置：
echo %LOGFILE%
echo.
echo ==================================================
echo.

pause