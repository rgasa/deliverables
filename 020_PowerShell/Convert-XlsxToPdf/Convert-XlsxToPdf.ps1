# --------------------------------------------------------------------
# Name          : Create-Excle.ps1
# Version       : 1.00
# Description   : Excel�t�@�C����PDF�t�@�C���ɕϊ�����B
# Author        : rogasawara
# Date          : 2020-9-13
# Update        :   
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# ���ϐ�
# --------------------------------------------------------------------
$TgtFileName   = "sample.xlsx";                                       # �ϊ��Ώۂ�Excel�t�@�C����
$PdfFileName   = "sample.pdf";                                        # �ϊ����PDF�t�@�C����

# --------------------------------------------------------------------
# ���C������
# --------------------------------------------------------------------

# �J�����g�f�B���N�g���̃Z�b�g
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);
# �J�����g�f�B���N�g���̎擾
$CurrentDir = $(Get-Location);

try {
    # Excel�I�u�W�F�N�g�̎擾
    $ExcelObj = New-Object -ComObject excel.Application;
    $ExcelObj.Visible = $false

    # �Ώۂ�Excel�t�@�C���̃I�[�v��
    $ExcelBook = $ExcelObj.Workbooks.open("$CurrentDir\$TgtFileName");
    $TgtSheet  = $ExcelBook.Worksheets.Item(1);

    # PDF�t�@�C���p�X
    $PdfFileDir = "$CurrentDir\$PdfFileName";

    $TgtSheet.ExportAsFixedFormat(0, $PdfFileDir);

} finally {

    # ���[�N�u�b�N�̃N���[�Y
    $ExcelObj.Workbooks.Close();
    # Excel�̃N���[�Y
    $ExcelObj.Quit();
    # �I�u�W�F�N�g��Null�j��
    $ExcelObj , $TgtSheet | ForEach-Object{$_ = $null};
    [GC]::Collect();

}