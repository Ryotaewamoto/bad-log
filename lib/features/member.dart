import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/member.dart';
import '../repositories/auth/auth_repository_impl.dart';
import '../repositories/member/member_repository_impl.dart';
import '../utils/exceptions/app_exception.dart';

/// ユーザーの members コレクションを購読する [StreamProvider]。
final membersProvider = StreamProvider.autoDispose<List<Member>>((ref) {
  final userId = ref.watch(authRepositoryImplProvider).currentUser!.uid;
  final members = ref.read(memberRepositoryImplProvider).subscribeMembers(
        userId: userId,
        queryBuilder: (q) => q.orderBy('createdAt', descending: true),
      );
  return members;
});

/// [Member] に関して Firestore の操作を行う [AsyncNotifierProvider]。
final memberControllerProvider =
    AutoDisposeAsyncNotifierProvider<MemberController, void>(
  MemberController.new,
);

class MemberController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // FutureOr<void> より、初期の処理の必要がないため何もしない。
  }

  /// メンバーを追加する
  Future<void> createMember({
    required String userId,
    required Member member,
  }) async {
    final memberRepository = ref.read(memberRepositoryImplProvider);
    // メンバーの追加をローディング中にする
    state = const AsyncLoading();

    // メンバーの追加を実行する
    state = await AsyncValue.guard(() async {
      try {
        if (member.memberName.isEmpty) {
          throw const AppException(
            message: '名前を入力してください。',
          );
        }
        if (member.memberName.length > 20) {
          throw const AppException(
            message: '名前は20文字以内にしてください。',
          );
        }
        await memberRepository.create(
          userId: userId,
          member: member,
        );
      } on AppException {
        rethrow;
      }
    });
  }

  /// メンバー情報を更新する
  Future<void> updateMember({
    required String userId,
    required String memberId,
    required Member member,
  }) async {
    final memberRepository = ref.read(memberRepositoryImplProvider);
    // メンバー情報の更新をローディング中にする
    state = const AsyncLoading();

    // メンバー情報の更新を実行する
    state = await AsyncValue.guard(() async {
      try {
        if (member.memberName.isEmpty) {
          throw const AppException(
            message: '名前を入力してください。',
          );
        }
        if (member.memberName.length > 20) {
          throw const AppException(
            message: '名前は20文字以内にしてください。',
          );
        }
        await memberRepository.update(
          userId: userId,
          memberId: memberId,
          member: member,
        );
      } on AppException {
        rethrow;
      }
    });
  }

  /// メンバーを削除する
  Future<void> deleteMember({
    required String userId,
    required String memberId,
    required Member member,
  }) async {
    final memberRepository = ref.read(memberRepositoryImplProvider);
    // メンバーの削除をローディング中にする
    state = const AsyncLoading();

    // メンバーの削除を実行する
    state = await AsyncValue.guard(() async {
      try {
        await memberRepository.delete(
          userId: userId,
          memberId: memberId,
          member: member,
        );
      } on AppException {
        rethrow;
      }
    });
  }
}
