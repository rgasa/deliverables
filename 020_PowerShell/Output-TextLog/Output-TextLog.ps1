# ----------------------------------------------------------
# ���ϐ�
# ----------------------------------------------------------

$SCRIPT_NAME=$MyInvocation.MyCommand.name                   # �X�N���v�g��
$BASE_DIR=Split-Path $MyInvocation.MyCommand.Path -Parent   # �X�N���v�g���g�̃f�B���N�g��
$LOG_FILE=$(Get-Date -UFormat %Y%m%d.log)                   # ���O�t�@�C����
$LOG_FILE_DIR=$BASE_DIR+"\log"                              # ���O�t�@�C���̊i�[�f�B���N�g��


# ----------------------------------------------------------
# ���O�o�͊֐�
# ----------------------------------------------------------
Function Write-Log( $_msg )
{
    # ���s�����̎擾
    $exeDateTime=Get-Date -UFormat "%Y-%m-%d %H:%M:%S";
    
    # ���O�t�@�C���i�[�f�B���N���̑��݃`�F�b�N
    if(!$(Test-Path "$LOG_FILE_DIR")){
      New-Item $LOG_FILE_DIR -ItemType Directory;
    }
    
    # ���O�t�@�C���ւ̏�������
    "$exeDateTime $SCRIPT_NAME $_msg " >> "$LOG_FILE_DIR\$LOG_FILE";
}

# ----------------------------------------------------------
# Main����
# ----------------------------------------------------------
# �J�����g�f�B���N�g�����X�N���v�g���g�̃f�B���N�g���ɃZ�b�g
Set-Location $BASE_DIR

# �J�n���O�̏o��
Write-Log "[Start]";

# Main�������L�q�E�E�E
Write-Log "[Main�����E�E�E]";

# �I�����O�̏o��
Write-Log "[End]";
