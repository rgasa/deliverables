# --------------------------------------------------------------------
# Name          : Env.ps1
# Version       : 1.00
# Description   : 環境変数ファイル。
# Author        : rogasawara
# Date          : 2021-04-20
# Update        :
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# 定数
# --------------------------------------------------------------------
$BASE_DIR=Split-Path $MyInvocation.MyCommand.Path -Parent             # スクリプト自身のディレクトリ
$LOG_FILE=$(Get-Date -UFormat %Y%m%d.log)                             # ログファイル名
$LOG_FILE_DIR=$BASE_DIR+"\log"                                        # ログファイルの格納ディレクトリ

# --------------------------------------------------------------------
# 環境変数
# --------------------------------------------------------------------
[string]$SrcDbHost      = 'localhost'
[string]$SrcDbPort      = '3306'
[string]$SrcDb          = 'dev01'
[string]$SrcDbUser      = 'dev01'
[string]$SrcDbPassword  = 'dev01'

[string]$RmtDbHost      = 'localhost'
[string]$RmtDbPort      = '3306'
[string]$RmtDb          = 'dev01'
[string]$RmtDbUser      = 'dev01'
[string]$RmtDbPassword  = 'dev01'

# --------------------------------------------------------------------
# 共通関数
# --------------------------------------------------------------------

# ログ出力関数 
Function Write-Log( $_msg, $_file_name )
{
    # 実行日時の取得
    $exeDateTime=Get-Date -UFormat "%Y-%m-%d %H:%M:%S";
    
    # ログファイル格納ディレクリの存在チェック
    if(!$(Test-Path "$LOG_FILE_DIR")){
      New-Item $LOG_FILE_DIR -ItemType Directory;
    }
    
    # ログファイルへの書き込み
    "[ $exeDateTime ] $_file_name $_msg " >> "$LOG_FILE_DIR\$LOG_FILE";
}