import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/union_timestamp.dart';

part 'log.freezed.dart';
part 'log.g.dart';

@freezed
class Log with _$Log {
  const factory Log({
    @Default('') String logId,
    @Default('') String resultId,
    @Default('') String scoreId,
    @alwaysUseServerTimestampUnionTimestampConverter
        required UnionTimestamp createdAt,
  }) = _Log;

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);

  factory Log.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return Log.fromJson(<String, dynamic>{
      ...data,
      'logId': ds.id,
    });
  }

  const Log._();
}
