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
rem Vagrantのベースディレクトリ
set vagrant_work_dir=""

rem ----------------------------------------------
rem Main処理
rem ----------------------------------------------
rem VagrantのWorkスペースへチェンジディレクトリ
cd %vagrant_work_dir%

rem vagrantの起動
vagrant up

exit