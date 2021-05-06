# --------------------------------------------------------------------
# Name          : Output-Csv.ps1
# Version       : 1.00
# Description   : データ連携のメイン処理。
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
[string]$MySqlConnectionString = "server='$SrcDbHost';port='$SrcDbPort';uid='$SrcDbUser';pwd=$SrcDbPassword;database=$SrcDb"

# コネクションの生成
$Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
$Connection.ConnectionString = $MySqlConnectionString

try {
    # MySqlへ接続
    $Connection.Open()
    $Msg = "ソースデータベース接続OK...!!!"

    # 画面へのメッセージ表示
    Write-Host $Msg 
    # テキストログの出力
    Write-Log $Msg $ScriptName

    # SQL実行
    $Command = $Connection.CreateCommand()
    $Command.CommandText = 'SELECT user_id, name FROM ms_user'
    $Result = $Command.ExecuteReader()

    $Msg = "SQL実行OK...!!!"
    # 画面へのメッセージ表示
    Write-Host $Msg
    # テキストログの出力
    Write-Log $Msg $ScriptName

    # Datatableにデータをセット
    $DataTable = New-Object "System.Data.Datatable"
    $DataTable.Load($Result)
    # $DataTable | Format-Table

    $DataTable | Export-Csv $path".\tmp.csv" -Delimiter "," -encoding "UTF8" -notype

    $Msg = "CSV出力OK...!!!"
    # 画面へのメッセージ表示
    Write-Host $Msg
    # テキストログの出力
    Write-Log $Msg $ScriptName

} catch {

    $Msg = $Error[0].exception;
    # 画面へのメッセージ表示
    Write-Host $Msg
    # テキストログの出力
    Write-Log $Msg $ScriptName

} finally {
    # コネクションクローズ
    $Connection.Close()
}
