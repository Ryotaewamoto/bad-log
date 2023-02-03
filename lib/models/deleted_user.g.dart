// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DeletedUser _$$_DeletedUserFromJson(Map<String, dynamic> json) =>
    _$_DeletedUser(
      uid: json['uid'] as String? ?? '',
      createdAt: alwaysUseServerTimestampUnionTimestampConverter
          .fromJson(json['createdAt'] as Object),
    );

Map<String, dynamic> _$$_DeletedUserToJson(_$_DeletedUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'createdAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.createdAt),
    };
