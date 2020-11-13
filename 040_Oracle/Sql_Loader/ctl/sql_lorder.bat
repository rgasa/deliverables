@echo off
SETLOCAL enabledelayedexpansion
rem --------------------------------------------------------
rem name        : sql_lorderl.bat
rem version     : 1.00
rem description : SQL*Lorder実行バッチ
rem author      : rogasawara
rem date        : 2020-10-03
rem --------------------------------------------------------

rem --------------------------------------------------------
rem 環境変数
rem --------------------------------------------------------
set user_id="ora01"
set password="ora01"
set tns_names_ora="orcl"
set ctl_file="test_data.ctl"

rem --------------------------------------------------------
rem メイン処理
rem --------------------------------------------------------
rem チェンジディレクトリ
cd %~dp0

rem SQL*Lorderの実行
sqlldr userid=%user_id%/%password%@%tns_names_ora% control=%ctl_file%

pause