#-----------------------------------------------------------
# Name         Create-Dir.ps1
# Version      1.00
# Description  �f�B���N�g���\�����쐬����X�N���v�g
# Author       rogasawara
# Date         2019-07-15
#-----------------------------------------------------------

#-----------------------------------------------------------
# ���ϐ�
#-----------------------------------------------------------
$rtnTrue=0                                                  # ���^�[���R�[�h(����I��)
$rtnFalse=1                                                 # ���^�[���R�[�h(�ُ�I��)
$scriptName=$MyInvocation.MyCommand.name                    # �X�N���v�g��
$logFile=$(Get-Date -UFormat %Y%m%d.log)                    # ���O�t�@�C����
$dirConfigFile="DirConfig.xlsx"                             # �f�B���N�g���\���ݒ�t�@�C��
$tgtSheet="dirConfig"                                       # �ǂݍ��ݑΏۃV�[�g

#--------------------------------------------------------
# �e�폈��
#--------------------------------------------------------
Function Write-Log( $msg ) {
    #���s���Ԃ̎擾
    $exeDateTime=Get-Date -UFormat "%Y-%m-%d %H:%M:%S";
    #���O�t�@�C���ւ̏�������
    "$exeDateTime $scriptName [$msg]" >> "$logFile";
}

#--------------------------------------------------------
# Main����
#--------------------------------------------------------
#�X�N���v�g���̂̃f�B���N�g�����J�����g�f�B���N�g���ɃZ�b�g
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);

#���^�[���R�[�h�̐ݒ�
$rtnCd=$rtnTrue;
#�J�n���O�̏o��
Write-Log "Start";

try {
    #�J�����g�f�B���N�g���̎擾
    $currentDir=$(Get-Location);

    #Excel�I�u�W�F�N�g�̐���
    $excel = New-Object -ComObject excel.Application;
    $excel.Visible = $false;

    #�Ώۂ�Excel��Sheet�̎擾
    $book = $excel.Workbooks.Open("$currentDir\$dirConfigFile");
    $sheet = $excel.Worksheets.item($tgtSheet);

    #Excel�t�@�C���̓ǂݍ���
    $i=2;
    While ($sheet.Cells.Item($i,1).Text -ne "") {
        $j=1;
        While ($sheet.Cells.Item($i,$j).Text -ne "") {

            if($j -eq 1){
                $tgtDir = $sheet.Cells.Item($i,$j).Text;
            }else{
                $tgtDir +="\" + $sheet.Cells.Item($i,$j).Text;
            }
            $j++;
        }
        $i++;

        #�f�B���N�g���̍쐬
        New-Item $tgtDir -ItemType Directory -Force;

        if($?) {
            #�f�B���N�g���̍쐬�����̃��O�̏�������
            Write-Log "Success mkdir $tgtDir";
        }else{
            #�f�B���N�g���̍쐬���s�̃��O�̏�������
            Write-Log "Faild mkdir $tgtDir";
            #���^�[���R�[�h�̐ݒ�
            $rtnCd=$rtnFalse;
        }
    }
} catch {
    #���^�[���R�[�h�̐ݒ�
    $rtnCd=$rtnFalse;
    #�G���[���O�̏o��
    Write-Log $error[0].exception;

} finally {
    #Excel�����
    $excel.Quit();
    #�I�u�W�F�N�g�̔j��
    $excel,$book,$sheet | ForEach-Object{$_ = $null};

}

#�I�����O�̏o��
Write-Log "End";
#�����̏I��
exit;