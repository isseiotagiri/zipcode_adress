_forked from https://github.com/lord/slate_

### URL
* develop  
  https://api-docs-dev-smslink.nexlink2.jp/
* production  
  https://api-docs.smslink.jp/
* ID/Pass  
  developer/smslink(のleet）

### 動作確認
api_referenceのコンテナを起動する
```shell
# smslink1の直下で実行
docker compose up api_reference -d
```

ブラウザで下記URLを確認
```
http://localhost:4568
```

api_referenceのコンテナを停止する
```shell
# smslink1の直下で実行
docker compose down api_reference
```

### Architecture

https://nexway.esa.io/posts/3374

### Deploy
- 以下のjobを使用してdevelopへ手動デプロイ  
  https://dev-jenkins.nexlink2.jp/job/DEV/view/SMSLINK/job/develop-sms/job/deploy_api_documentation/
