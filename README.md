# アプリケーション名
  KoruAPP
# アプリケーション概要
  近所のコワーキングスペース（KoRuRワーキングスペース（仮称））を席のタイプごとに日時を指定していつでも予約・決済出来る。
# URL
  https://koruapp-40508.onrender.com/
# テスト用アカウント
  ・Basic認証パスワード：2222<br>
  ・Basic認証ID：admin<br>
  ・メールアドレス：neko@gomail<br>
  ・パスワード：neko1234<br>
  ・メールアドレス：wanwan@mail<br>
  ・パスワード：wan1234 
# 利用方法
 ## 予約する（・購入する）
  1.トップページの真ん中にある緑の「新規登録」ボタンからユーザー新規登録を行う。<br>
  2.新規登録したら、以下の方法で予約する。<br>
   ①トップページのカレンダーの予約したい日が空席「◯」の場合、「◯」を選択すると新規予約ページに遷移する。<br>
   ②新規予約画面のプルダウンから、「席のタイプ」を選択して赤の「予約を完了する」ボタンを押すと購入画面に遷移する。
   （クレジット決済機能※は実装中）<br>
   ③紫色の「購入確定」のリンクを押すと、「予約完了」と「お店で直接お支払い下さい」のご案内が表示され、トップページに戻る。<br>
   ④カレンダーの予約日に予約した「席のタイプ」名が表示されて、予約完了
    （※クレジット決済機能：「購入」ボタンを押したら決済画面に遷移し、オンラインクレジット決済できる様に現在、実装中）<br>
 ## 予約を修正する
    予約を修正したい場合は、緑の「予約を修正したい場合：予約画面に戻る」を押すと予約編集画面に遷移し、予約を修正できる。
 ## 予約を確認・削除する
    会員登録したユーザーは、マイページが作成され、マイページから自分の予約確認・削除、これまでの利用履歴などが確認できる。
 ## 少し先の期日を予約をする
    3カ月先まで予約できるので、週間カレンダーに表示されていないくらい先の期日を予約したい場合  

    ①エメラルドグリーン色の「手のマーク：予約する」ボタンを押し、予約画面に遷移する。  

    ②期日・時間・席のタイプを選択し予約できる。
    (’翌週’ボタンを押して、予約したい日のカレンダーまで週送りで遷移させても同じように予約出来る。)  

# アプリケーションを作成した背景
  近所のコワーキングスペースが電話予約しかしていなかった。（どの様な席があり、空いているのか等の確認も電話でしか分からない。）
  オンラインで予約できるアプリがあれば良いのにと考えたっことがきっかけ。
  家事・育児・仕事・勉強と少しでも時間が欲しい人（今回は自分）が好きな時にコワーキングスペースの予約・決済ができる様になる。
# 洗い出した要件
  （KORUAPP)要件定義シート(作成中) :<br>
   https://docs.google.com/spreadsheets/d/1LGVFdVJ8-5S6trL6_rDv9o3nony_1-75f_1-1_HxA_o/edit#gid=982722306
# 実装した機能についての画像やGIF及びその説明
  トップページ
  [![Image from Gyazo](https://i.gyazo.com/4e85230085d892ea81a71f776863943d.jpg)](https://gyazo.com/4e85230085d892ea81a71f776863943d)

  席のタイプ一覧
  [![Image from Gyazo](https://i.gyazo.com/64b74e0837820881c8ad925fd800e06c.jpg)](https://gyazo.com/64b74e0837820881c8ad925fd800e06c)

  カレンダーの表示（空席確認画面）
  [![Image from Gyazo](https://i.gyazo.com/2e35fc31ba0a73066c617e0d2fb0b37d.png)](https://gyazo.com/2e35fc31ba0a73066c617e0d2fb0b37d)

  空席「◯」を選択から予約完了までの一連の流れGIF
  [![Image from Gyazo](https://i.gyazo.com/e00a7ab0486a4da1b94b2b83298c3587.gif)](https://gyazo.com/e00a7ab0486a4da1b94b2b83298c3587)

  予約完了画面（購入画面）
  [![Image from Gyazo](https://i.gyazo.com/01fa86e5c79dfdfbdfa4cd92336fa89f.jpg)](https://gyazo.com/01fa86e5c79dfdfbdfa4cd92336fa89f)

  マイページ
  [![Image from Gyazo](https://i.gyazo.com/d522d07926def49a066a09873510ec18.jpg)](https://gyazo.com/d522d07926def49a066a09873510ec18)

# 実装予定の機能
・クレジット決済機能<br>
・SNSアカウント連携の会員登録機能<br>

# データベース設計
 ## テーブル
  ## users テーブル

| Column                | Type    | Options                   |
| --------------------- | ------- | ------------------------- |
| name                  | string  | null: false               |
| email                 | string  | null: false, unique: true |
| encrypted_password    | string  | null: false               |
### Association

- has_many :reservations
- has_many :orders

## reservations テーブル

| Column                       | Type       | Options                        |
| ---------------------------- | ---------- | ------------------------------ |
| seat_type_id                 | integr     | null: false                    |
| user                         | references | null: false, foreign_key: true |
| day                          | date       | null: false                    |
| time                         | date       | null: false                    |
| start_time                   | date       | null: false                    |

### Association

- belongs_to :user
- has_one    :order


## orders テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| reservation  | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- belongs_to :reservation

## ER図
![alt text](https://file%2B.vscode-resource.vscode-cdn.net/Users/tc-user/projects/KoruApp_40508/ER.png?version%3D1715582361212)

# 開発環境  
・フロントエンド：HTML/CSS 、Javascripts<br>
・バックエンド：Ruby, Ruby on Rails 7.0<br>
・インフラ：Render<br>
・テキストエディタ：VSCode<br>

# ローカルでの動作方法
  % git clone https://github.com/Jyoumama/KoruApp_40508<br>
  % cd ~/projects/<br>
  % cd KoruApp_40508<br>

# 工夫したポイント
  プログラミング言語を学ぶ際に10週間後に「近所のコワーキングスペース予約アプリ」を作れる様になるという目標を立てた。
  自身の人生で初めて作成したアプリ。
  予約アプリは世の中にたくさんあり、「車輪の再発明」ではあるが自分なりに「見やすさ」を工夫した。
# 改善点
  1.荒削りなコード<br>
    パーシャルを利用できていないなど、コードが全体的に洗練されていないため、学習を積み、更に洗練されたコードが書ける様にする。<br>
  2.Pay.JP API等を使用した実装<br>
    カリキュラムで実施したPay.JP APIを用いたクレジット決済機能を実装し、さらに実用的なアプリを目指す。<br>
# 制作時間
  概ね２週間半
