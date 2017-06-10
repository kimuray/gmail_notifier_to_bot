# Gmail_post_to_bot

Gmailから未読メールを取得してBOTに通知するプログラム  
現状はとりあえずSlackに通知投げます。

## Configure

### 環境変数

```
export SLACK_WEBHOOK_URL=SlackBotのwebhookURL
export GMAIL_ACCOUNT_NAME=Gmailアドレス
```

### バッチの実行間隔

`clock_notifier.rb`の`10.minutes`の部分を調整します。

## 今後の機能作成予定

* メールに特定の文字列が含まれた場合のみBOTに通知できるようにする
* LINEBOTにも対応したい(Push Messageにお金がかかるのでどうしよう)
* 実行間隔とか設定ファイルで設定しちゃいたい
* ライブラリ化したい
