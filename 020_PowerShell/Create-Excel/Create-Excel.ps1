# --------------------------------------------------------------------
# Name          : Create-Excle.ps1
# Version       : 1.00
# Description   : Excel�t�@�C���̍쐬���s���B
# Author        : rogasawara
# Date          : 2020-09-19
# Update        :   
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# ���ϐ�
# --------------------------------------------------------------------
$OutputFileName   = "sample.xlsx";                                    # �o��Excel�t�@�C����
$OutputSheetName  = "sample";                                         # �o�̓V�[�g��
$OutputSheetName2 = "sample2";                                        # �o�̓V�[�g��2
$OutputSheetName3 = "sample3";                                        # �o�̓V�[�g��3

# --------------------------------------------------------------------
# ���C������
# --------------------------------------------------------------------

# �J�����g�f�B���N�g���̃Z�b�g
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);

try {
    # Excel�I�u�W�F�N�g�̎擾
    $ExcelObj = New-Object -ComObject excel.Application;
    $ExcelObj.Visible = $false

    # ���[�N�u�b�N�̍쐬
    $WorkBook = $ExcelObj.Workbooks.Add();

    # �V�[�g�̒ǉ�
    $WorkSheet = $ExcelObj.Worksheets.Item(1);
    $WorkSheet.Name = $OutputSheetName;

    # 2�V�[�g�ڂ̒ǉ�
    $WorkSheet2 = $WorkBook.Worksheets.Add([System.Reflection.Missing]::Value , $WorkSheet);
    $WorkSheet2.Name = $OutputSheetName2;

    # 3�V�[�g�ڂ̒ǉ�
    $WorkSheet3 = $WorkBook.Worksheets.Add([System.Reflection.Missing]::Value , $WorkSheet2);
    $WorkSheet3.Name = $OutputSheetName3;

    # �J�����g�f�B���N�g���̎擾
    $CurrentDir = Get-Location;

    # ���[�N�u�b�N�̕ۑ�
    $WorkBook.SaveAs("$CurrentDir\$OutputFileName");

} finally {

    #Excel�̃N���[�Y
    $ExcelObj.Quit();
    # �I�u�W�F�N�g��Null�j��
    $ExcelObj , $WorkBook , $WorkSheet2 ,$WorkSheet3 | ForEach-Object{$_ = $null};
    [GC]::Collect()
}
