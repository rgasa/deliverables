# --------------------------------------------------------------------
# Name          : Main.ps1
# Version       : 1.00
# Description   : �f�[�^�A�g��Main�����B
# Author        : rogasawara
# Date          : 2021-04-20
# Update        :
# --------------------------------------------------------------------

# script���̎擾
$ScriptName = $MyInvocation.MyCommand.name
# �J�����g�f�B���N�g���̃Z�b�g
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);
# �J�����g�f�B���N�g���̎擾
$CurrentDir = $(Get-Location);

# Env�t�@�C���̓Ǎ�
.".\Env.ps1"

# �J�n���O
$Msg = "Procees Start...!!!"
Write-Log $Msg $ScriptName

# CSV�o�͏����J�n
powershell -ExecutionPolicy RemoteSigned .\Output-Csv.ps1

# Delete ����� CSV Import����
powershell -ExecutionPolicy RemoteSigned .\Delete-Import.ps1

# �I�����O
$Msg = "Procees End...!!!"
Write-Log $Msg $ScriptName