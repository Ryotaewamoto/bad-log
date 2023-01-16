import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/member.dart';
import '../repositories/auth/auth_repository_impl.dart';
import '../repositories/member/member_repository_impl.dart';

/// ユーザーの Members コレクションを購読する StreamProvider。
final membersProvider = StreamProvider.autoDispose<List<Member>>((ref) {
  final userId = ref.watch(authRepositoryImplProvider).currentUser!.uid;
  final members = ref.read(memberRepositoryImplProvider).subscribeMembers(
        userId: userId,
        queryBuilder: (q) => q.orderBy('updatedAt', descending: true),
      );
  return members;
});
