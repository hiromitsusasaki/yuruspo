# README

このREADMEの内容はまだまだ検討中の段階です。皆さんの忌憚のないご意見をお待ちしています。

## yurusupo/bot

ゆるすぽのボット用バックエンドシステム

### 技術仕様

#### 言語・ミドルウェア・フレームワーク
* Ruby 2.5
* Rails 5.1
* MySQL 5.7
* sidekiq
* Redis 4.0

#### アーキテクチャー

RailsによるAPIアプリケーションとしてLineサーバからのHTTPリクエストを受け取り、署名検証後、リクエストから生成したジョブをジョブキューシステムに登録し、即座にHTTPレスポンスを返します。

ジョブキューシステムに登録されたジョブは、ジョブワーカーによって非同期で実行され、処理が完了した後、結果をLineサーバにHTTPリクエストとして送ります。

![画像](https://dl.dropboxusercontent.com/s/jd4q7y0rom6vn2q/yuruspo_flow.png)

#### 処理フロー

Lineボットのバックエンドは基本的に下記のフローで処理を実行していきます。

![画像](https://dl.dropboxusercontent.com/s/foa160i5ikl5r16/bot_process_flow_chart.png)

#### データモデル
**検討中**

#### クラス設計の方針

ControllerはLineサーバからのリクエストを受け付けることのみ(Webhook)を行います。ModelはDBとのやり取り及びそのModel固有の処理を担当するようにします。実際の処理（ビジネスロジック）はServiceクラスとして実装して、そのServiceをWorkerに実行させるような設計を考えています。**が、この設計で本当に良いのかちょっと悩んでます。ご意見頂きたいです。**<br />
メッセージタイプ/送信元情報/送信内容を元に実行する処理（Service）が分岐するのですが、この辺を上手く分割できるように綺麗な設計を考え中です。

#### 参考
[Railsで導入してよかったデザインパターンと各クラスの役割について](http://masato-hi.hatenablog.jp/entry/2016/03/19/161712)

[大量メッセージが来ても安心なLINE BOTサーバのアーキテクチャ](https://qiita.com/yoichiro6642/items/6d4c7309210af20a5c8f)

<hr />

### ローカル環境

開発環境は各メンバー間の環境差をなくし、共通化を図るため、Dockerコンテナを利用して構築します。また、動作確認の際のローカル環境と、Line Messaging APIとの通信はngrokを利用して実現します。

基本的に、チームメンバー（ボット開発）の皆さんそれぞれに、Lineのデベロッパーアカウントを取得してもらい（無料）、ローカル環境で実装中のコードの動作確認をするためのLineボットを作成していただきます。

#### 手順(詳しくは下で解説)
1. ローカル環境のPCにDockerをインストールする
2. ローカル環境のPCにngrokをインストールする
3. ローカル環境にリポジトリのプロジェクト一式をcloneする
4. Lineデベロッパーアカウントの取得
5. 新規チャネル（Lineボット）の作成
6. ローカルの環境変数にsecretとtokenを登録
7. Dockerコンテナの起動
8. ngrokの起動
9. webhookURLの設定
10. 動作確認

**4、5については開発メンバーで共通で使える動作確認用のボットアカウントを用意することも考えています**

#### ローカル環境のPCにDockerをインストールする

[公式サイト](https://www.docker.com/products/docker-desktop)からDocker Desktop(Mac/Win)をインストールします。

#### ローカル環境のPCにngrokをインストールする

[公式サイト](https://ngrok.com/)からngrokの実行ファイルを取得し、実行パスを通します。


#### ローカル環境にリポジトリのプロジェクト一式をcloneする

このREADMEを読んでいるということは、すでに実施している可能性が高いですが、GitHub上のリポジトリからプロジェクト一式を取得します。

```
$ git clone https://github.com/iritec/sports_meet
```

#### Lineデベロッパーアカウントの取得

[Line Developers](https://developers.line.me/ja/)で、Lineアカウントを使って登録します。<br />
アカウントを作成したら、ログインして、「新規プロバイダー」を作成します。

*※この辺、だいぶ昔にやったので、詳しく説明出来なくてすみません（汗）*

#### 新規チャネル(ボットアカウント)の作成

プロバイダーを作成したら、そのプロバイダー内で「新規チャネル」を作成します。

プロバイダー画面の「新規チャネル作成」をクリックして、表示されたモーダルからMessaging APIを選択します。

![画像](https://dl.dropboxusercontent.com/s/z6m3pjbzlo3qeem/line_channel_0.png)
**画像中のセンシティブな情報は隠してます**

登録画面で各種設定項目を入力します。<br />
（プランは「Developer　Trial」を選択してください。）<br />
「入力項目を確認する」ボタンをクリックして、指示に沿って新規チャネルを作成してください。

![画像](https://dl.dropboxusercontent.com/s/2axydxf2jx06soa/line_channel_1.png)
**画像中のセンシティブな情報は隠してます**

作成したチャネルの設定画面の「チャネル基本設定」を開き、各項目を設定していきます。(画像参照)

![画像](https://dl.dropboxusercontent.com/s/28agf7b4ag2i6fj/line_channel_2.png)
**画像中のセンシティブな情報は隠してます**

設定項目は下記になります。

1. アクセストークンを生成する（期限は0日で作成してください）
2. Webhook送信を「利用する」に設定する
3. Botのグループトーク参加を「利用する」に設定する
4. 自動応答メッセージを「利用しない」
5. 友だち追加時あいさつを「利用しない」

#### ローカルの環境変数にsecretとtokenを登録

ローカルのホストOSの環境変数に以下のような形式で、「チャネル基本設定」の「Channel Secret」と「アクセストークン」を設定してください。

```
YURUSPO_LINE_CHANNEL_SECRET={Channel Secret}
YURUSPO_LINE_CHANNEL_TOKEN={アクセストークン}
```

MacとかUnix系OSの場合はshellの設定ファイルに
```
$ vim ~/.zshrc
```
下記のように記載して
```sh
...
export YURUSPO_LINE_CHANNEL_SECRET={Channel Secret}
export YURUSPO_LINE_CHANNEL_TOKEN={アクセストークン}
...
```
下記のように再読込すればOKです。
```
$ source ~/.zshrc
```

#### Dockerコンテナの起動

先程git cloneして取得したプロジェクトのディレクトリの`bot/`ディレクトリに移動します。
```
$ cd ./bot
```

下記のコマンドでイメージの構築とコンテナの起動を行います。
```
$ docker-compose up --build
```

上記コマンドで、バックエンドのウェブアプリ（app)、MySQL(db)、Redis(redis)、ジョブワーカー(worker)の4つのコンテナが立ち上がり、システムが起動します。

この状態だと、ターミナルに各コンテナのログが表示され続けます。
コンテナを終了したい場合は、ctrl+cで停止した後に、

```
$ docker-compose down
```
で、コンテナを破棄できます。

ログを表示させたくない場合は、

```
$ docker-compose up -d
```

で、バックグラインドで動作します。

次に、他のターミナルを開き、先ほどと同じディレクトリに移動し、下記のコマンドを実行してデータベースを作成します。
```
$ docker-compose run app rails db:create
```

**現状、コンテナを再起動した時に、railsが正常起動せずに落ちてしまうことがあります。**
**その時は、`bot/tmp/pid/server.pid`ファイルを手動で消してから、コンテナを起動してみてください。**

Docker(Docker Compose)については以下を参照してください。

[Docker Compose](http://docs.docker.jp/compose/index.html)<br />
[docker-compose コマンド概要](http://docs.docker.jp/compose/reference/overview.html)


#### ngrokの起動

ローカルで起動しているバックエンドのRailsアプリ(Webhook)が、インターネット上のLineサーバと通信できるように、ngrokを利用して通信をトンネリングします。

ngrokの実行ファイルに実行パスが通っている前提で、以下のコマンドを実行します。

```sh
$ ngrok http 3000
```
コマンドを実行すると、下記のように実行状態が表示されますので、Forwarding先のURL(https)をメモしておいてください。

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

##### Webhook URLを設定する

LineサーバからのHTTPリクエストを受けるバックエンドのWebhookURLを設定します。
作成したMessaging APIの「チャネルのWebhook URLを、起動中のngrokの公開URL（HTTPS）に設定する。

ex)
```
https://085eb739.ngrok.io/line/callback
```

##### 動作確認

チャネルの管理ページにあるQRコードからボットを友達追加して、チャットをしてみてください。<br />
オウム返しで返事が返ってくれば、環境構築完了です。

<hr />

#### ステージング環境
**要検討**

<hr />

#### 本番環境

**要検討**

<hr />

### タスク管理

タスクの管理は基本的にはチケット（issue)駆動開発を想定しています。実装する機能、修正するバグ等ごとにissueを発行し、担当するメンバーをアサインすることでタスクを分担して実行していきます。

**Githubの素のissue管理のスタイルにするか、Project機能を利用するか、Zenhubを利用したカンバン方式にするかは検討中**

<hr />

### ブランチの運用

基本的にはGithub-flowでの運用を考えています。チケット駆動開発を前提に、実装する機能のissueにアサインし、「issue-{issue番号}」という名前のブランチを切って開発→プルリクエスト→マージという流れになるかと思います。

**もうちょっと細かい検討が必要かも。。。**

<hr />

### テスト方針

**要検討**

<hr />

*内容に関する不明点、疑問点、ご意見等、またローカル環境に不備（動かない）等あれば、ヒロまでご連絡ください*

slack: @ヒロ<br />
github: @nbeat