import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/auth_repository.dart';
import '../../utils/exceptions/app_exception.dart';
import '../../utils/extensions/firebase.dart';

final signOutControllerProvider =
    AutoDisposeAsyncNotifierProvider<SignOutController, void>(
  SignOutController.new,
);

class SignOutController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    throw UnimplementedError();
  }

  /// 新規登録する
  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    // ログイン結果をローディング中にする
    state = const AsyncLoading();

    // ログイン処理を実行する
    state = await AsyncValue.guard(() async {
      try {
        await authRepository.signOut();
      } on FirebaseException catch (e) {
        final exception = AppException(
          code: e.code,
          message: e.toJapanese,
        );
        debugPrint(e.code);
        throw exception;
      }
    });
  }
}
