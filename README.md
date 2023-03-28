# Bad Log

バドミントンの試合結果をサクッと記録できるアプリ

[App Store](https://apps.apple.com/us/app/badlog/id1666920940?platform=iphone)

[Google Play](https://play.google.com/store/apps/details?id=com.ryotaiwamoto.bad_log)

## デザイン

デザインに関しては [Figma](https://www.figma.com) を使用しています。初期段階のデザインではありますが、下記にリンクを記載しておきます。

[Figma のデザインを確認したい方はこちら](https://www.figma.com/file/LY24EomidE9RTpw4awTbUg/BadLog?node-id=0%3A1&t=lxvxri5zqKEC0Uoa-0)

<img src="https://user-images.githubusercontent.com/75112184/216820105-6e7646fc-75d2-472a-bea9-648cc7f981bb.png" width=500>

## スクリーンショット

※各スクリーンショットは ``iPhone 11 Pro Max`` のものです。

<img src="https://user-images.githubusercontent.com/75112184/216643981-f739adcf-bb34-4945-8ee7-cbfc8af9db7a.png" width=300><img src="https://user-images.githubusercontent.com/75112184/216643971-d83866fb-bc14-411f-b1e2-9860fbe901aa.png" width=300><img src="https://user-images.githubusercontent.com/75112184/216643946-5c5c1667-c32d-4c8d-af8e-7e239b17cd5e.png" width=300><img src="https://user-images.githubusercontent.com/75112184/216819429-a441377d-6115-47e9-be78-cdd7c80fd335.png" width=300><img src="https://user-images.githubusercontent.com/75112184/216819427-3e27a6ff-b235-40f7-9878-bfb4f7a7b2e4.png" width=300><img src="https://user-images.githubusercontent.com/75112184/216819426-5903c395-2f72-4e48-bd39-ee92fe0140cc.png" width=300><img src="https://user-images.githubusercontent.com/75112184/216819422-f4e9ffb3-b24d-4cb8-b609-07b030659e5d.png" width=300><img src="https://user-images.githubusercontent.com/75112184/216819418-8651c46f-309c-43a9-9ad9-7e370964021d.png" width=300><img src="https://user-images.githubusercontent.com/75112184/216819416-c5033575-22ac-42af-9422-86da87414daa.png" width=300><img src="https://user-images.githubusercontent.com/75112184/216819412-a4028d7b-5a36-4444-b9d4-4e8c0c2af370.png" width=300><img src="https://user-images.githubusercontent.com/75112184/216819411-f4f18ec8-5147-42fd-960b-43a6bfc9e6a3.png" width=300><img src="https://user-images.githubusercontent.com/75112184/216819407-b887cd42-38dd-4955-84bd-7064baf55269.png" width=300>

## アプリの機能

- サインアップ
- サインイン
- サインアウト
- アカウント削除
- 試合結果の登録
- メンバーの登録
- メンバーの編集
- メンバーの削除

## 使用技術

- [Flutter](https://flutter.dev/)

```
// 開発環境
% fvm flutter --version
Flutter 3.3.10 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 135454af32 (9 weeks ago) • 2022-12-15 07:36:55 -0800
Engine • revision 3316dd8728
Tools • Dart 2.18.6 • DevTools 2.15.0
```

- [Firebase](https://firebase.google.com/)
    - [Authentication](https://firebase.google.com/products/auth)（認証）
    - [Cloud Firestore](https://firebase.google.com/products/firestore)（データベース）
    - [Cloud Functions](https://firebase.google.com/products/functions)
    - [Extensions](https://firebase.google.com/products/extensions)
    - [App Check](https://firebase.google.com/products/app-check)

## フォルダ構成

基本的な構成は以下の図のようになります。

<img src="https://user-images.githubusercontent.com/75112184/228169653-23ab4342-1b01-4dba-84a8-f78c89931f3c.png" width=600>

```
.
├── app.dart
├── features（状態管理）
├── gen（画像やフォント）
├── main.dart
├── models（ドメイン）
├── pages（画面）
├── repositories（リポジトリ）
├── utils（定数やダイアログ、ローディングなど）
└── widgets（共通ウィジェット）
```

## 今後の予定

- 全体的なリファクタリング（Riverpod の StateNotifier --> AsyncNotifier）
- テストコードの記述
- CD の構築（= GitHub Actions による配布の自動化）
- 試合結果の編集
- 課金機能
- 画像の追加機能
- 多言語対応

## その他

<!-- [開発者を始める方はこちら]() -->

