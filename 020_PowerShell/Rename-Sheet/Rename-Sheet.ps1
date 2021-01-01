# --------------------------------------------------------------------
# Name          : Rename-Sheet.ps1
# Version       : 1.00
# Description   : Excelのシートをリネームする。
# Pram1         : リネーム前のシート名
# Pram2         : リネーム後のシート名
# Author        : rogasawara
# Date          : 2020-10-09
# Update        :
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# 引数チェック
# --------------------------------------------------------------------
param(
    [Parameter(mandatory=$true)][ValidateNotNullOrEmpty()][String]$OrgSheet ,
    [parameter(mandatory=$true)][ValidateNotNullOrEmpty()][String]$RenameSheet
)

# --------------------------------------------------------------------
# 環境変数
# --------------------------------------------------------------------
$TGT_FILE_EXT      = "*.xlsx"
$RENAME_FILE_FLD   = "RenameSheetFile"

# --------------------------------------------------------------------
# メイン処理
# --------------------------------------------------------------------

# カレントディレクトリのセット
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);
# カレントディレクトリの取得
$CurrentDir = $(Get-Location);

try {

    # ファイル一覧の取得
    $FileList=Get-ChildItem -File $CurrentDir -Filter $TGT_FILE_EXT | Sort-Object { $_.Name };

    # ファイルが存在しない場合
    if($FileList -eq $null) {
        Write-Host "対象のファイルが存在しません。処理を終了します・・・。"
        exit
    }

    # Excelオブジェクトの生成
    $ExcelObj = New-Object -ComObject Excel.Application;
    $ExcelObj.Visible = $false;

    # 対象ファイルへの処理
    $ind = 1;
    foreach ($file in $FileList) {
        # 対象のファイルのオープン
        $TgtFile = $ExcelObj.Workbooks.Open("$CurrentDir\$file" , $null, $true);

        # 対象シートの設定
        $WorkSheet = $ExcelObj.Worksheets.Item($OrgSheet);
        # 対象シートのリネーム
        $WorkSheet.Name = $RenameSheet;
        # リネームファイルの保存
        $TgtFile.SaveAs("$CurrentDir\$RENAME_FILE_FLD\$file");

        $TgtFile = $null;
    }
 } finally {
    
    # ワークブックのクローズ
    $ExcelObj.Workbooks.Close();
    #Excelのクローズ
    $ExcelObj.Quit();

    $ExcelObj , $WorkBook , $TgtFile | ForEach-Object{$_ = $null};
    [GC]::Collect();
}