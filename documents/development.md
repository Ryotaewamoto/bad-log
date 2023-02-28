# 開発者向けドキュメント

開発に関して、``develop``ブランチからブランチを切って作業を行う。ブランチ名は``{自分の名前}/#{issue番号}_{実装内容の概略}``で行う。プルリクは少なくとも一人から``approve``されている状態で``develop``ブランチにマージする。

### ローカルでの開発の準備

#### リポジトリの複製

Github のリポジトリを複製するために任意のディレクトリで以下のコマンドを実行してください。

```shell
git clone https://github.com/Ryotaewamoto/bad-log.git
```

or

```shell
git clone git@github.com:Ryotaewamoto/bad-log.git
```

#### FVM の導入

Flutter のバージョンを統一するために[Flutter Version Management(略して、FVM)](https://fvm.app/)を使用します。まだインストールが済んでいない場合は[この記事](https://zenn.dev/altiveinc/articles/flutter-version-management)を参考にインストールをしてください。

このプロジェクトでは Flutter のバージョンは``3.3.10``を使用するのでルートディレクトリ（``bad-log``）で以下のコマンドを実行してください。

```shell
fvm use 3.3.10
```

#### Firebase の API key

既存の開発者にファイルを送信するようにお伝えください。


#### デバックビルドの確認

Android（iOSも同様）のエミュレータを起動し以下の操作を行い、デバックビルドが ``mobile-dev`` と ``mobile-prod`` で通るかどうかを確認してください。(VSCodeの場合)

<img src="https://user-images.githubusercontent.com/75112184/210572448-2b8be289-e06c-4a70-9a73-07b4d594b745.png" width=70%>

