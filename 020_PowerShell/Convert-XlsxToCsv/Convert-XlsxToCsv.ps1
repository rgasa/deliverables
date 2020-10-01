# --------------------------------------------------------------------
# Name          : Convert-XlsxToCsv.ps1
# Version       : 1.00
# Description   : Excel�t�@�C����CSV�t�@�C���ɕϊ�����B
# Author        : rogasawara
# Date          : 2020-09-12
# Update        :   
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# ���ϐ�
# --------------------------------------------------------------------
$ExcelName    = "sample.xlsx"
$TgtSheet     = "Sheet1"
$CsvName      = "sample.csv"

# --------------------------------------------------------------------
# ���C������
# --------------------------------------------------------------------

# �J�����g�f�B���N�g���̃Z�b�g
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);

# �J�����g�f�B���N�g���̎擾
$CurrentDir = $(Get-Location);
try {

    # Excel�I�u�W�F�N�g�̐���
    $ExcelObj = New-Object -ComObject Excel.Application;
    $ExcelObj.Visible = $false;

    # �Ώۂ�Excel�t�@�C���̃I�[�v��
    $ExcelBook = $ExcelObj.Workbooks.open("$CurrentDir\$ExcelName");

    # �ΏۃV�[�g�̐ݒ�
    $WorkSheet = $ExcelObj.Worksheets.Item($TgtSheet);
    # Excle�̏����̐ݒ�
    $Range = $WorkSheet.Range("A2:A10");
    # ������[������]�ɐݒ�
    $Range.NumberFormatLocal = "@";

    # �����̔��f
    $i = 2;
    While($WorkSheet.Cells.Item($i,"A").Text -ne ""){

        $WorkSheet.Cells.Item($i,"A").Formula  = $WorkSheet.Cells.Item($i,"A").Formula;

        $i++;
    }

    # Excel�t�@�C���̕ۑ�
    $ExcelBook.Save();
    # Csv�t�@�C���Ƃ��ĕۑ�
    $WorkSheet.SaveAs("$CurrentDir\$CsvName",6);

} finally {

    # ���[�N�u�b�N�̃N���[�Y
    $ExcelObj.Workbooks.Close();
    # Excel�̃N���[�Y
    $ExcelObj.Quit();
    # �I�u�W�F�N�g��Null�j��
    $ExcelObj , $WorkSheet , $Range| ForEach-Object{$_ = $null};
    [GC]::Collect()

}