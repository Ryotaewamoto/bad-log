import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/deleted_user.dart';
import '../../repositories/app_user/app_user_repository_impl.dart';
import '../../repositories/auth/auth_repository_impl.dart';
import '../../utils/exceptions/app_exception.dart';
import '../../utils/extensions/firebase_auth_exception.dart';
import '../../utils/json_converters/union_timestamp.dart';

/// 削除アカウントの作成後、Firebase Auth を用いてサインアウトをする [AsyncNotifierProvider]。
final deleteAccountControllerProvider =
    AutoDisposeAsyncNotifierProvider<DeleteAccountController, void>(
  DeleteAccountController.new,
);

class DeleteAccountController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // FutureOr<void> より、初期の処理の必要がないため何もしない。
  }

  /// 削除アカウントの作成後にサインアウトする
  Future<void> deleteAccount() async {
    final userId = ref.watch(authRepositoryImplProvider).currentUser!.uid;
    final authRepository = ref.read(authRepositoryImplProvider);
    final appUserRepository = ref.read(appUserRepositoryImplProvider);

    final deletedUser = DeletedUser(
      uid: userId,
      createdAt: UnionTimestamp.dateTime(DateTime.now()),
    );

    // ローディング中にする
    state = const AsyncLoading();

    // 削除アカウントの作成とサインアウト処理を実行する
    state = await AsyncValue.guard(() async {
      try {
        await appUserRepository.delete(deletedUser: deletedUser);
        await authRepository.signOut();
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
