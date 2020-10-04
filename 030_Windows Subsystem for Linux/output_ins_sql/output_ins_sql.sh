#!/bin/bash
#
#------------------------------------------------------------
# name          : output_file_info.sh
# version       : 1.00
# description   : ファイル情報をCSVファイルに出力します。
# author        : rogasawara
# date          : 2019-10-19
#------------------------------------------------------------

#------------------------------------------------------------
# 環境変数
#------------------------------------------------------------
readonly TRUE=0                                              # リターンコード:正常終了
readonly FALSE=1                                             # リターンコード:異常終了
readonly BASE_DIR=$(cd $(dirname $0); pwd)                   # ベースディレクトリ
readonly FILE_NM=$(echo $0)                                  # シェルスクリプトのファイル名
readonly LOG_FILE_DIR="log"                                  # ログファイル格納ディレクトリ
readonly LOG_FILE_NM=$(date '+%Y%m%d'.log)                   # ログファイル名
readonly XLSX_FILE_NM="products.xlsx"                        # リネーム対象のファイルを記載しているExcelファイル名
readonly TABLE_NAME=${XLSX_FILE_NM%.*}                       # insert対象のテーブル名
readonly CSV_FILE_NM="${TABLE_NAME}.csv"                     # CSVファイル名
#------------------------------------------------------------
# 各種処理
#------------------------------------------------------------
logger ()
{
  # 現在日付の取得
  sysdate=$(date '+%Y/%m/%d %H:%M:%S')
  # 第1引数の取得
  msg=$(echo $1)
  # ログ格納ディレクトリの存在チェック
  if [[ ! -e "${BASE_DIR}/${LOG_FILE_DIR}" ]]; then
    # 存在しない場合、ディレクトリを作成
    mkdir -p "${BASE_DIR}/${LOG_FILE_DIR}"
  fi
  # ログファイルへの書き込み
  printf "${sysdate} ${FILE_NM} ${msg} \r\n" >> "${BASE_DIR}/${LOG_FILE_DIR}/${LOG_FILE_NM}"
}

#------------------------------------------------------------
# Main処理
#------------------------------------------------------------
# リターンコードの設定
rtn_cd=${TRUE}
# 開始ログの出力
logger "[Start]"
# カレントディレクトリをスクリプト自身のディレクトリに変更
cd ${BASE_DIR}

# Excelをcsvに変換
unoconv --format csv "./${XLSX_FILE_NM}"

#CSVファイルの読み込み
row_cnt=0
while read row; do
  # 行のカウントのインクリメント
  row_cnt=$(( row_cnt + 1 ))

  if (( ${row_cnt} == 1 )); then
    # 列数の取得
    col_cnt=$(echo ${row} | awk -F ',' '{print NF}')
    continue
  fi

  # insert文の生成
  ins_sentence="insert into ${TABLE_NAME} values ("

  # 値の生成
  for ((i=1; i<=${col_cnt}; i++)); do
    # 項目の取得
    col_value="'$(echo ${row} | cut -d , -f ${i})',"
    # 最終項目の場合
    if (( ${i} == ${col_cnt} )); then
      col_value="'$(echo ${row} | cut -d , -f ${i})'"
    fi
    # 
    ins_sentence+=${col_value}
  done
  ins_sentence+=");"
  echo ${ins_sentence} >> "${TABLE_NAME}.sql"

done < ${CSV_FILE_NM}

# CSVファイルの削除
rm "./${CSV_FILE_NM}"

#終了ログの出力
logger "[End]"
#処理の終了
exit ${rtn_cd}