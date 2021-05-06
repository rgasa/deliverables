# --------------------------------------------------------------------
# Name          : Delete-Import.ps1
# Version       : 1.00
# Description   : テーブル削除とImport処理。
# Author        : rogasawara
# Date          : 2021-04-20
# Update        :
# --------------------------------------------------------------------

# script名の取得
$ScriptName = $MyInvocation.MyCommand.name
# カレントディレクトリのセット
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent);
# カレントディレクトリの取得
$CurrentDir = $(Get-Location);

# Envファイルの読込
.".\Env.ps1"

# アセンブリのロード
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
# 接続文字列の生成
[string]$MySqlConnectionString = "server='$RmtDbHost';port='$RmtDbPort';uid='$RmtDbUser';pwd=$RmtDbPassword;database=$RmtDb;allowLoadLocalInfile=true; "

# コネクションの生成
$Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
$Connection.ConnectionString = $MySqlConnectionString

try {
    # MySqlへ接続
    $Connection.Open()

    $Msg = "リモートデータベース接続OK...!!!"
    Write-Host "$Msg"
    # テキストログの出力
    Write-Log $Msg $ScriptName

    # DELETE実行
    [string]$DeleteStr = "DELETE FROM ms_admin_user;"
    $DeleteCmd = New-Object MySql.Data.MySqlClient.MySqlCommand($DeleteStr,$Connection)
    $Result = $DeleteCmd.ExecuteNonQuery()

    $Msg = "TABLE DELETE OK...!!!"
    # 画面へのメッセージ表示
    Write-Host "$Msg"
    # テキストログの出力
    Write-Log $Msg $ScriptName

    # CSVのインポート
    [string]$LoadStr = "LOAD DATA LOCAL INFILE `"C:\\@workspace\\416_PowerShell\\001_MySql-Select-Insert\\tmp.csv`" INTO TABLE ms_admin_user FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '`"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES ;"
    $LoadCmd = New-Object MySql.Data.MySqlClient.MySqlCommand($LoadStr, $Connection)
    $Result = $LoadCmd.ExecuteNonQuery()
    
    $Msg = "CSV IMPORT OK !!! ..."
    # 画面へのメッセージ表示
    Write-Host "$Msg"
    # テキストログの出力
    Write-Log $Msg $ScriptName

} catch {

    $Msg = $Error[0].exception;
    # エラーログの出力
    Write-Host $Msg ;
    # テキストログの出力
    Write-Log $Msg $ScriptName

} finally {

    $Connection.Close()

}