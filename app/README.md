# README

このプロジェクトはゆるすぽのLINEBotとWebアプリのシステムプロジェクトです。

## Ruby version

2.5.1

## Dependencies

* ライブラリはGemfileを参照してください
* ジョブキューシステムの利用に際し、バックエンドとしてredisをします


## Setup

ローカル環境の構築は以下を参照してください。

https://github.com/irie-dev/sports_meet/wiki/%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E9%96%8B%E7%99%BA%E7%92%B0%E5%A2%83


## Database creation

下記はローカル環境の場合です。

プロジェクトルートがカレントディレクトリの場合は以下でRailsアプリのルートに移動してください。
```
$ cd app
```
docker-compose runコマンドでコンテナを起動して、コンテナ上でDB作成コマンドを実行します。
```
$ docker-compose run app bundle exec rails db:create
```

## Database initialization

docker-compose runコマンドでコンテナを起動して、コンテナ上でDBマイグレーションコマンドを実行します。
```
$ docker-compose run app bundle exec rails db:migrate
```

また、住所情報のマスタ系データ（都道府県、市区町村、エリア）を下記のコマンドで挿入できます。
```
$ docker-compose run app bundle exec rails db:seed_fu
```
が、結構時間がかかるので、必要になった時か時間がある時に実行してください。

## How to run the test suite

テスト方針はまだ検討中です。
すみません。

## Services (job queues, cache servers, search engines, etc.)

ジョブキューシステムとしてsidekiqを使用しています。


##  Deployment instructions

必要になったら検討、追記します。
