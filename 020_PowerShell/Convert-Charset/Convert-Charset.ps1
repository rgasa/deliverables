#-----------------------------------------------------------
# Name          : Convert-Charset.ps1
# Version       : 1.00
# Description   : 文字コードをUTF8へ変換する。
# Author        : rogasawara
# Date          : 2020-08-10
#-----------------------------------------------------------

#-----------------------------------------------------------
# 環境変数
#-----------------------------------------------------------
$BASE_DIR=Split-Path $MyInvocation.MyCommand.Path -parent;  # スクリプトのディレクトリ
$OUTPUT_FOLDER="out";                                       # アウトプット先のフォルダ名
$TGT_DIR="file";                                            # 変換対象のファイルを配置するフォルダ

#----------------------------------------------------------
# メイン処理
#----------------------------------------------------------
Set-Location $BASE_DIR

#ファイル一覧の取得
$FileList=Get-ChildItem -File $TGT_DIR;

if($FileList -eq $null) {
    Write-Host "対象のファイルが存在しません。"
    Read-Host "処理を終了します。 Enterキーを押してください..."
    exit
}

foreach ($file in $FileList) {
    #文字コードの変換
    Get-Content ".\$TGT_DIR\$file" | Set-Content -Encoding UTF8 ".\$OUTPUT_FOLDER\$file";

    #成否判定
    if($?) {
        Write-Host "$TGT_DIR\$file の変換処理完了！！"
     }else{
        Write-Host "$TGT_DIR\$file の変換処理失敗！！"
     }
}

Read-Host "処理を終了します。 Enterキーを押してください..."
