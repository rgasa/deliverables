@echo off
SETLOCAL enabledelayedexpansion
rem --------------------------------------------------------
rem name        : dir_copy.bat
rem version     : 1.00
rem description : ディレクトリのコピーする。
rem author      : rogasawara
rem date        : 2020-03-20
rem --------------------------------------------------------

rem --------------------------------------------------------
rem Main処理
rem --------------------------------------------------------
cd %~dp0

rem 画面からの入力
set src_dir=
set tgt_dir=
set /P src_dir="コピー元のディレクトリを入力してください : "
echo:
set /P tgt_dir="コピー先のディレクトリを入力してください : "
echo:

xcopy /t /e %src_dir% %tgt_dir%

if !errorlevel! equ 0 (
  echo:
  echo ディレクトリのコピーが成功しました！！
  echo:
) else (
  echo:
  echo ディレクトリのコピーが失敗しました！！
  echo:
)

pause