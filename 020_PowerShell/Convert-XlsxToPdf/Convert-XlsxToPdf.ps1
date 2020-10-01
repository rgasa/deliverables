# --------------------------------------------------------------------
# Name          : Create-Excle.ps1
# Version       : 1.00
# Description   : ExcelファイルをPDFファイルに変換する。
# Author        : rogasawara
# Date          : 2020-9-13
# Update        :   
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# 環境変数
# --------------------------------------------------------------------
$TgtFileName   = "sample.xlsx";                                       # 変換対象のExcelファイル名
$PdfFileName   = "sample.pdf";                                        # 変換後のPDFファイル名

# --------------------------------------------------------------------
# メイン処理
# --------------------------------------------------------------------

# カレントディレクトリのセット
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);
# カレントディレクトリの取得
$CurrentDir = $(Get-Location);

try {
    # Excelオブジェクトの取得
    $ExcelObj = New-Object -ComObject excel.Application;
    $ExcelObj.Visible = $false

    # 対象のExcelファイルのオープン
    $ExcelBook = $ExcelObj.Workbooks.open("$CurrentDir\$TgtFileName");
    $TgtSheet  = $ExcelBook.Worksheets.Item(1);

    # PDFファイルパス
    $PdfFileDir = "$CurrentDir\$PdfFileName";

    $TgtSheet.ExportAsFixedFormat(0, $PdfFileDir);

} finally {

    # ワークブックのクローズ
    $ExcelObj.Workbooks.Close();
    # Excelのクローズ
    $ExcelObj.Quit();
    # オブジェクトのNull破棄
    $ExcelObj , $TgtSheet | ForEach-Object{$_ = $null};
    [GC]::Collect();

}