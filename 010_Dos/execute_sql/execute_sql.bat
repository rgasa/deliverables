@echo off
SETLOCAL enabledelayedexpansion
rem --------------------------------------------------------
rem ���ϐ�
rem --------------------------------------------------------
rem Oracle���[�U
set LoginUser="ora01"
rem Oracle�p�X���[�h
set LoginPassword="ora01"
rem Oracle�l�b�g�T�[�r�X��
set NetServiceName="ORCL"
rem sql�t�@�C���̃f�B���N�g��
set SqlFileDir="sql"
rem ���O�t�@�C���̏o�͐�
set LogFileDir="log"
rem ���O�t�@�C���g���q
set LogFileExtension=".log"
rem ���O�t�@�C����
set LogFileName=%DATE:/=%%LogFileExtension%

echo -------------------------------------------------------
echo script���g�̃f�B���N�g���Ƀ`�F���W�f�B���N�g��
echo -------------------------------------------------------
cd %~dp0

if !errorlevel! equ 0 (
  echo:
  echo: "...�`�F���W�f�B���N�g�������B"
  echo:
) else (
  echo:
  echo: "...�`�F���W�f�B���N�g�����s�B"
  echo: "�������I�����܂��B"
  echo:
  pause
  exit /b
)

echo -------------------------------------------------------
echo �f�B���N�g���̑��݃`�F�b�N
echo -------------------------------------------------------
if exist ".\%SqlFileDir%" (
  echo:
  echo: "...[%SqlFileDir%]�����݂��܂��B"
  echo:
) else (
  echo:
  echo: "...[%SqlFileDir%]�����݂��܂���B"
  echo: "�������I�����܂��B"
  echo:
  pause
  exit /b
) 

if not exist ".\%LogFileDir%" (
  mkdir %LogFileDir%
  
  if !errorlevel! equ 0 (
    echo:
    echo: "[%LogFileDir%]���쐬���܂����B"
    echo:
  )
)

echo -------------------------------------------------------
echo ���s�p��sql�t�@�C���̍쐬
echo -------------------------------------------------------
for /f "usebackq tokens=*" %%i in (`dir /s /b /o:g .\%SqlFileDir%\*.sql`) do (
  type %%i >> tmp.sql
  
  if !errorlevel! equ 0 (
  	echo:
  	echo: "%%i�̏������ݐ����B"
  	echo:
  ) else (
  	echo:
  	echo: "%%i�̏������ݎ��s�B"
  	echo: "�������I�����܂��B"
  	echo:
  	pause
  	exit /b
  )
  
  echo: >> tmp.sql
)

echo exit >> tmp.sql

echo -------------------------------------------------------
echo �f�[�^�x�[�X�ڑ�
echo -------------------------------------------------------
sqlplus %LoginUser%/%LoginPassword%@%NetServiceName% @.\tmp.sql >>.\%LogFileDir%\%LogFileName%

if !errorlevel! equ 0 (
 echo:
 echo: "...sql�t�@�C�����s�����B"
 echo: "�ڍׂ́A%LogFileDir%\%LogFileName%���Q�Ƃ��������B"
 echo:
) else (
 echo:
 echo: "...sql�t�@�C�����s���s�B"
 echo: "�������I�����܂��B"
 echo:
 pause
 exit /b
)

echo -------------------------------------------------------
echo ���s�p��sql�t�@�C���̍폜
echo -------------------------------------------------------
erase .\tmp.sql

if !errorlevel! equ 0 (
 echo:
 echo: "...sql�t�@�C���̍폜�����B"
 echo:
) else (
 echo:
 echo: "...sql�t�@�C���̍폜���s�B"
 echo: "�������I�����܂��B"
 echo:
 pause
 exit /b
)

echo "�������������܂����B"

pause
exit /b
