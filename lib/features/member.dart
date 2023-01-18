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
        queryBuilder: (q) => q.orderBy('updatedAt', descending: true),
      );
  return members;
});

/// Firestore に [Member] を追加する [AsyncNotifierProvider]。
final createMemberControllerProvider =
    AutoDisposeAsyncNotifierProvider<CreateMemberController, void>(
  CreateMemberController.new,
);

class CreateMemberController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // FutureOr<void> より、初期の処理の必要がないため何もしない。
  }

  /// 試合結果を追加する
  Future<void> createMember({
    required String userId,
    required Member member,
  }) async {
    final memberRepository = ref.read(memberRepositoryImplProvider);
    // 試合結果の追加をローディング中にする
    state = const AsyncLoading();

    // 試合結果の追加を実行する
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
}
