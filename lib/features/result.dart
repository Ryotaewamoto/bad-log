import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/result.dart';
import '../repositories/auth/auth_repository_impl.dart';
import '../repositories/result/result_repository_impl.dart';
import '../utils/exceptions/app_exception.dart';
import '../utils/result_types.dart';

/// ユーザーの results コレクションを購読する [StreamProvider]。
final resultsProvider = StreamProvider.autoDispose<List<Result>>((ref) {
  final userId = ref.watch(authRepositoryImplProvider).currentUser!.uid;
  final results = ref.read(resultRepositoryImplProvider).subscribeResults(
        userId: userId,
        queryBuilder: (q) => q.orderBy('updatedAt', descending: true),
      );
  return results;
});

/// Firestore に [Result] を追加する [AsyncNotifierProvider]。
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
        if (result.type == ResultTypes.singles.name) {
          if (result.opponents.first == 'id-unselected') {
            throw const AppException(message: '対戦相手を選択してください。');
          }
        }

        if (result.type == ResultTypes.doubles.name) {
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

/// シングルスとダブルスに分け、それぞれの要素が同じメンバーの [Result] の集まりに
/// なるようなリストを生成する [Provider]。
final typesSeparatedResultsProvider =
    Provider.autoDispose<List<List<List<Result>>>>(
  (ref) {
    final results = ref.watch(resultsProvider);
    return results.maybeWhen<List<List<List<Result>>>>(
      data: (data) {
        // メンバーごとに分類されたリストを返す
        final rawResults = data;
        final rawSinglesResults = <Result>[];
        final rawDoublesResults = <Result>[];

        for (final result in rawResults) {
          if (result.type == ResultTypes.singles.name) {
            rawSinglesResults.add(result);
          } else {
            rawDoublesResults.add(result);
          }
        }
        debugPrint('/// 全試合結果をシングルスの二次元配列とダブルスの二次元配列に変換 ///');

        debugPrint('///// 元の配列の要素数');
        debugPrint('シングルス: ${rawSinglesResults.length}');
        debugPrint('ダブルス: ${rawDoublesResults.length}');
        debugPrint('');

        /// シングルス: 対戦相手で分類した二次元配列
        final singlesResults = <List<Result>>[];

        for (final result in rawSinglesResults) {
          if (rawSinglesResults.indexOf(result) == 0) {
            singlesResults.add([result]);
          } else {
            if (singlesResults.any(
              (element) =>
                  element.any((e) => e.opponents[0] == result.opponents[0]),
            )) {
              singlesResults
                  .firstWhere(
                    (element) => element
                        .any((e) => e.opponents[0] == result.opponents[0]),
                  )
                  .add(result);
            } else {
              singlesResults.add([result]);
            }
          }
        }

        debugPrint('///// シングルス(二次元配列の要素数): ${singlesResults.length}');
        for (final element in singlesResults) {
          debugPrint(
            '${singlesResults.indexOf(element)}番目の要素数: ${element.length}',
          );
        }
        debugPrint('');

        /// ダブルス: パートナーと対戦相手で分類した二次元配列
        final doublesResults = <List<Result>>[];

        for (final result in rawDoublesResults) {
          if (rawDoublesResults.indexOf(result) == 0) {
            doublesResults.add([result]);
          } else {
            if (doublesResults.any(
              (element) => element.any(
                (e) =>
                    e.partner == result.partner &&
                        (e.opponents[0] == result.opponents[0] &&
                            e.opponents[1] == result.opponents[1]) ||
                    (e.opponents[0] == result.opponents[1] &&
                        e.opponents[1] == result.opponents[0]),
              ),
            )) {
              doublesResults
                  .firstWhere(
                    (element) => element.any(
                      (e) =>
                          e.partner == result.partner &&
                              (e.opponents[0] == result.opponents[0] &&
                                  e.opponents[1] == result.opponents[1]) ||
                          (e.opponents[0] == result.opponents[1] &&
                              e.opponents[1] == result.opponents[0]),
                    ),
                  )
                  .add(result);
            } else {
              doublesResults.add([result]);
            }
          }
        }

        debugPrint('///// ダブルス(二次元配列の要素数): ${doublesResults.length}');
        for (final element in doublesResults) {
          debugPrint(
            '${doublesResults.indexOf(element)}番目の要素数: ${element.length}',
          );
        }
        debugPrint('');

        return [singlesResults, doublesResults];
      },
      orElse: () {
        return [];
      },
    );
  },
  dependencies: [
    resultsProvider,
  ],
);

/// [Result] に関して Firestore のデータの更新を行う [AsyncNotifierProvider]。
final updateResultControllerProvider =
    AutoDisposeAsyncNotifierProvider<UpdateResultController, void>(
  UpdateResultController.new,
);

class UpdateResultController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // FutureOr<void> より、初期の処理の必要がないため何もしない。
  }

  /// 試合結果情報を更新する
  Future<void> updateResult({
    required String userId,
    required String resultId,
    required Result result,
  }) async {
    final resultRepository = ref.read(resultRepositoryImplProvider);
    // 試合結果情報をローディング中にする
    state = const AsyncLoading();

    // 試合結果情報を実行する
    state = await AsyncValue.guard(() async {
      try {
        if (result.comment.length > 200) {
          throw const AppException(
            message: '200文字以下にしてください。',
          );
        }
        await resultRepository.update(
          userId: userId,
          resultId: resultId,
          result: result,
        );
      } on AppException {
        rethrow;
      }
    });
  }
}
