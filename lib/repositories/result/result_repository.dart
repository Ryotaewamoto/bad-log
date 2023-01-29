import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/result.dart';

abstract class ResultRepository {
  Future<void> create({
    required String userId,
    required Result result,
  });

  Future<Result?> fetchResult({
    required String userId,
    required String resultId,
  });

  Future<void> update({
    required String userId,
    required String resultId,
    required Result result,
  });

  Stream<List<Result>> subscribeResults({
    required String userId,
    Query<Result>? Function(Query<Result> query)? queryBuilder,
    int Function(Result lhs, Result rhs)? compare,
  });
}
