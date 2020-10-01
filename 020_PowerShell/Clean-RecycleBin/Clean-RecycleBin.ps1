#-----------------------------------------------------------
# Name          : Clean-RecycleBin.ps1
# Version       : 1.00
# Description   : �S�~���̒��g�̍폜���s���B
# Author        : rogasawara
# Date          : 2019-10-01
# Update        : 
#-----------------------------------------------------------

#-----------------------------------------------------------
# ���ϐ�
#-----------------------------------------------------------
$SCRIPT_NAME=$MyInvocation.MyCommand.name                   # �X�N���v�g��
$BASE_DIR=Split-Path $MyInvocation.MyCommand.Path -Parent   # �X�N���v�g���g�̃f�B���N�g��
$LOG_FILE=$(Get-Date -UFormat %Y%m%d.log)                   # ���O�t�@�C����
$LOG_FILE_DIR=$BASE_DIR+"\log"                              # ���O�t�@�C���̊i�[�f�B���N�g��

#-----------------------------------------------------------
# �e�폈��
#-----------------------------------------------------------
Function Write-Log( $_msg )
{
    # ���s�����̎擾
    $exeDateTime=Get-Date -UFormat "%Y-%m-%d %H:%M:%S";
    
    # ���O�t�@�C���i�[�f�B���N��̑��݃`�F�b�N
    if(!$(Test-Path "$LOG_FILE_DIR")){
      New-Item $LOG_FILE_DIR -ItemType Directory;
    }
    # ���O�t�@�C���ւ̏�������
    "$exeDateTime $SCRIPT_NAME $_msg " >> "$LOG_FILE_DIR\$LOG_FILE";
}

#-----------------------------------------------------------
# Main����
#-----------------------------------------------------------
#�X�N���v�g���g�f�B���N�g���Ɉړ�
Set-Location $BASE_DIR;

#�J�n���O�̏o��
Write-Log "[Start]";

try {
    #�I�u�W�F�N�g�̐���
    $shell = New-Object -ComObject Shell.Application;
    $trash = $shell.NameSpace(10).Items();

    if($trash.Count -le 0){
        #�S�~���̒��g��0���̏ꍇ
        Write-Log "[Remove TargetFile NotExist]";
    }else{

        #�폜�Ώۃt�@�C���������O�t�@�C���ɏo��
        Write-Log "[=========== Remove TargetFile List =============]";
        $trash | % {Write-Log $_.Name};
        Write-Log "[=========== Remove TargetFile List =============]";

        #�S�~���̒��g���폜
        Clear-RecycleBin -Force;
    }
} catch {
    #�G���[���O�̏o��
    Write-Log $Error[0].exception;

} finally {
    #�I�u�W�F�N�g�̔j��
    $shell,$trash | % {$_ = $null};
    #�I�����O�̏o��
    Write-Log "[End]";
}