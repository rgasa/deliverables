# --------------------------------------------------------------------
# import 定義
# --------------------------------------------------------------------
import os
import openpyxl
import csv
import pandas

# --------------------------------------------------------------------
# name          : convert_XlsxToCsv
# description   : shift_jisのファイルをutf8のファイルへ変換します。
# param         : -
# return        : -
# author        : rogasawara
# date          : 2021-04-16
# update        :
# --------------------------------------------------------------------
def convert_XlsxToCsv():
    # --- 定数 ---
    TARGET_FILE_PATH: str = "sample.xlsx"
    OUTPUT_FILE_EXTENSION: str = ".csv"

    # Bookの読込
    excel_book = pandas.ExcelFile(TARGET_FILE_PATH)

    # sheetの数だけループ
    for sheet in excel_book.sheet_names:

        # 出力ファイル名を[sheet名.csv]
        output_file_name = sheet + OUTPUT_FILE_EXTENSION

        target_sheet = pandas.read_excel(TARGET_FILE_PATH, sheet, index_col=None)
        target_sheet.to_csv(output_file_name, index=False, encoding="shift_jis")
        
if __name__ == '__main__':
    convert_XlsxToCsv()