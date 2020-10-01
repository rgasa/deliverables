# --------------------------------------------------------------------
# Name          : Create-Excle.ps1
# Version       : 1.00
# Description   : Excelファイルの作成を行う。
# Author        : rogasawara
# Date          : 2020-09-19
# Update        :   
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# 環境変数
# --------------------------------------------------------------------
$OutputFileName   = "sample.xlsx";                                    # 出力Excelファイル名
$OutputSheetName  = "sample";                                         # 出力シート名
$OutputSheetName2 = "sample2";                                        # 出力シート名2
$OutputSheetName3 = "sample3";                                        # 出力シート名3

# --------------------------------------------------------------------
# メイン処理
# --------------------------------------------------------------------

# カレントディレクトリのセット
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);

try {
    # Excelオブジェクトの取得
    $ExcelObj = New-Object -ComObject excel.Application;
    $ExcelObj.Visible = $false

    # ワークブックの作成
    $WorkBook = $ExcelObj.Workbooks.Add();

    # シートの追加
    $WorkSheet = $ExcelObj.Worksheets.Item(1);
    $WorkSheet.Name = $OutputSheetName;

    # 2シート目の追加
    $WorkSheet2 = $WorkBook.Worksheets.Add([System.Reflection.Missing]::Value , $WorkSheet);
    $WorkSheet2.Name = $OutputSheetName2;

    # 3シート目の追加
    $WorkSheet3 = $WorkBook.Worksheets.Add([System.Reflection.Missing]::Value , $WorkSheet2);
    $WorkSheet3.Name = $OutputSheetName3;

    # カレントディレクトリの取得
    $CurrentDir = Get-Location;

    # ワークブックの保存
    $WorkBook.SaveAs("$CurrentDir\$OutputFileName");

} finally {

    #Excelのクローズ
    $ExcelObj.Quit();
    # オブジェクトのNull破棄
    $ExcelObj , $WorkBook , $WorkSheet2 ,$WorkSheet3 | ForEach-Object{$_ = $null};
    [GC]::Collect()
}
