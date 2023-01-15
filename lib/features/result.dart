import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/result.dart';
import '../repositories/result/result_repository_impl.dart';
import '../utils/exceptions/app_exception.dart';

final createResultControllerProvider =
    AutoDisposeAsyncNotifierProvider<CreateResultController, void>(
  CreateResultController.new,
);

class CreateResultController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // FutureOr<void> より、初期の処理の必要がないため何もしない。
  }

  /// 試合結果を追加する
  Future<void> createResultAndScore({
    required String userId,
    required Result result,
  }) async {
    final resultRepository = ref.read(resultRepositoryImplProvider);
    // 試合結果の追加をローディング中にする
    state = const AsyncLoading();

    // 試合結果の追加を実行する
    state = await AsyncValue.guard(() async {
      try {
        // TODO(ryotaiwamoto): validation
        // 同じメンバーのドキュメントが存在する場合はそのドキュメントのIDをとってきて Score を追加する。
        // その場合には 以下の resultId は使用しない。
        // TODO(ryotaiwamoto): List<Result> の中からパートナーと対戦相手が一致するものを探す関数を作成する。
        await resultRepository.create(
          userId: userId,
          result: result,
        );
      } on AppException {
        rethrow;
      }
    });
  }
}
