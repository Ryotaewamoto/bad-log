import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/auth_repository_impl.dart';
import '../../utils/exceptions/app_exception.dart';
import '../../utils/extensions/firebase.dart';

final signInControllerProvider =
    AutoDisposeAsyncNotifierProvider<SignInController, void>(
  SignInController.new,
);

class SignInController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // FutureOr<void> より、初期の処理の必要がないため何もしない。
  }

  /// 新規登録する
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final authRepository = ref.read(authRepositoryImplProvider);
    // ログイン結果をローディング中にする
    state = const AsyncLoading();

    // ログイン処理を実行する
    state = await AsyncValue.guard(() async {
      try {
        if (email.isEmpty || password.isEmpty) {
          const exception = AppException(
            message: 'メールアドレスとパスワードを入力してください。',
          );
          throw exception;
        }
        await authRepository.signIn(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
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