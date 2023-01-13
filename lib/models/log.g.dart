// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Log _$$_LogFromJson(Map<String, dynamic> json) => _$_Log(
      logId: json['logId'] as String? ?? '',
      resultId: json['resultId'] as String? ?? '',
      scoreId: json['scoreId'] as String? ?? '',
      createdAt: alwaysUseServerTimestampUnionTimestampConverter
          .fromJson(json['createdAt'] as Object),
    );

Map<String, dynamic> _$$_LogToJson(_$_Log instance) => <String, dynamic>{
      'logId': instance.logId,
      'resultId': instance.resultId,
      'scoreId': instance.scoreId,
      'createdAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.createdAt),
    };
