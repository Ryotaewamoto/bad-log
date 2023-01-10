// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Member _$$_MemberFromJson(Map<String, dynamic> json) => _$_Member(
      memberId: json['memberId'] as String,
      memberName: json['memberName'] as String,
      createdAt: alwaysUseServerTimestampUnionTimestampConverter
          .fromJson(json['createdAt'] as Object),
      updatedAt: alwaysUseServerTimestampUnionTimestampConverter
          .fromJson(json['updatedAt'] as Object),
    );

Map<String, dynamic> _$$_MemberToJson(_$_Member instance) => <String, dynamic>{
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'createdAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.createdAt),
      'updatedAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.updatedAt),
    };
