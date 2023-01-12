import 'package:firebase_core/firebase_core.dart';

import '/firebase_options_dev.dart' as dev_options;
import '/firebase_options_prod.dart' as prod_options;

const flavorString = String.fromEnvironment('FLAVOR');

/// dart-define で設定した flavor 文字列から特定される Flavor 変数。
final flavor = Flavor.values.firstWhere((f) => f.name == flavorString);

/// Flutter のビルドオプションの flavor
enum Flavor {
  dev,
  prod;

  const Flavor();

  /// 接続先 Firebase プロジェクト。
  FirebaseOptions get firebaseOptions {
    switch (this) {
      case prod:
        return prod_options.DefaultFirebaseOptions.currentPlatform;
      case dev:
        return dev_options.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
