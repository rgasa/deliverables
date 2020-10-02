@echo off
SETLOCAL enabledelayedexpansion

cd %~dp0

set cnt=0
set input_val=
 
:loop
if %cnt%==3 goto endloop
  set /a cnt+=1
  set /P input_val="成人ですか？[y]/[n] : "
  if "%input_val%" == "y" (
    echo:
    echo "あなたは成人ですね！！"
    goto :eof
  ) else if "%input_val%" == "n" (
    echo:
    echo "あなたは未成年ですね！！"
    goto :eof
  ) else (
    echo:
    echo "[y]また[n]を入力してください！！"
  )
goto loop

:endloop
echo:
echo "3回入力に失敗したいしたので、処理を終了します・・・"
pause 