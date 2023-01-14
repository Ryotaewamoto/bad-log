import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/score.dart';
import '../../utils/firestore_refs.dart';
import '../../utils/logger.dart';

final scoreRepositoryImplProvider = Provider<ScoreRepositoryImpl>(
  (ref) => ScoreRepositoryImpl(),
);

class ScoreRepositoryImpl implements ScoreRepository {
  @override
  Future<void> create({
    required String userId,
    required String resultId,
    required Score score,
  }) async {
    await scoresRef(userId: userId, resultId: resultId).add(
      score,
    );
  }

  /// 指定した Score を取得する。
  @override
  Future<Score?> fetchScore({
    required String userId,
    required String resultId,
    required String scoreId,
  }) async {
    final ds = await scoreRef(
      userId: userId,
      resultId: resultId,
      scoreId: scoreId,
    ).get();
    if (!ds.exists) {
      logger.warning('Document not found: ${ds.reference.path}');
      return null;
    }
    return ds.data();
  }

  /// Score 一覧を購読する。
  @override
  Stream<List<Score>> subscribeScores({
    required String userId,
    required String resultId,
    Query<Score>? Function(Query<Score> query)? queryBuilder,
    int Function(Score lhs, Score rhs)? compare,
  }) {
    Query<Score> query = scoresRef(userId: userId, resultId: resultId);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    return query.snapshots().map((qs) {
      final score = qs.docs.map((qds) => qds.data()).toList();
      if (compare != null) {
        score.sort(compare);
      }
      return score;
    });
  }
}

abstract class ScoreRepository {
  Future<void> create({
    required String userId,
    required String resultId,
    required Score score,
  });

  Future<Score?> fetchScore({
    required String userId,
    required String resultId,
    required String scoreId,
  });

  Stream<List<Score>> subscribeScores({
    required String userId,
    required String resultId,
    Query<Score>? Function(Query<Score> query)? queryBuilder,
    int Function(Score lhs, Score rhs)? compare,
  });
}
