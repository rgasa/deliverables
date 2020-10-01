# --------------------------------------------------------------------
# Name          : Join-Excel.ps1
# Version       : 1.00
# Description   : �����t�@�C����Excel����e����������Excel�t�@�C���𐶐�����B
# Author        : rogasawara
# Date          : 2020-09-26
# Update        :   
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# ���ϐ�
# --------------------------------------------------------------------
$OUTPUT_EXCEL_NAME = "1H.xlsx"
$OUTPUT_SHEET_NAME = "1H"
$TGT_FILE_EXT      = "*.xlsx"

# --------------------------------------------------------------------
# ���C������
# --------------------------------------------------------------------

# �J�����g�f�B���N�g���̃Z�b�g
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);
# �J�����g�f�B���N�g���̎擾
$CurrentDir = $(Get-Location);

try {

    # �t�@�C���ꗗ�̎擾
    $FileList=Get-ChildItem -File $CurrentDir -Filter $TGT_FILE_EXT | Sort-Object { $_.Name };

    # �t�@�C�������݂��Ȃ��ꍇ
    if($FileList -eq $null) {
        Write-Host "�Ώۂ̃t�@�C�������݂��܂���B�������I�����܂��E�E�E�B"
        exit
    }

    # Excel�I�u�W�F�N�g�̐���
    $ExcelObj = New-Object -ComObject Excel.Application;
    $ExcelObj.Visible = $false;

    # �A�E�g�v�b�g�t�@�C���̍쐬
    $WorkBook = $ExcelObj.Workbooks.Add();

    # �Ώۃt�@�C���ւ̏���
    $ind = 1;
    foreach ($file in $FileList) {
        # �Ώۂ̃t�@�C���̃I�[�v��
        $TgtFile = $ExcelObj.Workbooks.Open("$CurrentDir\$file" , $null, $true);

        # �Ώۂ̃t�@�C���̃V�[�g�����擾
        $SheetInd = $TgtFile.worksheets.count;

        for ($i = 1; $i -le $SheetInd; $i++) {
            # �o�͗p�t�@�C���ɑΏۂ̃V�[�g���R�s�[
            $TgtFile.worksheets.item($i).copy($WorkBook.worksheets.item($ind));

            $ind ++;
        }
        $TgtFile = $null;
    }

    # �s�v�V�[�g�폜
    $WorkBook.worksheets.item("sheet1").delete();
    # ���[�N�u�b�N�̕ۑ�
    $WorkBook.SaveAs("$CurrentDir\$OUTPUT_EXCEL_NAME");

} finally {
    
    # ���[�N�u�b�N�̃N���[�Y
    $ExcelObj.Workbooks.Close();
    #Excel�̃N���[�Y
    $ExcelObj.Quit();

    $ExcelObj , $WorkBook , $TgtFile | ForEach-Object{$_ = $null};
    [GC]::Collect();
}