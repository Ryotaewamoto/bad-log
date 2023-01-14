import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/result.dart';
import '../models/score.dart';
import '../repositories/result/result_repository_impl.dart';
import '../repositories/score/score_repository_impl.dart';
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

  /// 新規登録する
  Future<void> createResultAndScore({
    required String userId,
    required Result result,
    required Score score,
  }) async {
    final resultRepository = ref.read(resultRepositoryImplProvider);
    final scoreRepository = ref.read(scoreRepositoryImplProvider);
    // ログイン結果をローディング中にする
    state = const AsyncLoading();

    // ログイン処理を実行する
    state = await AsyncValue.guard(() async {
      try {
        // TODO: validation
        // 同じメンバーのドキュメントが存在する場合はそのドキュメントのIDをとってきて Score を追加する。
        // その場合には 以下の resultId は使用しない。
        // TODO: List<Result> の中からパートナーと対戦相手が一致するものを探す関数を作成する。
        final resultId = await resultRepository.create(
          userId: userId,
          result: result,
        );

        await scoreRepository.create(
          userId: userId,
          resultId: resultId,
          score: score,
        );
      } on AppException {
        rethrow;
      }
    });
  }
}
