import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'constants/snack_bar.dart';

final scaffoldMessengerKeyProvider = Provider(
  (_) => GlobalKey<ScaffoldMessengerState>(),
);

final scaffoldMessengerServiceProvider =
    Provider.autoDispose(ScaffoldMessengerService.new);

/// ツリー上部の ScaffoldMessenger 上でスナックバーやダイアログの表示を操作する。
class ScaffoldMessengerService {
  ScaffoldMessengerService(this._ref);

  final AutoDisposeProviderRef<ScaffoldMessengerService> _ref;

  GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _ref.read(scaffoldMessengerKeyProvider);

  /// showDialog で指定したビルダー関数を返す。
  Future<T?> showDialogByBuilder<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: scaffoldMessengerKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }

  /// スナックバーを表示する。
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    bool removeCurrentSnackBar = true,
    Duration duration = defaultSnackBarDuration,
  }) {
    final scaffoldMessengerState = scaffoldMessengerKey.currentState!;
    if (removeCurrentSnackBar) {
      scaffoldMessengerState.removeCurrentSnackBar();
    }
    return scaffoldMessengerState.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: defaultSnackBarBehavior,
        duration: duration,
      ),
    );
  }

  /// FirebaseException 起点でスナックバーを表示する
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSnackBarByFirebaseException(
    FirebaseException e,
  ) {
    return showSnackBar(
      '[${e.code}]: ${e.message ?? 'FirebaseException が発生しました。'}',
    );
  }
}
