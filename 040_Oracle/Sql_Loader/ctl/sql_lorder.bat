@echo off
SETLOCAL enabledelayedexpansion
rem --------------------------------------------------------
rem name        : sql_lorderl.bat
rem version     : 1.00
rem description : SQL*Lorder���s�o�b�`
rem author      : rogasawara
rem date        : 2020-10-03
rem --------------------------------------------------------

rem --------------------------------------------------------
rem ���ϐ�
rem --------------------------------------------------------
set user_id="ora01"
set password="ora01"
set tns_names_ora="orcl"
set ctl_file="test_data.ctl"

rem --------------------------------------------------------
rem ���C������
rem --------------------------------------------------------
rem �`�F���W�f�B���N�g��
cd %~dp0

rem SQL*Lorder�̎��s
sqlldr userid=%user_id%/%password%@%tns_names_ora% control=%ctl_file%

pause