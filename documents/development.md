# Flutter開発ドキュメント
ここにはFlutterのコードを書いていく上での基礎知識や気をつけるべき点についてまとめておく。

## Measure クラス
ファイル: lib/utils/constants/measure.dart

Padding 値や Widget と Widget に幅を持たせたい時などに使用する。

example:
```dart
```

参考:
https://zenn.dev/sgr_ksmt/articles/13e7f1f5b4f33a

## AppColors クラス
ファイル: lib/utils/constants/app_colors.dart

アプリ内の色はここから選択して使用する。クラスに定義されていない場合は随時追加する。

example:
```dart
```

参考:
https://24sy.jp/color-system/

## 画面遷移

GoRouter や NamedRoute 等は使わずに下記のようにして画面遷移を行う。

```dart
onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute<bool>(
        builder: (_) => const AccountPage(),
    ),
    );
},
```

もし、前の画面戻りたくない場合には下記のように記述する。

```dart
Navigator.pushAndRemoveUntil<dynamic>(
    context,
    MaterialPageRoute<dynamic>(
        builder: (_) => const LogInPage(),
    ),
    (_) => false,
);
```
