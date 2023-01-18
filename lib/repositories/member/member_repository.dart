import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/member.dart';

abstract class MemberRepository {
  Future<Member?> fetchMember({
    required String userId,
    required String memberId,
  });

  Stream<List<Member>> subscribeMembers({
    required String userId,
    Query<Member>? Function(Query<Member> query)? queryBuilder,
    int Function(Member lhs, Member rhs)? compare,
  });

  Future<void> create({
    required String userId,
    required Member member,
  });
}
