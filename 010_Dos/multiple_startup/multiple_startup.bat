@echo off
SETLOCAL enabledelayedexpansion
rem ----------------------------------------------
rem name        : multiple_startup.bat
rem version     : 1.00
rem description : 多重起動防止のサンプルコード
rem author      : rogasawara
rem date        : 2019-07-27
rem ----------------------------------------------
call :main %* 4>>%0
goto :eof

rem ----------------------------------------------
rem mani処理
rem ----------------------------------------------
:main

pause

exit/b
