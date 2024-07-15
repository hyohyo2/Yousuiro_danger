# [危険！！用水路安全確認マップ](http://52.68.222.79/)


## サイト概要
### サイトテーマ
用水路の転落事故減少を目的としたＳＮＳサイト
​
### テーマを選んだ理由
私の出身地である岡山県は干拓されている土地が多いです。
さらに1級河川が県中央と東西の３か所に流れており農業用地が多いため、
特に県南が用水路が多く、岡山市だけで全国の1％に当たる4000キロもの用水路が存在するといわれています。
そして用水路の転落事故が毎年報告されており、私自身学生時代の友人が何人も用水路に転落したことがあります。
幸い大きなけがはしませんでしたが、雨の時に転落した友人もいたため非常に危険であると幼い頃から認識していました。
近年は用水路に柵が設置されている箇所も増えてきましたが、転落事故は発生し続けています。
その被害者の多くは子どもや高齢者です。
おそらく他の地域でもこのような用水路事故が発生しているのではないかと考えているため、
用水路の事故を１件でも減らせるよう、住民同士が用水路に関する情報を発信できるサイトを作成しました。
​
### ターゲットユーザ
- 用水路の近くが通学路となっている学生
- 用水路の近くが通学路となっている学生の家族
- 用水路の近くに住んでいる人
- 用水路の近くを通る人
​
### 主な利用シーン
- 事前に柵のない等用水路の危険箇所を確認したいとき。
- 危険な用水路に対して柵の設置など安全策が取られたことを確認したいとき。
​
## 設計書
- [UI flows](https://drive.google.com/file/d/1UGGPR_NhUvkXba88xWndPVkbEO7nCPgR/view?usp=sharing)
- [ER図](https://drive.google.com/file/d/1uwR_ugBGI4L7qKkLmOFCLGgBOxim0wRQ/view?usp=sharing)
- [テーブル定義書](https://docs.google.com/spreadsheets/d/1fRSA3XEbFIdUtnC2txnp3PhowAbjoiFuHv5vUK5BVYQ/edit?usp=sharing)
- [アプリケーション詳細設計](https://docs.google.com/spreadsheets/d/1BsOuHHqLaxmVjB671dxxIgf9kfoycptCehEwiUI5J3c/edit?usp=sharing)
- [AWS構成図](https://drive.google.com/file/d/1VyP7lQa_55qQOVu0hoQC-gGGrpb1AqQM/view?usp=sharing)

​
## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 実装機能
ゲストログイン、会員機能、投稿機能、検索機能、ユーザー管理機能、いいね機能、いいね一覧表示機能、  
フォロー機能、コメント機能、他者投稿をタイムラインで共有、地図表示機能(google map API/geocoder)、  投稿数算出、通知機能、DM機能  
(非同期通信：フォロー機能、いいね機能、DM機能)  
レスポンシブ対応(768pxまで)

## サイトトップページ
 ![スクリーンショット 2024-07-11 151438](https://github.com/hyohyo2/Yousuiro_danger/assets/163430298/61dd8493-be8d-4dcc-ab5e-5e20af7635b3)  
 ※サイト内であらかじめ投稿をしている投稿内容はあくまで一例です。ご了承ください。

## 使用素材
- フリー素材ぱくたそ［ https://www.pakutaso.com ］
- 著作権を考慮し、架空のデータを扱う予定です。
なお今後、実在するデータを利用する際には、事前に著作権保持者と契約を結んだ上で利用します。

## 作者
- [Xアカウント](https://x.com/rnew48y)