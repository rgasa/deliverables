#-----------------------------------------------------------
# Name        : Move-OldFile.ps1
# Version     : 1.00
# Description : �X�V���t���Â��t�@�C�����ړ�����B
# Author      : rogasawara
# Date        : 2019-12-09
# Update      :
#-----------------------------------------------------------
#-----------------------------------------------------------
# ���ϐ�
#-----------------------------------------------------------
$TARGET_DIR="�ړ��Ώۂ̃t�@�C���̃f�B���N�g��";
$BACKUP_DIR="�ړ���̃f�B���N�g��";
$HOLD_PERIOD=3;                                             #�t�@�C���ۗ̕L����(��)
 
#-----------------------------------------------------------
# Main����
#-----------------------------------------------------------

# �J�����g�f�B���N�g���ɃX�N���v�g���A�i�[����Ă���f�B���N�g���ɃZ�b�g
Set-Location (Split-Path $MyInvocation.MyCommand.Path -parent);
 
#�t�@�C���ێ��̊���̎擾
$limitDay=(Get-Date).AddMonths(-$HOLD_PERIOD).ToString('yyyyMMdd');
 
#���ݓ��t�̎擾
$sysData=Get-Date -UFormat "%Y%m%d%H%M%S";
 
#�t�@�C���̈ꗗ���擾
$fileList=Get-ChildItem -File $TARGET_DIR;
 
#�Ώۂ̃t�@�C�������݂��Ȃ��ꍇ
if ($fileList -eq $null){
    Write-Host "�Ώۂ̃t�@�C�������݂��܂���B";
    Read-Host "�������I�����܂��B Enter�L�[�������Ă�������..."
    exit
}
 
foreach($file in $fileList){
    #�t�@�C���̍ŏI�X�V���̎擾
    $updDay=$file.LastWriteTime.ToString('yyyyMMdd');
    
    #�t�@�C���̍X�V���t���ێ��̊���ȑO�̏ꍇ
    if($updDay -lt $limitDay){
        Move-Item "$TARGET_DIR\$file" "$BACKUP_DIR\$file$sysData";
        Write-Host "$TARGET_DIR\$file �� $BACKUP_DIR �ֈړ����܂����B";
    }
}
exit
