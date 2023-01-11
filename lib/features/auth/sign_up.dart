import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/auth_repository.dart';
import '../../utils/exceptions/app_exception.dart';
import '../../utils/extensions/firebase.dart';

final signUpControllerProvider =
    AutoDisposeAsyncNotifierProvider<SignUpController, void>(
  SignUpController.new,
);

class SignUpController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    throw UnimplementedError();
  }

  /// 新規登録する
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    // ログイン結果をローディング中にする
    state = const AsyncLoading();

    // ログイン処理を実行する
    state = await AsyncValue.guard(() async {
      try {
        await authRepository.signUp(email, password);
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
