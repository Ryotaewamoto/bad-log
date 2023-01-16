import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/result.dart';
import '../../utils/firestore_refs.dart';
import '../../utils/logger.dart';

final resultRepositoryImplProvider = Provider<ResultRepositoryImpl>(
  (ref) => ResultRepositoryImpl(),
);

class ResultRepositoryImpl implements ResultRepository {
  @override
  Future<void> create({
    required String userId,
    required Result result,
  }) async {
    await resultsRef(userId: userId).add(
      result,
    );
  }

  /// 指定した Result を取得する。
  @override
  Future<Result?> fetchResult({
    required String userId,
    required String resultId,
  }) async {
    final ds = await resultRef(userId: userId, resultId: resultId).get();
    if (!ds.exists) {
      logger.warning('Document not found: ${ds.reference.path}');
      return null;
    }
    return ds.data();
  }

  /// Result 一覧を購読する。
  @override
  Stream<List<Result>> subscribeResults({
    required String userId,
    Query<Result>? Function(Query<Result> query)? queryBuilder,
    int Function(Result lhs, Result rhs)? compare,
  }) {
    Query<Result> query = resultsRef(userId: userId);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    return query.snapshots().map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }
}

abstract class ResultRepository {
  Future<void> create({
    required String userId,
    required Result result,
  });

  Future<Result?> fetchResult({
    required String userId,
    required String resultId,
  });

  Stream<List<Result>> subscribeResults({
    required String userId,
    Query<Result>? Function(Query<Result> query)? queryBuilder,
    int Function(Result lhs, Result rhs)? compare,
  });
}
