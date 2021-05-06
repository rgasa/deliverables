# --------------------------------------------------------------------
# import 定義
# --------------------------------------------------------------------
import pyperclip
import openpyxl
import os
import glob
import time
import datetime
import pyperclip
from PIL import ImageGrab, Image
import sys
from tkinter import messagebox

# --------------------------------------------------------------------
# name          : paste_img.py
# description   : クリップボードの画像ファイルをExcelファイルに貼り付ける。
# param         : -
# return        : -
# author        : rogasawara
# date          : 2021-05-04
# update        :
# --------------------------------------------------------------------
def paste_img():

    # カレントディレクトリの取得
    crrunent_dir:str = os.path.dirname(__file__)
    # 貼り付け用のexcelファイル
    paste_file_path:str = os.path.join(crrunent_dir, "paste_file.xlsx")
    # 貼り付け用ファイルの読込
    excel_book = openpyxl.load_workbook(paste_file_path)
    sheet = excel_book.worksheets[0]

    # クリップボードの初期化
    pyperclip.copy('')
    # ExcelのCell Index
    cell_index:int = 2
    # 開始時間
    strat:float = time.time()

    # 無限ループ開始
    while True:
        # クリップボード内の情報を取得する
        clipboard_image = ImageGrab.grabclipboard()

        # クリップボードに画像が保存されている場合
        if isinstance(clipboard_image, Image.Image):

            # 画像ファイルの保存先の指定
            current_date_time:str = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
            file_path:str = os.path.join(crrunent_dir, current_date_time + ".png")

            # 画像の保存
            clipboard_image.save(file_path)
            # 画像の読込
            img = openpyxl.drawing.image.Image(file_path)
            # 画像のリサイズ
            img.width = img.width * 0.8
            img.height = img.height * 0.8
            # 画像をExcleファイルに貼り付け
            sheet.add_image(img, 'B' + str(cell_index))
            # Excelファイルの保存
            excel_book.save(paste_file_path)
            # クリップボードの初期化
            pyperclip.copy("")

            # CellIndexを20プラス
            cell_index += 20
            print("Image Save")
        else:
            print("No Image")

        # スリープ5秒
        time.sleep(5)

        # 300秒毎に、メッセージボックスを表示する
        if time.time() - strat > 300:
            strat = time.time()
            # メッセージボックスの表示
            result = messagebox.askyesno('確認', '処理を終了しますか?')
            if result == True:
                # pngファイルの削除
                for file in glob.glob('*.png'):
                    os.remove(file)
                # 終了
                sys.exit()

if __name__ == '__main__':
    paste_img()