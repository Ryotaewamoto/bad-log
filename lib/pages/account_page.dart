import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/app_user.dart';
import '../features/result.dart';
import '../models/result.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/loading.dart';
import '../utils/text_styles.dart';
import '../widgets/white_app_bar.dart';
import 'settings_page.dart';

class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );
    final results = ref.watch(resultsProvider).maybeWhen<List<List<Result>>>(
          data: (data) {
            // メンバーごとに分類されたリストを返す
            final rawResults = data;
            final rawSinglesResults = <Result>[];
            final rawDoublesResults = <Result>[];

            for (final result in rawResults) {
              if (result.type == 'singles') {
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
                        e.opponents[0] == result.opponents[0] &&
                        e.opponents[1] == result.opponents[1],
                  ),
                )) {
                  doublesResults
                      .firstWhere(
                        (element) => element.any(
                          (e) =>
                              e.partner == result.partner &&
                              e.opponents[0] == result.opponents[0] &&
                              e.opponents[1] == result.opponents[1],
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

            return <List<Result>>[];
          },
          orElse: () => [],
        );

    return Stack(
      children: [
        Scaffold(
          appBar: WhiteAppBar(
            title: 'Account',
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<bool>(
                      builder: (_) => const SettingsPage(),
                    ),
                  );
                },
                icon: const FaIcon(
                  Icons.settings,
                  size: 32,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Measure.g_32,
              const Center(
                child: Icon(
                  Icons.account_circle,
                  color: AppColors.primary,
                  size: 128,
                ),
              ),
              Measure.g_8,
              Text(
                appUserName ?? '',
                style: TextStyles.h4(),
              ),
              Measure.g_24,
              Padding(
                padding: Measure.p_h16,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Rate', style: TextStyles.h2()),
                      ],
                    ),
                    Measure.g_8,
                    // Flexible(
                    //   child: ListView.builder(
                    //     padding: Measure.p_h16,
                    //     itemCount: results.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return _RateResultCard(
                    //         results: results,
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
      ],
    );
  }
}

class _RateResultCard extends StatelessWidget {
  const _RateResultCard({
    required this.results,
  });

  final List<Result> results;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.baseLight,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 2,
          )
        ],
      ),
      width: double.infinity,
      child: Padding(
        padding: Measure.p_a8,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.baseWhite,
              child: Padding(
                padding: Measure.p_a8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Jonatan Christie',
                              style: TextStyles.p2(),
                            ),
                          ),
                          Measure.g_4,
                          const Divider(
                            height: 0,
                            thickness: 2,
                          ),
                          Measure.g_4,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Thomas Rouxel',
                              style: TextStyles.p2Bold(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '54',
                            style: TextStyles.h1(),
                          ),
                          Align(
                            child: Text(
                              '%',
                              style: TextStyles.h2(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Latest: 2022/03/25',
                  style: TextStyles.p3(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
