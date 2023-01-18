import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/result.dart';
import '../repositories/auth/auth_repository_impl.dart';
import '../repositories/result/result_repository_impl.dart';
import '../utils/exceptions/app_exception.dart';
import '../utils/resylt_types.dart';

/// ユーザーの results コレクションを購読する StreamProvider。
final resultsProvider = StreamProvider.autoDispose<List<Result>>((ref) {
  final userId = ref.watch(authRepositoryImplProvider).currentUser!.uid;
  final results = ref.read(resultRepositoryImplProvider).subscribeResults(
        userId: userId,
        queryBuilder: (q) => q.orderBy('updatedAt', descending: true),
      );
  return results;
});

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
  Future<void> createResult({
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
        if (result.type == ResultTypes.singles.toString()) {
          if (result.opponents.first == 'id-unselected') {
            throw const AppException(message: '対戦相手を選択してください。');
          }
        }

        if (result.type == ResultTypes.doubles.toString()) {
          if (result.opponents.first == 'id-unselected' ||
              result.opponents[1] == 'id-unselected' ||
              result.partner == 'id-unselected') {
            throw const AppException(message: 'パートナーもしくは対戦相手を選択してください。');
          }
          if (result.opponents.first == result.opponents[1] ||
              result.opponents.first == result.partner ||
              result.opponents[1] == result.partner) {
            throw const AppException(message: 'パートナーもしくは対戦相手が重複しています。');
          }
        }

        if (result.yourScore[0] == 0 && result.opponentsScore[0] == 0) {
          throw const AppException(message: '点数を入力してください。');
        }

        if (result.yourScore.length == 1) {
          if (result.yourScore[0] == result.opponentsScore[0]) {
            throw const AppException(
              message: '点数が同点になっています。どちらかの値が大きくなるように入力してください。',
            );
          }
        }

        if (result.yourScore.length == 3) {
          if (result.yourScore[1] == 0 && result.opponentsScore[1] == 0) {
            throw const AppException(message: '2ゲーム目の点数を入力してください。');
          }

          if (result.yourScore[2] == 0 && result.opponentsScore[2] == 0) {
            throw const AppException(message: '3ゲーム目の点数を入力してください。');
          }

          if (result.yourScore[0] == result.opponentsScore[0] ||
              result.yourScore[1] == result.opponentsScore[1] ||
              result.yourScore[2] == result.opponentsScore[2]) {
            throw const AppException(
              message: '点数が同点になっています。どちらかの値が大きくなるように入力してください。',
            );
          }
        }
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
