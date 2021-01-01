# --------------------------------------------------------------------
# Name          : Rename-Sheet.ps1
# Version       : 1.00
# Description   : Excel�̃V�[�g�����l�[������B
# Pram1         : ���l�[���O�̃V�[�g��
# Pram2         : ���l�[����̃V�[�g��
# Author        : rogasawara
# Date          : 2020-10-09
# Update        :
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# �����`�F�b�N
# --------------------------------------------------------------------
param(
    [Parameter(mandatory=$true)][ValidateNotNullOrEmpty()][String]$OrgSheet ,
    [parameter(mandatory=$true)][ValidateNotNullOrEmpty()][String]$RenameSheet
)

# --------------------------------------------------------------------
# ���ϐ�
# --------------------------------------------------------------------
$TGT_FILE_EXT      = "*.xlsx"
$RENAME_FILE_FLD   = "RenameSheetFile"

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

    # �Ώۃt�@�C���ւ̏���
    $ind = 1;
    foreach ($file in $FileList) {
        # �Ώۂ̃t�@�C���̃I�[�v��
        $TgtFile = $ExcelObj.Workbooks.Open("$CurrentDir\$file" , $null, $true);

        # �ΏۃV�[�g�̐ݒ�
        $WorkSheet = $ExcelObj.Worksheets.Item($OrgSheet);
        # �ΏۃV�[�g�̃��l�[��
        $WorkSheet.Name = $RenameSheet;
        # ���l�[���t�@�C���̕ۑ�
        $TgtFile.SaveAs("$CurrentDir\$RENAME_FILE_FLD\$file");

        $TgtFile = $null;
    }
 } finally {
    
    # ���[�N�u�b�N�̃N���[�Y
    $ExcelObj.Workbooks.Close();
    #Excel�̃N���[�Y
    $ExcelObj.Quit();

    $ExcelObj , $WorkBook , $TgtFile | ForEach-Object{$_ = $null};
    [GC]::Collect();
}