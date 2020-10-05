# ----------------------------------------------------------
# 環境変数
# ----------------------------------------------------------

$SCRIPT_NAME=$MyInvocation.MyCommand.name                   # スクリプト名
$BASE_DIR=Split-Path $MyInvocation.MyCommand.Path -Parent   # スクリプト自身のディレクトリ
$LOG_FILE=$(Get-Date -UFormat %Y%m%d.log)                   # ログファイル名
$LOG_FILE_DIR=$BASE_DIR+"\log"                              # ログファイルの格納ディレクトリ


# ----------------------------------------------------------
# ログ出力関数
# ----------------------------------------------------------
Function Write-Log( $_msg )
{
    # 実行日時の取得
    $exeDateTime=Get-Date -UFormat "%Y-%m-%d %H:%M:%S";
    
    # ログファイル格納ディレクリの存在チェック
    if(!$(Test-Path "$LOG_FILE_DIR")){
      New-Item $LOG_FILE_DIR -ItemType Directory;
    }
    
    # ログファイルへの書き込み
    "$exeDateTime $SCRIPT_NAME $_msg " >> "$LOG_FILE_DIR\$LOG_FILE";
}

# ----------------------------------------------------------
# Main処理
# ----------------------------------------------------------
# カレントディレクトリをスクリプト自身のディレクトリにセット
Set-Location $BASE_DIR

# 開始ログの出力
Write-Log "[Start]";

# Main処理を記述・・・
Write-Log "[Main処理・・・]";

# 終了ログの出力
Write-Log "[End]";
