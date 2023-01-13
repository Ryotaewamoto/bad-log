// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Result _$$_ResultFromJson(Map<String, dynamic> json) => _$_Result(
      resultId: json['resultId'] as String? ?? '',
      type: json['type'] as String? ?? 'singles',
      partner: json['partner'] as String? ?? '',
      opponents: (json['opponents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      createdAt: alwaysUseServerTimestampUnionTimestampConverter
          .fromJson(json['createdAt'] as Object),
      updatedAt: alwaysUseServerTimestampUnionTimestampConverter
          .fromJson(json['updatedAt'] as Object),
    );

Map<String, dynamic> _$$_ResultToJson(_$_Result instance) => <String, dynamic>{
      'resultId': instance.resultId,
      'type': instance.type,
      'partner': instance.partner,
      'opponents': instance.opponents,
      'createdAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.createdAt),
      'updatedAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.updatedAt),
    };
