# Main.bat（v1.2修正版）

```bat
@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

title HDU Library Reservation Assistant
color 0A

set CORE=%~dp0HDUlib_Reserve-main
cd /d "%CORE%"

set PATH=%CORE%\node;%PATH%
set PLAYWRIGHT_BROWSERS_PATH=0
set CONFIG=requests/default.json

if not exist logs mkdir logs

:MAIN_MENU
cls
color 0A

echo ==================================================
echo.
echo        HDU Library Reservation Assistant
echo.
echo ==================================================
echo.
echo 1. 登录系统
echo 2. 修改预约配置
echo 3. 查看当前配置
echo 4. 开始预约
echo 5. 使用说明
echo 6. 退出
echo.
echo ==================================================
echo.

set /p choice=请选择功能：

if "%choice%"=="1" goto LOGIN
if "%choice%"=="2" goto CONFIG_MENU
if "%choice%"=="3" goto SHOW_CONFIG
if "%choice%"=="4" goto START_RESERVE
if "%choice%"=="5" goto HELP
if "%choice%"=="6" goto EXIT_APP

echo 输入无效，请重新选择。
timeout /t 1 >nul
goto MAIN_MENU


:LOGIN
cls

echo ==================================================
echo.
echo        HDU Library Reservation Assistant
echo.
echo ==================================================
echo.
echo 点击Enter打开登录浏览器。
echo.
echo 请在浏览器中完成学校统一身份认证。
echo 成功进入图书馆预约系统后，请关闭浏览器窗口回到Shell继续程序。
echo.
echo ==================================================
echo.
pause

call node\npm.cmd run login

echo.
echo ==================================================
echo.
echo 登录流程结束。
echo.
echo 如果 HDUlib_Reserve-main 目录中生成 storageState.json，
echo 表示登录态保存成功。
echo.
echo ==================================================
echo.
pause
goto MAIN_MENU


:CONFIG_MENU
cls

echo ==================================================
echo.
echo              修改预约配置
echo.
echo ==================================================
echo.
echo 1. 修改日期
echo 2. 修改开始时间
echo 3. 修改预约时长
echo 4. 修改优先房间
echo 5. 修改优先座位
echo 6. 修改备用座位范围
echo 7. 恢复默认配置
echo 0. 返回主菜单
echo.
echo ==================================================
echo.

set /p cfg=请选择：

if "%cfg%"=="1" goto SET_DATE
if "%cfg%"=="2" goto SET_TIME
if "%cfg%"=="3" goto SET_HOURS
if "%cfg%"=="4" goto SET_ROOM
if "%cfg%"=="5" goto SET_SEAT
if "%cfg%"=="6" goto SET_RANGE
if "%cfg%"=="7" goto RESET_CONFIG
if "%cfg%"=="0" goto MAIN_MENU

echo 输入无效，请重新选择。
timeout /t 1 >nul
goto CONFIG_MENU


:SET_DATE
set NEW_VALUE=
cls

echo ==================================================
echo.
echo              修改日期
echo.
echo ==================================================
echo.
echo 1. today
echo 2. tomorrow
echo 3. latest
echo 4. 自定义日期 YYYY-MM-DD
echo 0. 返回上一级
echo.

set /p dateChoice=请选择：

if "%dateChoice%"=="0" goto CONFIG_MENU
if "%dateChoice%"=="1" set NEW_VALUE=today
if "%dateChoice%"=="2" set NEW_VALUE=tomorrow
if "%dateChoice%"=="3" set NEW_VALUE=latest
if "%dateChoice%"=="4" set /p NEW_VALUE=请输入日期：

if "%NEW_VALUE%"=="" (
    echo 输入无效。
    pause
    goto SET_DATE
)

node\node.exe -e "const fs=require('fs');const p='%CONFIG%';const j=JSON.parse(fs.readFileSync(p,'utf8').replace(/^\uFEFF/,''));j.date='%NEW_VALUE%';fs.writeFileSync(p,JSON.stringify(j,null,2),'utf8');"

echo.
echo 日期已修改为：%NEW_VALUE%
pause
goto CONFIG_MENU


:SET_TIME
set NEW_VALUE=
cls

echo ==================================================
echo.
echo              修改开始时间
echo.
echo ==================================================
echo.
echo 输入 0 返回上一级
echo.

set /p NEW_VALUE=请输入开始时间，例如 12(仅支持7-21)：

if "%NEW_VALUE%"=="0" goto CONFIG_MENU

if "%NEW_VALUE%"=="" (
    echo 输入无效。
    pause
    goto SET_TIME
)

node\node.exe -e "const fs=require('fs');const p='%CONFIG%';const j=JSON.parse(fs.readFileSync(p,'utf8').replace(/^\uFEFF/,''));j.startTime='%NEW_VALUE%';fs.writeFileSync(p,JSON.stringify(j,null,2),'utf8');"

echo.
echo 开始时间已修改为：%NEW_VALUE%
pause
goto CONFIG_MENU


:SET_HOURS
set NEW_VALUE=
cls

echo ==================================================
echo.
echo              修改预约时长
echo.
echo ==================================================
echo.
echo 输入 0 返回上一级
echo.

set /p NEW_VALUE=请输入预约时长，例如 4 (仅支持1-15)：

if "%NEW_VALUE%"=="0" goto CONFIG_MENU

if "%NEW_VALUE%"=="" (
    echo 输入无效。
    pause
    goto SET_HOURS
)

node\node.exe -e "const fs=require('fs');const p='%CONFIG%';const j=JSON.parse(fs.readFileSync(p,'utf8').replace(/^\uFEFF/,''));j.durationHours=Number('%NEW_VALUE%');fs.writeFileSync(p,JSON.stringify(j,null,2),'utf8');"

echo.
echo 预约时长已修改为：%NEW_VALUE% 小时
pause
goto CONFIG_MENU


:SET_ROOM
set NEW_VALUE=
cls

echo ==================================================
echo.
echo              修改优先房间
echo.
echo ==================================================
echo.
echo 1. 比特庭园（二楼西）
echo 2. 格物E堂（二楼东）
echo 3. 数智渊阁（二楼 信息检索室）
echo 4. 宋韵云图（四楼）
echo 5. 杭韵数阁（六楼）
echo 6. 芯灵驿站（十二楼）
echo 0. 返回上一级
echo.

set /p roomChoice=请选择房间编号：

if "%roomChoice%"=="0" goto CONFIG_MENU
if "%roomChoice%"=="1" set NEW_VALUE=比特庭园（二楼西）
if "%roomChoice%"=="2" set NEW_VALUE=格物E堂（二楼东）
if "%roomChoice%"=="3" set NEW_VALUE=数智渊阁（二楼 信息检索室）
if "%roomChoice%"=="4" set NEW_VALUE=宋韵云图（四楼）
if "%roomChoice%"=="5" set NEW_VALUE=杭韵数阁（六楼）
if "%roomChoice%"=="6" set NEW_VALUE=芯灵驿站（十二楼）

if "%NEW_VALUE%"=="" (
    echo 输入无效。
    pause
    goto SET_ROOM
)

node\node.exe -e "const fs=require('fs');const p='%CONFIG%';const j=JSON.parse(fs.readFileSync(p,'utf8').replace(/^\uFEFF/,''));j.preferredRooms=['%NEW_VALUE%'];fs.writeFileSync(p,JSON.stringify(j,null,2),'utf8');"

echo.
echo 优先房间已修改为：%NEW_VALUE%
pause
goto CONFIG_MENU


:SET_SEAT
set NEW_VALUE=
cls

echo ==================================================
echo.
echo              修改优先座位
echo.
echo ==================================================
echo.
echo 输入 0 返回上一级
echo.

set /p NEW_VALUE=请输入优先座位号：

if "%NEW_VALUE%"=="0" goto CONFIG_MENU

if "%NEW_VALUE%"=="" (
    echo 输入无效。
    pause
    goto SET_SEAT
)

node\node.exe -e "const fs=require('fs');const p='%CONFIG%';const j=JSON.parse(fs.readFileSync(p,'utf8').replace(/^\uFEFF/,''));j.preferredSeat=Number('%NEW_VALUE%');fs.writeFileSync(p,JSON.stringify(j,null,2),'utf8');"

echo.
echo 优先座位已修改为：%NEW_VALUE%
pause
goto CONFIG_MENU


:SET_RANGE
set RANGE_START=
set RANGE_END=
cls

echo ==================================================
echo.
echo              修改备用座位范围
echo.
echo ==================================================
echo.
echo 输入 0 返回上一级
echo.

set /p RANGE_START=请输入起始座位号：

if "%RANGE_START%"=="0" goto CONFIG_MENU

set /p RANGE_END=请输入结束座位号：

if "%RANGE_END%"=="0" goto CONFIG_MENU

node\node.exe -e "const fs=require('fs');const p='%CONFIG%';const j=JSON.parse(fs.readFileSync(p,'utf8').replace(/^\uFEFF/,''));j.seatRange=[Number('%RANGE_START%'),Number('%RANGE_END%')];fs.writeFileSync(p,JSON.stringify(j,null,2),'utf8');"

echo.
echo 备用座位范围已修改为：%RANGE_START% 到 %RANGE_END%
pause
goto CONFIG_MENU


:RESET_CONFIG
cls

echo ==================================================
echo.
echo              恢复默认配置
echo.
echo ==================================================
echo.

node\node.exe -e "const fs=require('fs');const p='%CONFIG%';const j={date:'tomorrow',startTime:'12:00',durationHours:4,categories:['自习室'],preferredRooms:['比特庭园（二楼西）'],fallbackRooms:'any',preferredSeat:1,seatRange:[1,200],preferSocket:false,requireSocket:false};fs.writeFileSync(p,JSON.stringify(j,null,2),'utf8');"

echo 默认配置已恢复。
pause
goto CONFIG_MENU


:SHOW_CONFIG
cls

echo ==================================================
echo.
echo              当前预约配置
echo.
echo ==================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "$j=[System.IO.File]::ReadAllText('%CONFIG%', [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF) | ConvertFrom-Json; Write-Host ('日期：' + $j.date); Write-Host ('开始时间：' + $j.startTime); Write-Host ('预约时长：' + $j.durationHours + ' 小时'); Write-Host ('优先房间：' + $j.preferredRooms[0]); Write-Host ('优先座位：' + $j.preferredSeat); Write-Host ('备用范围：' + $j.seatRange[0] + ' 到 ' + $j.seatRange[1])"

echo.
echo ==================================================
echo.
pause
goto MAIN_MENU


:START_RESERVE
cls

echo ==================================================
echo.
echo        HDU Library Reservation Assistant
echo.
echo ==================================================
echo.

if not exist storageState.json (
    echo 当前未检测到登录态 storageState.json。
    echo.
    echo 请先完成登录。
    echo.
    pause
    goto LOGIN
)

echo 当前时间：%date% %time%
echo.
echo 开始前请确认：
echo.
echo 1. 已连接网络
echo 2. 电脑不会进入睡眠
echo 3. 当前预约配置正确
echo.

echo ==================================================
echo.
echo              当前预约配置
echo.
echo ==================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "$j=[System.IO.File]::ReadAllText('%CONFIG%', [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF) | ConvertFrom-Json; Write-Host ('日期：' + $j.date); Write-Host ('开始时间：' + $j.startTime); Write-Host ('预约时长：' + $j.durationHours + ' 小时'); Write-Host ('优先房间：' + $j.preferredRooms[0]); Write-Host ('优先座位：' + $j.preferredSeat); Write-Host ('备用范围：' + $j.seatRange[0] + ' 到 ' + $j.seatRange[1])"

echo.
echo ==================================================
echo.
echo 按 Enter 开始运行预约
echo 输入 0 返回主菜单
echo.

set /p start=

if "%start%"=="0" goto MAIN_MENU

for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmmss"') do set NOW=%%i
set LOGFILE=logs\run-%NOW%.log

cls

echo ==================================================
echo.
echo        HDU Library Reservation Assistant
echo.
echo ==================================================
echo.
echo 正在等待预约启动时间...
echo.
echo 日志文件：
echo %LOGFILE%
echo.
echo ==================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "$target = Get-Date -Hour 19 -Minute 59 -Second 55; while($true){ $now = Get-Date; $left = $target - $now; if($left.TotalSeconds -le 0){ break }; Clear-Host; Write-Host '=================================================='; Write-Host ''; Write-Host '      HDU Library Reservation Assistant'; Write-Host ''; Write-Host '=================================================='; Write-Host ''; Write-Host ('当前时间：' + $now.ToString('HH:mm:ss')); Write-Host ''; Write-Host ('距离启动还有：' + $left.ToString('hh\:mm\:ss')); Write-Host ''; Write-Host '脚本将在指定时间自动启动...'; Start-Sleep -Milliseconds 500 }"

cls

echo ==================================================
echo.
echo        HDU Library Reservation Assistant
echo.
echo ==================================================
echo.
echo 正在启动预约脚本...
echo.
echo ==================================================
echo.

echo ==================================================
echo.
echo              当前预约配置
echo.
echo ==================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "$j=[System.IO.File]::ReadAllText('%CONFIG%', [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF) | ConvertFrom-Json; Write-Host ('日期：' + $j.date); Write-Host ('开始时间：' + $j.startTime); Write-Host ('预约时长：' + $j.durationHours + ' 小时'); Write-Host ('优先房间：' + $j.preferredRooms[0]); Write-Host ('优先座位：' + $j.preferredSeat); Write-Host ('备用范围：' + $j.seatRange[0] + ' 到 ' + $j.seatRange[1])"

echo.
echo ==================================================
echo.

call node\npm.cmd run reserve > "%LOGFILE%" 2>&1

cls
color 0C

echo ==================================================
echo.
echo        HDU Library Reservation Assistant
echo.
echo ==================================================
echo.
echo 正在分析预约结果...
echo.

findstr /c:"预约成功" "%LOGFILE%" >nul

if %errorlevel%==0 (
    color 0A
    echo [预约结果] 预约成功！
    echo.
    findstr /c:"预约成功" "%LOGFILE%"
) else (
    color 0C
    echo [预约结果] 预约失败或未检测到成功信息。
    echo.
    echo 关键失败信息：
    echo --------------------------------------------------
    findstr /i "error fail timeout syntax" "%LOGFILE%"
    echo --------------------------------------------------
)

echo.
echo 完整日志位置：
echo %LOGFILE%
echo.
echo ==================================================
echo.
pause
color 0A
goto MAIN_MENU


:HELP
cls

echo ==================================================
echo.
echo              使用说明
echo.
echo ==================================================
echo.
echo 1. 首次使用请先选择“登录系统”。
echo 2. 登录成功后会生成 storageState.json。
echo 3. 修改预约配置后，可查看当前配置确认。
echo 4. 开始预约后，请勿关闭窗口。
echo 5. 运行期间请勿让电脑进入睡眠。
echo 6. 如预约失败，请查看 logs 目录中的日志文件。
echo.
echo ==================================================
echo.
pause
goto MAIN_MENU


:EXIT_APP
cls
echo 已退出。
exit
```
