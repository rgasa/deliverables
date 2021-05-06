# --------------------------------------------------------------------
# Name          : Env.ps1
# Version       : 1.00
# Description   : ���ϐ��t�@�C���B
# Author        : rogasawara
# Date          : 2021-04-20
# Update        :
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# �萔
# --------------------------------------------------------------------
$BASE_DIR=Split-Path $MyInvocation.MyCommand.Path -Parent             # �X�N���v�g���g�̃f�B���N�g��
$LOG_FILE=$(Get-Date -UFormat %Y%m%d.log)                             # ���O�t�@�C����
$LOG_FILE_DIR=$BASE_DIR+"\log"                                        # ���O�t�@�C���̊i�[�f�B���N�g��

# --------------------------------------------------------------------
# ���ϐ�
# --------------------------------------------------------------------
[string]$SrcDbHost      = 'localhost'
[string]$SrcDbPort      = '3306'
[string]$SrcDb          = 'dev01'
[string]$SrcDbUser      = 'dev01'
[string]$SrcDbPassword  = 'dev01'

[string]$RmtDbHost      = 'localhost'
[string]$RmtDbPort      = '3306'
[string]$RmtDb          = 'dev01'
[string]$RmtDbUser      = 'dev01'
[string]$RmtDbPassword  = 'dev01'

# --------------------------------------------------------------------
# ���ʊ֐�
# --------------------------------------------------------------------

# ���O�o�͊֐� 
Function Write-Log( $_msg, $_file_name )
{
    # ���s�����̎擾
    $exeDateTime=Get-Date -UFormat "%Y-%m-%d %H:%M:%S";
    
    # ���O�t�@�C���i�[�f�B���N���̑��݃`�F�b�N
    if(!$(Test-Path "$LOG_FILE_DIR")){
      New-Item $LOG_FILE_DIR -ItemType Directory;
    }
    
    # ���O�t�@�C���ւ̏�������
    "[ $exeDateTime ] $_file_name $_msg " >> "$LOG_FILE_DIR\$LOG_FILE";
}