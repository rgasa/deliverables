# ----------------------------------------------------------
# Main処理
# ----------------------------------------------------------
# カレントディレクトリのセット
Set-Location $(Split-Path $MyInvocation.MyCommand.Path -Parent)

# アセンブリのロード
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Data.OracleClient")

# コネクションの生成
$oracleConStr = "Data Source=orcl;User ID=ora01;Password=ora01;Integrated Security=false;"
$oracleCon    = New-Object System.Data.OracleClient.OracleConnection($oracleConStr)

# インスタンスの初期化
$oracleCmd = New-Object System.Data.OracleClient.OracleCommand
$oracleCmd.Connection = $oracleCon

# DB接続
$oracleCon.open();

# SQL文の指定
$oracleCmd.CommandText = "select 'hoge' from dual"

# SQL文の実行
$oracleDataReader = $oracleCmd.ExecuteReader()

# 実行結果を取得
try {

    while($oracleDataReader.Read()){
        Write-Host ("column = [" + $oracleDataReader.GetString(0) + "]")
    }
    
} finally {
    $oracleDataReader.Close()
}
$oracleCmd.Dispose()
$oracleCon.Close()
$oracleCon.Dispose()
