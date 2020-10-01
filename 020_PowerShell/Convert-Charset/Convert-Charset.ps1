#-----------------------------------------------------------
# Name          : Convert-Charset.ps1
# Version       : 1.00
# Description   : �����R�[�h��UTF8�֕ϊ�����B
# Author        : rogasawara
# Date          : 2020-08-10
#-----------------------------------------------------------

#-----------------------------------------------------------
# ���ϐ�
#-----------------------------------------------------------
$BASE_DIR=Split-Path $MyInvocation.MyCommand.Path -parent;  # �X�N���v�g�̃f�B���N�g��
$OUTPUT_FOLDER="out";                                       # �A�E�g�v�b�g��̃t�H���_��
$TGT_DIR="file";                                            # �ϊ��Ώۂ̃t�@�C����z�u����t�H���_

#----------------------------------------------------------
# ���C������
#----------------------------------------------------------
Set-Location $BASE_DIR

#�t�@�C���ꗗ�̎擾
$FileList=Get-ChildItem -File $TGT_DIR;

if($FileList -eq $null) {
    Write-Host "�Ώۂ̃t�@�C�������݂��܂���B"
    Read-Host "�������I�����܂��B Enter�L�[�������Ă�������..."
    exit
}

foreach ($file in $FileList) {
    #�����R�[�h�̕ϊ�
    Get-Content ".\$TGT_DIR\$file" | Set-Content -Encoding UTF8 ".\$OUTPUT_FOLDER\$file";

    #���۔���
    if($?) {
        Write-Host "$TGT_DIR\$file �̕ϊ����������I�I"
     }else{
        Write-Host "$TGT_DIR\$file �̕ϊ��������s�I�I"
     }
}

Read-Host "�������I�����܂��B Enter�L�[�������Ă�������..."
