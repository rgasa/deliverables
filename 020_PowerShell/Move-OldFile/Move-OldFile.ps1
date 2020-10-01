#-----------------------------------------------------------
# Name        : Move-OldFile.ps1
# Version     : 1.00
# Description : 更新日付が古いファイルを移動する。
# Author      : rogasawara
# Date        : 2019-12-09
# Update      :
#-----------------------------------------------------------
#-----------------------------------------------------------
# 環境変数
#-----------------------------------------------------------
$TARGET_DIR="移動対象のファイルのディレクトリ";
$BACKUP_DIR="移動先のディレクトリ";
$HOLD_PERIOD=3;                                             #ファイルの保有期間(月)
 
#-----------------------------------------------------------
# Main処理
#-----------------------------------------------------------

# カレントディレクトリにスクリプトが、格納されているディレクトリにセット
Set-Location (Split-Path $MyInvocation.MyCommand.Path -parent);
 
#ファイル保持の基準日の取得
$limitDay=(Get-Date).AddMonths(-$HOLD_PERIOD).ToString('yyyyMMdd');
 
#現在日付の取得
$sysData=Get-Date -UFormat "%Y%m%d%H%M%S";
 
#ファイルの一覧を取得
$fileList=Get-ChildItem -File $TARGET_DIR;
 
#対象のファイルが存在しない場合
if ($fileList -eq $null){
    Write-Host "対象のファイルが存在しません。";
    Read-Host "処理を終了します。 Enterキーを押してください..."
    exit
}
 
foreach($file in $fileList){
    #ファイルの最終更新日の取得
    $updDay=$file.LastWriteTime.ToString('yyyyMMdd');
    
    #ファイルの更新日付が保持の基準日以前の場合
    if($updDay -lt $limitDay){
        Move-Item "$TARGET_DIR\$file" "$BACKUP_DIR\$file$sysData";
        Write-Host "$TARGET_DIR\$file を $BACKUP_DIR へ移動しました。";
    }
}
exit
