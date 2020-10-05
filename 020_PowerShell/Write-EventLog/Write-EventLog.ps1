#----------------------------------------------------------------
# Name        : Write-EventLog.ps1
# Version     : 1.00
# Description : Widnowsイベントログの書き込みを行うサンプルスクリプト。
# Author      : rogasawara
# Date        : 2020-01-25
#----------------------------------------------------------------

#----------------------------------------------------------------
# Main処理
#----------------------------------------------------------------
# 曜日の取得(0:日、1:月、2:火、3:水、4:木、5:金、6:土)
$DayOfWeek=$(Get-Date).DayOfWeek.value__

if($DayOfWeek -eq 0){

    # エラーログの出力
    Write-EventLog -LogName Application -EntryType Error -Source Write-EventLog.ps1 -EventId 102 -Message "日曜日は、非稼働日です。"   
    Write-Host "エラーログを出力しました！！！"
    
} elseif($DayOfWeek -eq 6){

    # ワーニングログの出力
    Write-EventLog -LogName Application -EntryType Warning  -Source Write-EventLog.ps1 -EventId 101 -Message "土曜日は、半休です。" 
    Write-Host "ワーニングログを出力しました！！！"
    
} else {

    # 正常ログの出力
    Write-EventLog -LogName Application -EntryType SuccessAudit -Source Write-EventLog.ps1 -EventId 100 -Message "平日は、稼働日です。"
    Write-Host "正常ログを出力しました！！！"

}
