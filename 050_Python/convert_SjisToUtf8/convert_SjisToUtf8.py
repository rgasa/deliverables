# --------------------------------------------------------------------
# import 定義
# --------------------------------------------------------------------
import glob
import codecs
import os

# --------------------------------------------------------------------
# name          : convert_SjisToUtf8
# description   : shift_jisのファイルをutf8のファイルへ変換します。
# param         : -
# return        : -
# author        : rogasawara
# date          : 2021-04-16
# update        :
# --------------------------------------------------------------------
def convert_SjisToUtf8():
    # 変換対象のファイルが格納されているディレクトリ
    input_dir: str = "./file/"
    # 変換後のファイルの出力先
    output_dir: str = "./out/"
    # fileリストの取得
    target_dir:List[AnyStr] = glob.glob("./file/*")

    for file in target_dir:
        input_file = codecs.open(file, "r" , "shift_jis")
        output_file = codecs.open(output_dir + os.path.split(file)[1], "w" , "utf-8")

        # アウトプットファイルへの書込み
        for row in input_file:
            output_file.write(row)
        
        # オブジェクトのクローズ
        input_file.close()
        output_file.close()

if __name__ == '__main__':
    convert_SjisToUtf8()

