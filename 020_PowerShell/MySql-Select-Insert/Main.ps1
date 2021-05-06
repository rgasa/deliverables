# --------------------------------------------------------------------
# Name          : Main.ps1
# Version       : 1.00
# Description   : データ連携のMain処理。
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

# 開始ログ
$Msg = "Procees Start...!!!"
Write-Log $Msg $ScriptName

# CSV出力処理開始
powershell -ExecutionPolicy RemoteSigned .\Output-Csv.ps1

# Delete および CSV Import処理
powershell -ExecutionPolicy RemoteSigned .\Delete-Import.ps1

# 終了ログ
$Msg = "Procees End...!!!"
Write-Log $Msg $ScriptName