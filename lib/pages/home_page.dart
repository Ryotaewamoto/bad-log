import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/app_user.dart';
import '../features/member.dart';
import '../features/result.dart';
import '../models/member.dart';
import '../models/result.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/extensions/date_time.dart';
import '../utils/text_styles.dart';
import '../widgets/app_over_scroll_indicator.dart';
import '../widgets/white_app_bar.dart';
import 'account_page.dart';
import 'create_result_page.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(resultsProvider).maybeWhen<List<Result>>(
          data: (data) {
            return data;
          },
          orElse: () => [],
        );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: WhiteAppBar(
          title: '',
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<bool>(
                    builder: (_) => const AccountPage(),
                  ),
                );
              },
              icon: const FaIcon(
                Icons.account_circle_rounded,
                size: 32,
              ),
            ),
          ],
        ),
        body: AppOverScrollIndicator(
          child: SingleChildScrollView(
            child: Padding(
              padding: Measure.p_h16,
              child: Column(
                children: [
                  const Gap(8),
                  Column(
                    children: results
                        .map(
                          (result) => _MatchResultCard(
                            result: result,
                          ),
                        )
                        .toList(),
                  ),
                  const Gap(8),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondary,
          child: const FaIcon(Icons.add),
          onPressed: () {
            Navigator.push<dynamic>(
              context,
              _slideAnimationBuilder(
                widget: const CreateResultPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

PageRouteBuilder<dynamic> _slideAnimationBuilder({required Widget widget}) {
  return PageRouteBuilder<dynamic>(
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    fullscreenDialog: true,
    pageBuilder: (context, animation, secondaryAnimation) {
      // 表示する画面のWidget
      return widget;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1); // 下から上
      // final Offset begin = Offset(0.0, -1.0); // 上から下
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: Curves.easeInOut));
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

class _MatchResultCard extends HookConsumerWidget {
  const _MatchResultCard({
    required this.result,
  });

  final Result result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );
    final members = ref.watch(membersProvider).maybeWhen<List<Member>>(
          data: (data) {
            return data;
          },
          orElse: () => [],
        );

    return Padding(
      padding: Measure.p_v4,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: Measure.br_8,
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 2,
            )
          ],
          color: AppColors.baseLight,
        ),
        child: InkWell(
          onTap: () {
            // TODO(kokorinosoba): ここにタップ時の処理を記述
          },
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: Measure.p_a8,
              child: Column(
                children: [
                  Container(
                    // 対戦メンバーのコンテナー
                    width: double.infinity,
                    decoration: result.isWinner
                        ? const BoxDecoration(
                            gradient: LinearGradient(
                              stops: [
                                0.6,
                                1.0,
                              ],
                              colors: [
                                AppColors.baseWhite,
                                AppColors.accent,
                              ],
                              transform: GradientRotation(math.pi / 3),
                            ),
                          )
                        : const BoxDecoration(
                            color: AppColors.baseWhite,
                          ),
                    child: Padding(
                      padding: Measure.p_a8,
                      child: Column(
                        children: [
                          Row(
                            // 自分/自チーム
                            children: [
                              Text(
                                appUserName ?? '',
                                style: result.isWinner
                                    ? TextStyles.p1Bold()
                                    : TextStyles.p1(),
                              ),
                            ],
                          ),
                          if (result.type == 'doubles')
                            Column(
                              children: [
                                const Gap(4),
                                Row(
                                  // 自分/自チーム
                                  children: [
                                    Text(
                                      members.isNotEmpty
                                          ? members
                                              .firstWhere(
                                                (element) =>
                                                    element.memberId ==
                                                    result.partner,
                                              )
                                              .memberName
                                          : '',
                                      style: result.isWinner
                                          ? TextStyles.p1Bold()
                                          : TextStyles.p1(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          const Gap(8),
                          Row(
                            // 対戦相手/チーム
                            children: [
                              Text(
                                members.isNotEmpty
                                    ? members
                                        .firstWhere(
                                          (element) =>
                                              element.memberId ==
                                              result.opponents[0],
                                        )
                                        .memberName
                                    : '',
                                style: !result.isWinner
                                    ? TextStyles.p1Bold()
                                    : TextStyles.p1(),
                              ),
                            ],
                          ),
                          if (result.type == 'doubles')
                            Column(
                              children: [
                                const Gap(4),
                                Row(
                                  // 自分/自チーム
                                  children: [
                                    Text(
                                      members.isNotEmpty
                                          ? members
                                              .firstWhere(
                                                (element) =>
                                                    element.memberId ==
                                                    result.opponents[1],
                                              )
                                              .memberName
                                          : '',
                                      style: !result.isWinner
                                          ? TextStyles.p1Bold()
                                          : TextStyles.p1(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // 対戦した日付の表示(アイコン+日付)
                      children: [
                        const Icon(
                          Icons.watch_later,
                          size: 18,
                          color: AppColors.baseDark,
                        ),
                        Measure.g_8,
                        Text(
                          result.createdAt.dateTime!
                              .toYYYYMMDDHHMM(withJapaneseWeekDay: false),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: AppColors.textColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
