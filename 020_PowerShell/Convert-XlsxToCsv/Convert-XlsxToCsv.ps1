# --------------------------------------------------------------------
# Name          : Convert-XlsxToCsv.ps1
# Version       : 1.00
# Description   : ExcelファイルをCSVファイルに変換する。
# Author        : rogasawara
# Date          : 2020-09-12
# Update        :   
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# 環境変数
# --------------------------------------------------------------------
$ExcelName    = "sample.xlsx"
$TgtSheet     = "Sheet1"
$CsvName      = "sample.csv"

# --------------------------------------------------------------------
# メイン処理
# --------------------------------------------------------------------

# カレントディレクトリのセット
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);

# カレントディレクトリの取得
$CurrentDir = $(Get-Location);
try {

    # Excelオブジェクトの生成
    $ExcelObj = New-Object -ComObject Excel.Application;
    $ExcelObj.Visible = $false;

    # 対象のExcelファイルのオープン
    $ExcelBook = $ExcelObj.Workbooks.open("$CurrentDir\$ExcelName");

    # 対象シートの設定
    $WorkSheet = $ExcelObj.Worksheets.Item($TgtSheet);
    # Excleの書式の設定
    $Range = $WorkSheet.Range("A2:A10");
    # 書式を[文字列]に設定
    $Range.NumberFormatLocal = "@";

    # 書式の反映
    $i = 2;
    While($WorkSheet.Cells.Item($i,"A").Text -ne ""){

        $WorkSheet.Cells.Item($i,"A").Formula  = $WorkSheet.Cells.Item($i,"A").Formula;

        $i++;
    }

    # Excelファイルの保存
    $ExcelBook.Save();
    # Csvファイルとして保存
    $WorkSheet.SaveAs("$CurrentDir\$CsvName",6);

} finally {

    # ワークブックのクローズ
    $ExcelObj.Workbooks.Close();
    # Excelのクローズ
    $ExcelObj.Quit();
    # オブジェクトのNull破棄
    $ExcelObj , $WorkSheet , $Range| ForEach-Object{$_ = $null};
    [GC]::Collect()

}