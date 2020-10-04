#!/bin/bash
# 
#-----------------------------------------------------------
# name          : extraction_string.sh
# version       : 1.00
# description   : 文字列を抽出するシェルスクリプト
# author        : rogasawara
# date          : 2020-02-01
#-----------------------------------------------------------

#-----------------------------------------------------------
# 環境変数
#-----------------------------------------------------------
readonly TRUE=0                                             # リターンコード:正常終了
readonly FALSE=1                                            # リターンコード:異常終了
readonly BASE_DIR=$(cd $(dirname $0); pwd)                  # ベースディレクトリ
readonly FILE_NM=$(echo $0)                                 # ファイル名
readonly LOG_FOLDER="log"                                   # ログファイル格納フォルダ
readonly LOG_FILE=$(date '+%Y%m%d'.log)                     # ログファイル名
readonly OUTPUT_FILE_NM="output.txt"                        # 出力ファイル名

# 対象のファイル名に合わせて変更してください====================
readonly TGT_FILE_NM="tgt_file.txt"                         # 検索対象のファイル
# 対象のファイル名に合わせて変更してください====================

#-----------------------------------------------------------‐
# Main処理
#-----------------------------------------------------------‐
# カレントディレクトリをスクリプト自身のディレクトリに変更
cd ${BASE_DIR}
# リターンコードの設定
rtn_cd=${TRUE}

read -p "検索文字列を入力してください : " search_string
read -p "検索パターンを入力してください！！！ 0:部分一致、1:行頭から検索、2:除外検索 : " search_pattern

input_cnt=0
while :
do
  if [[ ${search_pattern} = 0 ]]; then
    opt=""
    break
  elif [[ ${search_pattern} = 1 ]]; then
    opt="-G"
    search_string="^${search_string}"
    break
  elif [[ ${search_pattern} = 2 ]]; then
    opt="-v"
    break
  else
    # カウンタをインクリメント
    input_cnt=$(( input_cnt + 1 ))

    if (( ${input_cnt} >= 3 )); then
      read -p "3回試行したが、入力値に誤りがありました。処理を終了します。"
      rtn_cd=${FALSE}
      exit ${rtn_cd}
    else
      echo -e "0、1、2(0:部分一致、1:行頭から検索、2:除外検索)の数値を入力してください。 \n"
    fi
  fi

done

# 検索結果をファイルへ出力
grep ${opt} ${search_string} "${BASE_DIR}/${TGT_FILE_NM}" >> "./${OUTPUT_FILE_NM}"

# 成否判定
if [[ $? = 0 ]]; then
  read -p "検索結果のファイル出力が完了しました！！！ "
else
  read -p "検索結果のファイル出力に失敗しました！！！ "
fi

exit ${rtn_cd}