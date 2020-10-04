#!/bin/bash
#
#-------------------------------------------------------------
# name          : rename_file.sh
# version       : 1.01
# description   : Rename File
# author        : rogasawara
# date          : 2019-10-19
#------------------------------------------------------------

#------------------------------------------------------------
# 環境変数
#------------------------------------------------------------
readonly TRUE=0                                              #リターンコード:正常終了
readonly FALSE=1                                             #リターンコード:異常終了
readonly BASE_DIR=$(dirname $0)                              #ベースディレクトリ
readonly FILE_NM=$(echo $0)                                  #シェルスクリプトのファイル名
readonly LOG_FILE_DIR="log"                                  #ログファイル格納ディレクトリ
readonly LOG_FILE_NM=$(date '+%Y%m%d'.log)                   #ログファイル名
readonly XLSX_FILE_NM="file_list.xlsx"                       #リネーム対象のファイルを記載しているExcelファイル名
readonly CSV_FILE_NM="file_list.csv"                         #CSVファイル名

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
  if [[ ! -e "${BASE_DIR}/${LOG_FILE_DIR}" ]]; then
    #存在しない場合、ディレクトリを作成
    mkdir -p "${BASE_DIR}/${LOG_FILE_DIR}"
  fi
  #ログファイルへの書き込み
  printf "${sysdate} ${FILE_NM} ${rtn_cd} ${msg} \r\n" >> "${BASE_DIR}/${LOG_FILE_DIR}/${LOG_FILE_NM}"
}
#------------------------------------------------------------
# Main処理
#------------------------------------------------------------
#リターンコードの設定
rtn_cd=${TRUE}
#開始ログの出力
logger "[Start]"

#カレントディレクトリをスクリプト自身のディレクトリに変更
cd ${BASE_DIR}

#Excelをcsvに変換
unoconv --format csv "./${XLSX_FILE_NM}"

#CSVファイルの読み込み
row_cnt=0
while read row; do
  # 行のカウント
  row_cnt=$(( row_cnt + 1 ))
  # ヘッダー行の場合、処理をスキップ
  if (( ${row_cnt} == 1 )); then
    continue
  fi

  # 変更前のディレクトリ、ファイル名の取得
  before_file_dir=$(echo ${row} | cut -d , -f 1)
  before_file_nm=$(echo ${row} | cut -d , -f 2)

  # 変更後のディレクトリ、ファイル名の取得
  after_file_dir=$(echo ${row} | cut -d , -f 3)
  after_file_nm=$(echo ${row} | cut -d , -f 4)

  # 変更後のディレクトリの存在チェック
  if [[ ! -e "${after_file_dir}" ]]; then
    # ディレクトリが存在しない場合、作成する
    mkdir -p ${after_file_dir}
  fi

  if [[ "${before_file_dir}" = "${after_file_dir}" ]]; then
    # 変更前後のディレクトリが同じ場合、mvコマンド
    exec_cmd="mv"
  else
    # 変更前後のディレクトリが異なる場合、cpコマンド
    exec_cmd="cp"
  fi

  # コマンドの実行
  ${exec_cmd} "${before_file_dir}/${before_file_nm}" "${after_file_dir}/${after_file_nm}"

  if [[ $? = 0 ]]; then
    #リネーム成功
    logger "[Success rename ${before_file_dir}/${before_file_nm} ⇒ ${after_file_dir}/${after_file_nm}]"
  else
    #リネーム失敗
    rtn_cd=${FALSE}
    logger "[Faild rename ${before_file_dir}/${before_file_nm} ⇒ ${after_file_dir}/${after_file_nm}]"
  fi
done < ${CSV_FILE_NM}

#CSVファイルの削除
rm "./${CSV_FILE_NM}"

#終了ログの出力
logger "[End]"
#処理の終了
exit ${rtn_cd}