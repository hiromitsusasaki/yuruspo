# README
*後でもっと詳細に書きます*

## yuruspo

ゆるすぽプロジェクトのリポジトリ

### 構成

リポジトリは以下の構成になっています。

<pre>
yuruspo/
　├ admin/   ... 管理システム
　├ bot/     ... ボット用バックエンドシステム
　├ webapp/  ... ウェブアプリケーション
</pre>

* [yuruspo/admin](https://github.com/iritec/sports_meet/tree/master/admin)
* [yuruspo/bot](https://github.com/iritec/sports_meet/tree/master/bot)
* [yuruspo/webapp](https://github.com/iritec/sports_meet/tree/master/webapp)

サブディレクトリはそれぞれが一つのRailsアプリケーションとして構築されます。

**各Railsアプリケーションが単一のDBを参照するので、将来的にはModel層をRailsEngineでプラグイン化し、共通化をはかります。（後でやる）**




