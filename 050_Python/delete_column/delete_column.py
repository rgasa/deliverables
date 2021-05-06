# --------------------------------------------------------------------
# import 定義
# --------------------------------------------------------------------
import glob
import openpyxl

# --------------------------------------------------------------------
# name          : output_convert_xlsx
# description   : 特定の列を削除した、Excelファイルを出力します。
# param         : -
# return        : -
# author        : rogasawara
# date          : 2021-04-19
# update        :
# --------------------------------------------------------------------
def delete_column():
    # 出力先folder
    OUTPUT_FOLDER:Str = "./out"
    # .xlsxファイルリストの取得
    file_list:List[AnyStr] = glob.glob("./*.xlsx")

    for file in file_list:
        # Bookの読込
        excel_book = openpyxl.load_workbook(file)
        # 全てのシートの取得
        work_sheets = excel_book.worksheets
        
        # 全シート
        for work_sheet in work_sheets:
            # カラムの削除
            work_sheet.delete_cols(7, 2)

        # Excelファイルの保存
        excel_book.save(OUTPUT_FOLDER + file)
        

if __name__ == '__main__':
    delete_column()