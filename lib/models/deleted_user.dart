import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/union_timestamp.dart';

part 'deleted_user.freezed.dart';
part 'deleted_user.g.dart';

@freezed
class DeletedUser with _$DeletedUser {
  const factory DeletedUser({
    @Default('') String uid,
    @alwaysUseServerTimestampUnionTimestampConverter
        required UnionTimestamp createdAt,
  }) = _DeletedUser;

  factory DeletedUser.fromJson(Map<String, dynamic> json) =>
      _$DeletedUserFromJson(json);

  factory DeletedUser.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return DeletedUser.fromJson(<String, dynamic>{
      ...data,
    });
  }

  const DeletedUser._();
}
