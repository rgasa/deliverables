# --------------------------------------------------------------------
# Name          : Join-Excel.ps1
# Version       : 1.00
# Description   : 複数ファイルのExcelを内容を結合したExcelファイルを生成する。
# Author        : rogasawara
# Date          : 2020-09-26
# Update        :   
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# 環境変数
# --------------------------------------------------------------------
$OUTPUT_EXCEL_NAME = "1H.xlsx"
$OUTPUT_SHEET_NAME = "1H"
$TGT_FILE_EXT      = "*.xlsx"

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

    # アウトプットファイルの作成
    $WorkBook = $ExcelObj.Workbooks.Add();

    # 対象ファイルへの処理
    $ind = 1;
    foreach ($file in $FileList) {
        # 対象のファイルのオープン
        $TgtFile = $ExcelObj.Workbooks.Open("$CurrentDir\$file" , $null, $true);

        # 対象のファイルのシート数を取得
        $SheetInd = $TgtFile.worksheets.count;

        for ($i = 1; $i -le $SheetInd; $i++) {
            # 出力用ファイルに対象のシートをコピー
            $TgtFile.worksheets.item($i).copy($WorkBook.worksheets.item($ind));

            $ind ++;
        }
        $TgtFile = $null;
    }

    # 不要シート削除
    $WorkBook.worksheets.item("sheet1").delete();
    # ワークブックの保存
    $WorkBook.SaveAs("$CurrentDir\$OUTPUT_EXCEL_NAME");

} finally {
    
    # ワークブックのクローズ
    $ExcelObj.Workbooks.Close();
    #Excelのクローズ
    $ExcelObj.Quit();

    $ExcelObj , $WorkBook , $TgtFile | ForEach-Object{$_ = $null};
    [GC]::Collect();
}