@echo off
SETLOCAL enabledelayedexpansion

cd %~dp0

set cnt=0
set input_val=
 
:loop
if %cnt%==3 goto endloop
  set /a cnt+=1
  set /P input_val="���l�ł����H[y]/[n] : "
  if "%input_val%" == "y" (
    echo:
    echo "���Ȃ��͐��l�ł��ˁI�I"
    goto :eof
  ) else if "%input_val%" == "n" (
    echo:
    echo "���Ȃ��͖����N�ł��ˁI�I"
    goto :eof
  ) else (
    echo:
    echo "[y]�܂�[n]����͂��Ă��������I�I"
  )
goto loop

:endloop
echo:
echo "3����͂Ɏ��s�����������̂ŁA�������I�����܂��E�E�E"
pause 