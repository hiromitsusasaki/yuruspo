# README
*後でもっと詳細に書きます*

## yuruspo

ゆるすぽプロジェクトのリポジトリ

### 構成

リポジトリは以下の構成になっている。

<pre>
yuruspo/
　├ admin/   ... 管理システム
　├ bot/     ... ボット用バックエンドシステム
　├ webapp/  ... ウェブアプリケーション
</pre>

* [yuruspo/admin](https://github.com/nbeat/yuruspo/admin)
* [yuruspo/bot](https://github.com/nbeat/yuruspo/bot)
* [yuruspo/webapp](https://github.com/nbeat/yuruspo/webapp)

サブディレクトリはそれぞれが一つのRailsアプリケーションとして構築される。

各Railsアプリケーションが単一のDBを参照するので、将来的にはModel層をRailsEngineでプラグイン化し、共通化をはかる。



