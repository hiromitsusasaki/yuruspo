# README
*後でもっと詳細に書きます*

## yurusupo/bot

ゆるすぽのボット用バックエンドシステム

### 技術仕様
* Ruby 2.5
* Rails 5.1
* MySQL 5.7
* sidekiq
* Redis 4.0

#### アーキテクチャー概略

RailsによるAPIアプリケーションとしてLineサーバからのHTTPリクエストを受け取り、署名検証後、リクエストから生成したジョブをジョブキューシステムに登録し、即座にHTTPレスポンスを返します。

ジョブキューシステムに登録されたジョブは、ジョブワーカーによって非同期で実行され、処理が完了した後、結果をLineサーバにHTTPリクエストとして送ります。

![画像](https://dl.dropboxusercontent.com/s/jd4q7y0rom6vn2q/yuruspo_flow.png)

#### クラス設計の方針

ControllerはLineサーバからのリクエストを受け付けることのみを行います。（Webhook）<br />
ModelはDBとのやり取り及びそのModel固有の処理を担当するようにします。<br />
実際の処理（ビジネスロジック）はServiceクラスとして実装して、そのServiceをWorkerに実行させるような設計を考えています。

*が、この設計で本当に良いのかちょっと悩んでます。ご意見頂きたいです。*


#### 参考
[Railsで導入してよかったデザインパターンと各クラスの役割について](http://masato-hi.hatenablog.jp/entry/2016/03/19/161712)

[大量メッセージが来ても安心なLINE BOTサーバのアーキテクチャ](https://qiita.com/yoichiro6642/items/6d4c7309210af20a5c8f)

<hr />

### ローカル環境

* 開発環境は共通化を図るためDockerコンテナを利用して構築します。
* ローカル環境とLine Messaging APIとの通信にはngrokを利用する。

#### Dockerのインストール

[公式サイト](https://www.docker.com/products/docker-desktop)からDocker Desktop(Mac/Win)をインストールする。

#### ngrokのインストール

[公式サイト](https://ngrok.com/)からngrokの実行ファイルを取得し、実行パスを通す。


#### コンテナの起動

git cloneしてプロジェクト一式をローカルに取ってきた前提で勧めます。

```sh
$ cd ./sports_meet/bot
$ docker-compose up
```

上記コマンドで、バックエンドのウェブアプリ（app)、MySQL(db)、Redis(redis)、ジョブワーカー(worker)の4つのコンテナが立ち上がり、システムが起動します。

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

[Line Developers](https://developers.line.me/ja/)にログインし、動作確認に使うMessaging APIのチャネルを作成する。

##### Webhook URLを設定する

作成したMessaging APIのチャネルのWebhook URLを、起動中のngrokの公開URL（HTTPS）に設定する。

ex)
```
https://085eb739.ngrok.io/line/callback
```

##### 環境変数の設定

ローカル環境のホストOSに下記の環境変数を登録します。



#### 動作確認

チャネルの管理ページにあるQRコードからボットを友達追加して、チャットしてみる。

<hr />

### ステージング環境
*要検討*

<hr />

### 本番環境

*要検討*