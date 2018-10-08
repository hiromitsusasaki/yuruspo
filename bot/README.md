# README
※後でもっと詳細に書きます*

## yurusupo/bot

ゆるすぽのボット用バックエンドシステム

### 技術仕様
* Ruby 2.5
* Rails 5.1
* MySQL 5.7

### ローカル環境構築

* 開発環境は共通化を図るためDockerコンテナを利用して構築する。
* ローカル環境とLine Messaging APIとの通信にはngrokを利用する。

#### Dockerのインストール

[公式サイト](https://www.docker.com/products/docker-desktop)からDocker Desktop(Mac/Win)をインストールする。

#### ngrokのインストール

[公式サイト](https://ngrok.com/)からngrokの実行ファイルを取得し、実行パスを通す。


#### アプリケーションの起動

```sh
$ docker-compose up
```

#### ngrokの起動

```sh
$ ngrok http 3000
```

起動中の様子
```
ngrok by @inconshreveable                                       (Ctrl+C to quit)

Session Status                online
Session Expires               7 hours, 59 minutes
Version                       2.2.8
Region                        United States (us)
Web Interface                 http://127.0.0.1:4040
Forwarding                    http://085eb739.ngrok.io -> localhost:3000
Forwarding                    https://085eb739.ngrok.io -> localhost:3000

Connections　ttl     opn     rt1     rt5     p50     p90
        　　　0       0       0.00    0.00    0.00    0.00
```

#### Line Messaging APIの準備

##### チャネル（ボットアカウント）を作成する

[Line Developers](https://developers.line.me/ja/)にログインし、動作確認に使うMessaging APIのチャネルを作成する。

##### Webhook URLを設定する

作成したMessaging APIのチャネルのWebhook URLを、起動中のngrokの公開URL（HTTPS）に設定する。

ex)
```
https://085eb739.ngrok.io/line/callback
```

#### 動作確認

チャネルの管理ページにあるQRコードからボットを友達追加して、チャットしてみる。



