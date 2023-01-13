import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/union_timestamp.dart';

part 'score.freezed.dart';
part 'score.g.dart';

@freezed
class Score with _$Score {
  const factory Score({
    @Default('') String scoreId,
    @Default(<int>[]) List<int> yours,
    @Default(<int>[]) List<int> opponents,
    @Default(true) bool isWinner,
    @Default('') String comment,
    @alwaysUseServerTimestampUnionTimestampConverter
        required UnionTimestamp createdAt,
    @alwaysUseServerTimestampUnionTimestampConverter
        required UnionTimestamp updatedAt,
  }) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  factory Score.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return Score.fromJson(<String, dynamic>{
      ...data,
      'scoreId': ds.id,
    });
  }

  const Score._();
}
