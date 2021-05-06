# --------------------------------------------------------------------
# import 定義
# --------------------------------------------------------------------
import pyperclip
import os
import time
import datetime
import pyperclip
from PIL import ImageGrab, Image
import sys
from tkinter import messagebox


# --------------------------------------------------------------------
# name          : save_png.py
# description   : クリップボードの画像ファイルを保存する。
# param         : -
# return        : -
# author        : rogasawara
# date          : 2021-05-04
# update        :
# --------------------------------------------------------------------
def save_png():
    # クリップボードの初期化
    pyperclip.copy('')

    # 無限ループ開始
    while True:
        # クリップボード内の情報を取得する
        clipboard_image = ImageGrab.grabclipboard()

        # 画像ファイルの保存先の指定
        date_time:str = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
        file_path:str = os.path.join(os.path.dirname(__file__), date_time + ".png")

        # クリップボードに画像が保存されている場合
        if isinstance(clipboard_image, Image.Image):
            # 画像の保存
            clipboard_image.save(file_path)
            # クリップボードの初期化
            pyperclip.copy("")

            print("Image Save")
        else:
            print("No Image")

        # スリープ3秒
        time.sleep(3)

if __name__ == '__main__':
    save_png()