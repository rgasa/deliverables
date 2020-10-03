#!/bin/bash
#
#-------------------------------------------------------------
# name          : conv_charset.sh
# version       : 1.00
# description   : 文字コード変換シェルスクリプト
# author        : rogasawara
# date          : 2019-09-09
#------------------------------------------------------------

#------------------------------------------------------------
# 環境変数
#------------------------------------------------------------
readonly TRUE=0                                              #リターンコード:正常終了
readonly FALSE=1                                             #リターンコード:異常終了
readonly LOG_FILE_NM=$(date '+%Y%m%d'.log)                   #ログファイル名
readonly FILE_NM=$(echo $0)                                  #ファイル名

# ===これ以降の環境変数は各環境で変更してください============
readonly TGT_DIR="/mnt/c/@work/40_WSL/nkf_charset/file"      #変換対象のディレクトリ
readonly TGT_EXT="*"                                         #変換対象の拡張子(指定なしの場合、*を設定)
readonly LOG_FILE_DIR="/mnt/c/@work/40_WSL/nkf_charset/log"  #ログファイル格納ディレクトリ

#------------------------------------------------------------
# 各種処理
#------------------------------------------------------------
logger ()
{
    #現在日付の取得
    sysdate=$(date '+%Y/%m/%d %H:%M:%S')
    #第1引数の取得
    msg=$(echo $1)
    #ログ格納ディレクトリの存在チェック
    if [ ! -e ${LOG_FILE_DIR} ]; then
        #存在しない場合、ディレクトリを作成
        mkdir -p ${LOG_FILE_DIR}
    fi
    #ログファイルへの書き込み
    printf "${sysdate} ${FILE_NM} [RC=${rtn_cd}] ${msg} \r\n" >> ${LOG_FILE_DIR}/${LOG_FILE_NM}
}

#------------------------------------------------------------
# Main処理
#------------------------------------------------------------
#リターンコードの設定
rtn_cd=${TRUE}

#開始ログの出力
logger "[Start]"

for file in $(find ${TGT_DIR} -name "*.${TGT_EXT}" -type f); do

    #文字コードの変換
    nkf -Lu --overwrite ${file}

    if [ $? = 0 ]; then
        #文字コード変換成功
        logger "[Success Conv Charset] ${file}"
    else
        #リターンコードのFALSEを設定
        rtn_cd=${FALSE}
        #文字コード変換失敗
        logger "[Faild Conv Charset] ${file}"
    fi
done

#終了ログの出力
logger "[End]"

#処理の終了
exit ${rtn_cd}