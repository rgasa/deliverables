@echo off
SETLOCAL enabledelayedexpansion
rem ----------------------------------------------
rem name        : startUpVagrant.bat
rem version     : 1.00
rem description : Vagrant�N���o�b�`
rem author      : rogasawara
rem date        : 2019-07-30
rem ----------------------------------------------

rem ----------------------------------------------
rem ���ݒ�
rem ----------------------------------------------
set vagrant_work_dir=""

rem Vagrant��Work�X�y�[�X�փ`�F���W�f�B���N�g��
cd %vagrant_work_dir%

rem Vagrant�̋N��
vagrant suspend

exit