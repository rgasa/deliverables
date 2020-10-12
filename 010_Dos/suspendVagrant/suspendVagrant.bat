@echo off
SETLOCAL enabledelayedexpansion
rem ----------------------------------------------
rem name        : startUpVagrant.bat
rem version     : 1.00
rem description : Vagrant起動バッチ
rem author      : rogasawara
rem date        : 2019-07-30
rem ----------------------------------------------

rem ----------------------------------------------
rem 環境設定
rem ----------------------------------------------
set vagrant_work_dir=""

rem VagrantのWorkスペースへチェンジディレクトリ
cd %vagrant_work_dir%

rem Vagrantの起動
vagrant suspend

exit