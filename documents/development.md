# Flutter開発ドキュメント
ここにはFlutterのコードを書いていく上での基礎知識や気をつけるべき点についてまとめておく。

## AppColors クラス

ファイル: lib/utils/constants/app_colors.dart

アプリ内の色はここから選択して使用する。クラスに定義されていない場合は随時追加する。

### Example:

```dart
Container(
    color: AppColors.primary,
    width: 100,
    height: 100,
),
```

### Figure:

<img src="https://user-images.githubusercontent.com/75112184/210955347-36d5d30c-5c77-4fb0-ab20-6867476c22ef.png" width=30%>

### 参考:

https://24sy.jp/color-system/

## Measure クラス

ファイル: lib/utils/constants/measure.dart

Padding 値や Widget と Widget に幅を持たせたい時などに使用する。名前に関しては以下のように省略して命名している。

a...allの略

t...topの略

b...bottomの略

l...leftの略

r...rightの略

v...verticalの略

h...horizonの略

br...border radiusの略

### Example:

```dart
Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Padding(
                padding: Measure.p_a16,
                child: Container(
                color: AppColors.primary,
                width: 100,
                height: 100,
                ),
            ),
            Container(
                color: AppColors.primary,
                width: 100,
                height: 100,
            ),
            Measure.g_16,
            Container(
                color: AppColors.secondary,
                width: 100,
                height: 100,
            ),
        ],
    ),
),
```

### Figure:

<img src="https://user-images.githubusercontent.com/75112184/210955358-e125f2f0-b53a-4db7-bb77-e23b1b02b140.png" width=30%>

### 参考:

https://zenn.dev/sgr_ksmt/articles/13e7f1f5b4f33a

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
