import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/union_timestamp.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@freezed
class Result with _$Result {
  const factory Result({
    @Default('') String resultId,
    @Default('singles') String type,
    @Default('') String partner,
    @Default(<String>[]) List<String> opponents,
    @Default(<int>[]) List<int> yourScore,
    @Default(<int>[]) List<int> opponentsScore,
    @Default(true) bool isWinner,
    @Default('') String comment,
    @alwaysUseServerTimestampUnionTimestampConverter
        required UnionTimestamp createdAt,
    @alwaysUseServerTimestampUnionTimestampConverter
        required UnionTimestamp updatedAt,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  factory Result.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return Result.fromJson(<String, dynamic>{
      ...data,
      'resultId': ds.id,
    });
  }

  const Result._();
}
