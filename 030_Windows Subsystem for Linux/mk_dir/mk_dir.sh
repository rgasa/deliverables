#!/bin/bash
#
# --------------------------------------------------------------------
# Name          : mk_dir.sh
# Version       : 1.01
# Description   : ディレクトリ作成シェル
# Author        : rogasawara
# Date          : 2019-05-27
# Update        : 2019-12-07
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# 定数
# --------------------------------------------------------------------
readonly TRUE=0                                                       # リターンコード:正常終了
readonly FALSE=1                                                      # リターンコード:異常終了
readonly LOG_FILE=$(date '+%Y%m%d'.log)                               # ログファイル
readonly FILE_NM=$(echo $0)                                           # ファイル名
readonly BASE_DIR=$(cd $(dirname $0); pwd)                            # ベースディレクトリ
readonly LOG_FOLDER="log"                                             # ログフォルダ
readonly DIR_LIST_FILE="dir_list_.txt"                                # ディレクトリリストファイル

# --------------------------------------------------------------------
# 各種処理
# --------------------------------------------------------------------
logger ()
{
    # 現在日付の取得
    sysdate=$(date "+%Y/%m/%d %H:%M:%S")
    # 第1引数の取得
    msg=$(echo $1)

    log_file_dir="${BASE_DIR}/${LOG_FOLDER}"
    # ログファイル格納ディレクトリの存在チェック
    if [[ ! -e "${log_file_dir}" ]]; then
        # 存在しない場合、ディレクトリを作成する
        mkdir -p "${log_file_dir}"
    fi
    # ログファイルへの書き込み
    printf "${sysdate} ${FILE_NM} ${msg} \r\n" >> "${log_file_dir}/${LOG_FILE}"
}

# --------------------------------------------------------------------
# Main
# --------------------------------------------------------------------
# 開始ログ出力
logger '[Start]'
# リターンコードの設定
rtn_cd=${TRUE}

# ファイルの存在チェック
if [[ ! -e ${BASE_DIR}/${DIR_LIST_FILE} ]]; then
  # 存在しない場合
  rtn_cd=${FALSE}
  logger "[Not Found ${DIR_LIST_FILE}]"
  exit ${rtn_cd}
fi

# ファイルの読み込み
cat "${BASE_DIR}/${DIR_LIST_FILE}" | while read line
do
  # ディレクトリ作成
  mkdir -p ${line}

  if [[ $? = 0 ]]; then
    # ディレクトリ作成成功
    logger "[Success mkdir ${line}]"
  else
    # ディレクトリ作成失敗
    rtn_cd=${FALSE}
    logger "[Faild mkdir ${line}]"
    exit ${rtn_cd}
  fi
done

# 終了ログ出力
logger '[End]'
exit ${rtn_cd}