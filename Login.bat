@echo off
title HDU Library Reservation Assistant
color 0A

set CORE=%~dp0HDUlib_Reserve-main

cd /d "%CORE%"

set PATH=%CORE%\node;%PATH%
set PLAYWRIGHT_BROWSERS_PATH=0

cls
echo ==================================================
echo.
echo        HDU Library Reservation Assistant
echo.
echo ==================================================
echo.
echo 即将打开登录浏览器。
echo.
echo 登录完成并进入预约系统后，请回到本窗口继续。
echo.
echo ==================================================
echo.

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