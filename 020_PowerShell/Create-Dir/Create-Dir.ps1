#-----------------------------------------------------------
# Name         Create-Dir.ps1
# Version      1.00
# Description  ディレクトリ構成を作成するスクリプト
# Author       rogasawara
# Date         2019-07-15
#-----------------------------------------------------------

#-----------------------------------------------------------
# 環境変数
#-----------------------------------------------------------
$rtnTrue=0                                                  # リターンコード(正常終了)
$rtnFalse=1                                                 # リターンコード(異常終了)
$scriptName=$MyInvocation.MyCommand.name                    # スクリプト名
$logFile=$(Get-Date -UFormat %Y%m%d.log)                    # ログファイル名
$dirConfigFile="DirConfig.xlsx"                             # ディレクトリ構成設定ファイル
$tgtSheet="dirConfig"                                       # 読み込み対象シート

#--------------------------------------------------------
# 各種処理
#--------------------------------------------------------
Function Write-Log( $msg ) {
    #実行時間の取得
    $exeDateTime=Get-Date -UFormat "%Y-%m-%d %H:%M:%S";
    #ログファイルへの書き込み
    "$exeDateTime $scriptName [$msg]" >> "$logFile";
}

#--------------------------------------------------------
# Main処理
#--------------------------------------------------------
#スクリプト自体のディレクトリをカレントディレクトリにセット
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);

#リターンコードの設定
$rtnCd=$rtnTrue;
#開始ログの出力
Write-Log "Start";

try {
    #カレントディレクトリの取得
    $currentDir=$(Get-Location);

    #Excelオブジェクトの生成
    $excel = New-Object -ComObject excel.Application;
    $excel.Visible = $false;

    #対象のExcelとSheetの取得
    $book = $excel.Workbooks.Open("$currentDir\$dirConfigFile");
    $sheet = $excel.Worksheets.item($tgtSheet);

    #Excelファイルの読み込み
    $i=2;
    While ($sheet.Cells.Item($i,1).Text -ne "") {
        $j=1;
        While ($sheet.Cells.Item($i,$j).Text -ne "") {

            if($j -eq 1){
                $tgtDir = $sheet.Cells.Item($i,$j).Text;
            }else{
                $tgtDir +="\" + $sheet.Cells.Item($i,$j).Text;
            }
            $j++;
        }
        $i++;

        #ディレクトリの作成
        New-Item $tgtDir -ItemType Directory -Force;

        if($?) {
            #ディレクトリの作成成功のログの書き込み
            Write-Log "Success mkdir $tgtDir";
        }else{
            #ディレクトリの作成失敗のログの書き込み
            Write-Log "Faild mkdir $tgtDir";
            #リターンコードの設定
            $rtnCd=$rtnFalse;
        }
    }
} catch {
    #リターンコードの設定
    $rtnCd=$rtnFalse;
    #エラーログの出力
    Write-Log $error[0].exception;

} finally {
    #Excelを閉じる
    $excel.Quit();
    #オブジェクトの破棄
    $excel,$book,$sheet | ForEach-Object{$_ = $null};

}

#終了ログの出力
Write-Log "End";
#処理の終了
exit;