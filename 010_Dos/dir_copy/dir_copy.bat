@echo off
SETLOCAL enabledelayedexpansion
rem --------------------------------------------------------
rem name        : dir_copy.bat
rem version     : 1.00
rem description : �f�B���N�g���̃R�s�[����B
rem author      : rogasawara
rem date        : 2020-03-20
rem --------------------------------------------------------

rem --------------------------------------------------------
rem Main����
rem --------------------------------------------------------
cd %~dp0

rem ��ʂ���̓���
set src_dir=
set tgt_dir=
set /P src_dir="�R�s�[���̃f�B���N�g������͂��Ă������� : "
echo:
set /P tgt_dir="�R�s�[��̃f�B���N�g������͂��Ă������� : "
echo:

xcopy /t /e %src_dir% %tgt_dir%

if !errorlevel! equ 0 (
  echo:
  echo �f�B���N�g���̃R�s�[���������܂����I�I
  echo:
) else (
  echo:
  echo �f�B���N�g���̃R�s�[�����s���܂����I�I
  echo:
)

pause