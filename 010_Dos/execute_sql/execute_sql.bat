@echo off
SETLOCAL enabledelayedexpansion
rem --------------------------------------------------------
rem 環境変数
rem --------------------------------------------------------
rem Oracleユーザ
set LoginUser="ora01"
rem Oracleパスワード
set LoginPassword="ora01"
rem Oracleネットサービス名
set NetServiceName="ORCL"
rem sqlファイルのディレクトリ
set SqlFileDir="sql"
rem ログファイルの出力先
set LogFileDir="log"
rem ログファイル拡張子
set LogFileExtension=".log"
rem ログファイル名
set LogFileName=%DATE:/=%%LogFileExtension%

echo -------------------------------------------------------
echo script自身のディレクトリにチェンジディレクトリ
echo -------------------------------------------------------
cd %~dp0

if !errorlevel! equ 0 (
  echo:
  echo: "...チェンジディレクトリ成功。"
  echo:
) else (
  echo:
  echo: "...チェンジディレクトリ失敗。"
  echo: "処理を終了します。"
  echo:
  pause
  exit /b
)

echo -------------------------------------------------------
echo ディレクトリの存在チェック
echo -------------------------------------------------------
if exist ".\%SqlFileDir%" (
  echo:
  echo: "...[%SqlFileDir%]が存在します。"
  echo:
) else (
  echo:
  echo: "...[%SqlFileDir%]が存在しません。"
  echo: "処理を終了します。"
  echo:
  pause
  exit /b
) 

if not exist ".\%LogFileDir%" (
  mkdir %LogFileDir%
  
  if !errorlevel! equ 0 (
    echo:
    echo: "[%LogFileDir%]を作成しました。"
    echo:
  )
)

echo -------------------------------------------------------
echo 実行用のsqlファイルの作成
echo -------------------------------------------------------
for /f "usebackq tokens=*" %%i in (`dir /s /b /o:g .\%SqlFileDir%\*.sql`) do (
  type %%i >> tmp.sql
  
  if !errorlevel! equ 0 (
  	echo:
  	echo: "%%iの書き込み成功。"
  	echo:
  ) else (
  	echo:
  	echo: "%%iの書き込み失敗。"
  	echo: "処理を終了します。"
  	echo:
  	pause
  	exit /b
  )
  
  echo: >> tmp.sql
)

echo exit >> tmp.sql

echo -------------------------------------------------------
echo データベース接続
echo -------------------------------------------------------
sqlplus %LoginUser%/%LoginPassword%@%NetServiceName% @.\tmp.sql >>.\%LogFileDir%\%LogFileName%

if !errorlevel! equ 0 (
 echo:
 echo: "...sqlファイル実行成功。"
 echo: "詳細は、%LogFileDir%\%LogFileName%を参照ください。"
 echo:
) else (
 echo:
 echo: "...sqlファイル実行失敗。"
 echo: "処理を終了します。"
 echo:
 pause
 exit /b
)

echo -------------------------------------------------------
echo 実行用のsqlファイルの削除
echo -------------------------------------------------------
erase .\tmp.sql

if !errorlevel! equ 0 (
 echo:
 echo: "...sqlファイルの削除成功。"
 echo:
) else (
 echo:
 echo: "...sqlファイルの削除失敗。"
 echo: "処理を終了します。"
 echo:
 pause
 exit /b
)

echo "処理が完了しました。"

pause
exit /b
