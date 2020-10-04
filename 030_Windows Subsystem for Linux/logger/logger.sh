#!/bin/bash
#------------------------------------------
# 定数
#------------------------------------------
readonly FILE_NM=$(echo $0)                # ファイル名
readonly LOG_FILE=$(date '+%Y%m%d'.log)    # ログファイル
readonly BASE_DIR=$(cd $(dirname $0); pwd) # スクリプトが格納されているディレクトリの取得
readonly LOG_FOLDER="log"                  # ログを格納するフォルダ名

#------------------------------------------
# ログ出力用関数
#------------------------------------------
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
#------------------------------------------
# Main処理
#------------------------------------------
cd ${BASE_DIR}

logger "start"                             # 開始ログの出力

logger "Main処理..."                       # Main処理の開始

logger "end"                               # 終了ログの出力