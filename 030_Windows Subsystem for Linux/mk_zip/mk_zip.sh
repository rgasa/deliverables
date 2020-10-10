#!/bin/bash
#
# ----------------------------------------------------------
# name          : mk_zip.sh
# version       : 1.00
# description   : Zipファイル生成シェルスクリプト
# author        : rogasawara
# date          : 2019-12-09
# update        : 
# ----------------------------------------------------------

# ----------------------------------------------------------
# 環境変数
# ----------------------------------------------------------
readonly TRUE=0                                             # リターンコード:正常終了
readonly FALSE=1                                            # リターンコード:異常終了
readonly BASE_DIR=$(cd $(dirname $0); pwd)                  # ベースディレクトリ
readonly FILE_NM=$(echo $0)                                 # ファイル名
readonly ZIP_EXT=".zip"                                     # Zipファイル拡張子
readonly LOG_FOLDER="log"                                   # ログファイル格納フォルダ
readonly LOG_FILE=$(date '+%Y%m%d'.log)                     # ログファイル名
readonly TGT_FOLDER="file"                                  # Zip化対象ファイルの格納フォルダ
readonly ZIP_FOLDER="zip"                                   # Zipファイル作成フォルダ
readonly PASSWORD_PREFIX="pass"                             # パスワード接頭語

# ----------------------------------------------------------
# 各種処理
# ----------------------------------------------------------
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

confrim_password ()
{
    input_cnt=0
    while :
    do
        read -p "Zipファイルにパスワードを付与しますか？(y/n) " input_val
        # カウンタをインクリメント
        input_cnt=$(( input_cnt + 1 ))

        if [[ "y" = ${input_val} ]]; then
            # パスワード接頭語 + 現在日付(yyyyMMdd)を設定
            password_opt="e --password ${PASSWORD_PREFIX}$(date "+%Y%m%d")"
            break
        elif [[ "n" = ${input_val} ]]; then
            break

        else
            if (( ${input_cnt} >= 3 )); then
                read -p "3回試行したが、入力値に誤りがありました。処理を終了します。"
                rtn_cd=${FALSE}
                logger "[Faild Input Value]"
                exit ${rtn_cd}
            else
                echo -e "[y]または、[n]を入力してください!! \n"
            fi
        fi
    done
}
#-----------------------------------------------------------‐
# Main処理
#-----------------------------------------------------------‐
# リターンコードの設定
rtn_cd=${TRUE}
# IFS変数の設定
IFS=$'\n'
# 開始ログの出力
logger '[Start]'

# Zip化対象ディレクトリの取得
tgt_file_dir="${BASE_DIR}/${TGT_FOLDER}"

# Zip化対象ディレクトリの存在チェック
if [[ ! -e "${tgt_file_dir}" ]]; then
    # ディレクトリが存在しない場合、処理を終了
    rtn_cd=${FALSE}
    logger "Not Found ${tgt_file_dir}"
    exit ${rtn_cd}
fi

# Zip化対象ディレクトリに移動
cd "${tgt_file_dir}"

# Zipファイル格納ディレクトリの取得
zip_file_dir="${BASE_DIR}/${ZIP_FOLDER}"

# Zipファイル格納ディレクトリの存在チェック
if [[ ! -e "${zip_file_dir}" ]]; then
  # 存在しない場合、ディレクトリを作成する
  mkdir -p "${zip_file_dir}"
fi

# パスワード付与の確認
confrim_password

# Zip化処理の開始
for file in $(find "${tgt_file_dir}" -mindepth 1 -maxdepth 1); do
    # 実行コマンドの生成
    if [[ -d "${file}" ]]; then # ディレクトリの場合
        if [[ -n "${password_opt}" ]]; then # パスワード付与を付与する場合
            exec_cmd="zip -r${password_opt}"
        else
            exec_cmd="zip -r"
        fi
    elif [[ -f "${file}" ]]; then # ファイルの場合
        if [[ -n "${password_opt}" ]]; then # パスワード付与を付与する場合
            exec_cmd="zip -${password_opt}"
        else
            exec_cmd="zip"
        fi
    fi
    # ファイル名の取得
    tgt_file_nm=$(basename ${file})
    # Zip化処理
    eval "${exec_cmd}" "\"${zip_file_dir}/${tgt_file_nm%.*}${ZIP_EXT}\"" "\"${tgt_file_nm}\""
    # Zip化処理の成否判定
    if [[ $? = 0 ]]; then
        logger "[Success mk_Zip] ${file} ⇒ ${zip_file_dir}/${tgt_file_nm%.*}${ZIP_EXT} "
    else
        rtn_cd=${FALSE}
        logger "[Faild mk_Zip] ${file} ⇒ ${zip_file_dir}/${tgt_file_nm%.*}${ZIP_EXT}"
    fi
done

# 終了ログの出力
logger '[End]'
exit ${rtn_cd}