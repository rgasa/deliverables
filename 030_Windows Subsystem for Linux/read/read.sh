#!/bin/bash
#
#-----------------------------------------------------------
# name          : read.sh
# version       : 1.00
# description   : readコマンドのサンプルスクリプト。
# author        : rogasawara
# date          : 2019-12-09
#-----------------------------------------------------------
input_cnt=0
while :
do
  read -p "あなたは、20歳以上ですか？ (y/n):" input_val
  input_cnt=$(( input_cnt + 1 ))

  if [[ "y" = ${input_val} ]]; then
    echo -e "成人です！！ \n"
    break
  elif [[ "n" = ${input_val} ]]; then
    echo -e "未成年です！！" \n"
    break
  else
    if (( ${input_cnt} >= 3 )); then
      read -p "3回試行しましたが、入力値に誤りがありました。処理を終了します．．．。"
      exit 0
    else
      echo -e "[y]または、[n]を入力してください!! \n"
    fi
  fi
done
