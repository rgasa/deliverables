OPTIONS(
    -- スキップレコード行数
    SKIP=1 ,
    -- コミット件数
    ROWS=1000
    )

LOAD DATA
    -- 文字コードの設定
    CHARACTERSET UTF8
    -- 取り込みファイル
    INFILE '../csv/test_data.csv'
    -- 不良ファイル
    BADFILE 'test_data.bad'
    -- 廃棄ファイル
    DISCARDFILE 'test_data.dsc'
    -- ロード方法（APPEND：行追加。、INSERT：空表に対するロード。、REPLACE：既存行を全てDELETEしロード。、TRUNCATE：既存行を全てTRUNCATEしロード。）
    TRUNCATE
    INTO TABLE test_data
    -- ロード条件
    WHEN del_flg <> '1'
    -- データの書式
    FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"'
    TRAILING NULLCOLS
    -- カラムの定義
    (
        id                                                  ,
        simei                                               ,
        tel                                                 ,
        address                                             ,
        tgt_ymd                                             ,
        tgt_ym      "TO_CHAR(TO_DATE(:tgt_ymd),'yyyyMM')"   ,
        del_flg                                             ,
        ins_usr     CONSTANT 'admin'                        ,
        ins_date    "SYSDATE"                               ,
        upd_usr                                             ,
        upd_date
    )
