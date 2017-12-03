# これは何か

Googleカレンダーを読み込み、連携したSNSに自動宣伝するツールを目指します

# 開発設計というかメモ

```

イベント宣伝ツール

- 運営チームの一部は公式アカウントを追加できる
	- Facebook
	- Twitter
- 運営チームの誰もがイベントを追加できる
- 同誰もがイベントの宣伝を予約できる
	- 予約とは？Facebook、TwitterなどのSNSに公式アカウントから発信できる
- ログインしてない人に公開カレンダーが提示される
- 発信したい場所
	- Twitter
	- Facebook
		- タイムライン
		- Facebookページ


# 入力とその認証
Google Calendarを使う

# SNS発信連携

OAuthを使う


# 想定する流れ

0. Webアプリを作成
1. Google OAuth ログイン
2. カレンダー 一覧表示 > 宣伝用カレンダーを選択
	1. (此のカレンダーをみんなに宣伝しておく)
3. OAuthログインで連携したい公式アカウントでログイン
	4. Twitter
	5. Facebook
4. 告知するタイミングを適当に設定（例えば二週間前、一週間前、前日、当日など)
5. 終了
6. 毎時実行、4. がきたら 3. のトークン & 2. の内容を使って宣伝

# 必要な機能

Google ログイン
Google カレンダー API (maybe OAuth)
Twitter 連携 API (OAuth)
Facebook 連携　API (OAuth、宣伝するページやアカウントを設定しないといけないかも)

# 使えばよさそう
Rails OmniAuth(Google, Twitter, FB)
Rails Task (Cron)
Heroku

```



# Google API の設定

Google Cloud Platform にいって、プロジェクト作成

- Google Calendar API
- Google+ API

を有効にする。(後者が有効じゃないとなぜかエラーでダメだった。Omniauthがデフォルトで求めるscopeの問題か？)

認証情報をダウンロードして .env_sample をリネームして書き込み、.env を作成してください。


# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# リフレッシュトークンが発行されない

- [Deviseとomniauth-google-oauth2でrefresh_tokenが発行される条件を調べてみた - Qiita](https://qiita.com/s-show/items/3d5f97c8253748ad0e2b)

- [oauth 2.0 - How do I get back a 'refresh_token' for rails app with omniauth google oauth2? - Stack Overflow](https://stackoverflow.com/questions/17894192/how-do-i-get-back-a-refresh-token-for-rails-app-with-omniauth-google-oauth2)

## 解決方法

どうやら `scope` を追加して認証だけじゃなく、カレンダーなどのサービスに接続する場合には `prompt: 'consent'` をOmniauthの設定で指定してあげないとダメなようだ。最終的には以下

``` ruby
  provider :google_oauth2,
           ENV['GOOGLE_CLIENT_ID'],
           ENV['GOOGLE_SECRET'],
           {
             image_size: 150,
             name: :google,
             access_type: 'offline',
             scope: https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/calendar',
             prompt: 'consent'
           }

```

