import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/union_timestamp.dart';

part 'member.freezed.dart';
part 'member.g.dart';

@freezed
class Member with _$Member {
  const factory Member({
    required String memberId,
    required String memberName,
    @alwaysUseServerTimestampUnionTimestampConverter
        required UnionTimestamp createdAt,
    @alwaysUseServerTimestampUnionTimestampConverter
        required UnionTimestamp updatedAt,
  }) = _Member;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  factory Member.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return Member.fromJson(<String, dynamic>{
      ...data,
      'memberId': ds.id,
    });
  }

  const Member._();
}
