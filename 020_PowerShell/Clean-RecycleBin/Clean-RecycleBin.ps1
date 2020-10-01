#-----------------------------------------------------------
# Name          : Clean-RecycleBin.ps1
# Version       : 1.00
# Description   : ゴミ箱の中身の削除を行う。
# Author        : rogasawara
# Date          : 2019-10-01
# Update        : 
#-----------------------------------------------------------

#-----------------------------------------------------------
# 環境変数
#-----------------------------------------------------------
$SCRIPT_NAME=$MyInvocation.MyCommand.name                   # スクリプト名
$BASE_DIR=Split-Path $MyInvocation.MyCommand.Path -Parent   # スクリプト自身のディレクトリ
$LOG_FILE=$(Get-Date -UFormat %Y%m%d.log)                   # ログファイル名
$LOG_FILE_DIR=$BASE_DIR+"\log"                              # ログファイルの格納ディレクトリ

#-----------------------------------------------------------
# 各種処理
#-----------------------------------------------------------
Function Write-Log( $_msg )
{
    # 実行日時の取得
    $exeDateTime=Get-Date -UFormat "%Y-%m-%d %H:%M:%S";
    
    # ログファイル格納ディレクりの存在チェック
    if(!$(Test-Path "$LOG_FILE_DIR")){
      New-Item $LOG_FILE_DIR -ItemType Directory;
    }
    # ログファイルへの書き込み
    "$exeDateTime $SCRIPT_NAME $_msg " >> "$LOG_FILE_DIR\$LOG_FILE";
}

#-----------------------------------------------------------
# Main処理
#-----------------------------------------------------------
#スクリプト自身ディレクトリに移動
Set-Location $BASE_DIR;

#開始ログの出力
Write-Log "[Start]";

try {
    #オブジェクトの生成
    $shell = New-Object -ComObject Shell.Application;
    $trash = $shell.NameSpace(10).Items();

    if($trash.Count -le 0){
        #ゴミ箱の中身が0件の場合
        Write-Log "[Remove TargetFile NotExist]";
    }else{

        #削除対象ファイル名をログファイルに出力
        Write-Log "[=========== Remove TargetFile List =============]";
        $trash | % {Write-Log $_.Name};
        Write-Log "[=========== Remove TargetFile List =============]";

        #ゴミ箱の中身を削除
        Clear-RecycleBin -Force;
    }
} catch {
    #エラーログの出力
    Write-Log $Error[0].exception;

} finally {
    #オブジェクトの破棄
    $shell,$trash | % {$_ = $null};
    #終了ログの出力
    Write-Log "[End]";
}