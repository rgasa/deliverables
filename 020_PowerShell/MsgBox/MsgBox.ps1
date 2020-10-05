
# アセンブリの読み込み
Add-Type -Assembly System.Windows.Forms
# メッセージボックスの表示
[System.Windows.Forms.MessageBox]::Show("メッセージ", "タイトル")

[System.Windows.Forms.MessageBox]::Show("メッセージ", "タイトル","OK","Hand","button1")

[System.Windows.Forms.MessageBox]::Show("メッセージ", "タイトル","OKCancel","Error","button2")

[System.Windows.Forms.MessageBox]::Show("メッセージ", "タイトル","AbortRetryIgnore","Stop","button2")

[System.Windows.Forms.MessageBox]::Show("メッセージ", "タイトル","YesNoCancel","Question","button3")

[System.Windows.Forms.MessageBox]::Show("メッセージ", "タイトル","YesNo","Exclamation","button3")

[System.Windows.Forms.MessageBox]::Show("メッセージ", "タイトル","RetryCancel","Warning","button1")

[System.Windows.Forms.MessageBox]::Show("メッセージ", "タイトル","RetryCancel","Asterisk","button1")

[System.Windows.Forms.MessageBox]::Show("メッセージ", "タイトル","RetryCancel","Information","button1")