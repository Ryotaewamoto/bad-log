import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/member.dart';
import '../../utils/firestore_refs.dart';
import '../../utils/logger.dart';
import 'member_repository.dart';

final memberRepositoryImplProvider = Provider<MemberRepositoryImpl>(
  (ref) => MemberRepositoryImpl(),
);

class MemberRepositoryImpl implements MemberRepository {
  /// 指定した Member を取得する。
  @override
  Future<Member?> fetchMember({
    required String userId,
    required String memberId,
  }) async {
    final ds = await memberRef(userId: userId, memberId: memberId).get();
    if (!ds.exists) {
      logger.warning('Document not found: ${ds.reference.path}');
      return null;
    }
    return ds.data();
  }

  /// Member 一覧を購読する。
  @override
  Stream<List<Member>> subscribeMembers({
    required String userId,
    Query<Member>? Function(Query<Member> query)? queryBuilder,
    int Function(Member lhs, Member rhs)? compare,
  }) {
    Query<Member> query = membersRef(userId: userId);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    return query.snapshots().map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }
}
