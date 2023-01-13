// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Score _$$_ScoreFromJson(Map<String, dynamic> json) => _$_Score(
      scoreId: json['scoreId'] as String? ?? '',
      yours: (json['yours'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          const <int>[],
      opponents: (json['opponents'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const <int>[],
      isWinner: json['isWinner'] as bool? ?? true,
      comment: json['comment'] as String? ?? '',
      createdAt: alwaysUseServerTimestampUnionTimestampConverter
          .fromJson(json['createdAt'] as Object),
      updatedAt: alwaysUseServerTimestampUnionTimestampConverter
          .fromJson(json['updatedAt'] as Object),
    );

Map<String, dynamic> _$$_ScoreToJson(_$_Score instance) => <String, dynamic>{
      'scoreId': instance.scoreId,
      'yours': instance.yours,
      'opponents': instance.opponents,
      'isWinner': instance.isWinner,
      'comment': instance.comment,
      'createdAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.createdAt),
      'updatedAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.updatedAt),
    };
