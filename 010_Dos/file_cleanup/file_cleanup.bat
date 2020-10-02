@echo off
SETLOCAL enabledelayedexpansion
rem ----------------------------------------------
rem ŠÂ‹«•Ï”
rem ----------------------------------------------
set backup_dir=".\backup" 
set tgt_dir=".\tgt_dir"

rem ----------------------------------------------
rem Mainˆ—
rem ----------------------------------------------
cd %~dp0

for /f "usebackq tokens=*" %%i in (`dir /s /b /a-d %tgt_dir%`) do (
	move %%i %backup_dir%
)

pause