**Rain-HDU-LSRA**

HDU Library Reservation Assistant

一个基于 Node.js 与 Playwright 的图书馆自动预约工具。
本项目在原始预约脚本基础上，增加了集成式菜单终端、图形化流程管理与配置系统，适合作为直接可运行的桌面工具使用。

Features
集成登录、配置、预约流程
菜单式终端交互
自动保存登录状态
支持修改预约日期、时间、房间、座位
支持预约前配置确认
自动倒计时启动
自动生成日志文件
内置 Node.js 与 Playwright 浏览器环境
Release 解压后可直接运行

**Quick Start**
1. Download Release

Download the latest release package from GitHub Releases.

2. Run Main.bat

Double click: Main.bat

3. Login

Select:

 1. 登录系统

A browser window will open automatically.

Complete the HDU unified authentication login.

After entering the library reservation page successfully, return to the terminal window.

If storageState.json is generated inside:

HDUlib_Reserve-main

the login state has been saved successfully.

Reservation Workflow


2. 修改预约配置

Supported configuration items:

Date
Start time
Duration
Preferred room
Preferred seat
Backup seat range

Step 1

Check current configuration:


3. 查看当前配置

Step 2

Start reservation:


4. 开始预约

The script will:
display current configuration
wait until reservation launch time
automatically execute reservation
generate log files
analyze reservation result automatically
Notes
Do not close the terminal window during reservation.
Keep the computer awake.
Stable network connection is recommended.
VPN or proxy software may interfere with login.
If login browser closes immediately, try disabling accelerator/VPN software.

Logs

All runtime logs are stored in:

HDUlib_Reserve-main/logs

Main configuration file:

requests/default.json

Encoding requirement:

UTF-8

Otherwise Node.js may fail to parse JSON correctly.

Included Runtime Environment

This project already includes:

Node.js
Playwright
Chromium runtime

No additional installation is required.


**Disclaimer**

**The release package can run directly on most Windows x64 systems.**

**This project is intended for learning and personal use only.**

**Please comply with relevant school regulations and platform policies.**
