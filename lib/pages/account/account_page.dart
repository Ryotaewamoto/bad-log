import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/app_user.dart';
import '../../features/member.dart';
import '../../features/result.dart';
import '../../features/toggle_button.dart';
import '../../models/member.dart';
import '../../models/result.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/measure.dart';
import '../../utils/extensions/date_time.dart';
import '../../utils/loading.dart';
import '../../utils/text_styles.dart';
import '../../widgets/app_over_scroll_indicator.dart';
import '../../widgets/white_app_bar.dart';
import '../same_member_result/same_member_result_page.dart';
import '../settings/settings_page.dart';

class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );
    final results = ref.watch(typesSeparatedResultsProvider);

    return Stack(
      children: [
        Scaffold(
          appBar: WhiteAppBar(
            title: 'アカウント',
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
          body: AppOverScrollIndicator(
            child: SingleChildScrollView(
              child: Padding(
                padding: Measure.p_h16,
                child: Column(
                  children: [
                    Measure.g_32,
                    const Center(
                      child: Icon(
                        Icons.account_circle,
                        color: AppColors.primary,
                        size: 96,
                      ),
                    ),
                    Measure.g_8,
                    Text(
                      appUserName ?? '',
                      style: TextStyles.h4(),
                    ),
                    Measure.g_24,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('試合履歴', style: TextStyles.h2()),
                    ),
                    Measure.g_8,
                    ToggleButtons(
                      onPressed: (int index) {
                        ref
                            .watch(selectTypesProvider.notifier)
                            .changeSelectType(index);
                      },
                      borderRadius: Measure.br_8,
                      borderColor: AppColors.secondary,
                      selectedColor: AppColors.baseWhite,
                      fillColor: AppColors.secondary,
                      color: AppColors.secondary,
                      highlightColor: AppColors.secondaryPale,
                      splashColor: AppColors.secondaryPale,
                      constraints: const BoxConstraints(
                        minHeight: 40,
                        minWidth: 130,
                      ),
                      isSelected: ref.watch(selectTypesProvider),
                      children: types,
                    ),
                    Measure.g_16,
                    if (ref.watch(selectTypesProvider).first == true)
                      Column(
                        children: results.isEmpty
                            ? []
                            : results[0]
                                .map(
                                  (e) => _RateSinglesResultCard(
                                    results: results[0],
                                    index: results[0].indexOf(e),
                                  ),
                                )
                                .toList(),
                      )
                    else
                      Column(
                        children: results[1]
                            .map(
                              (e) => _RateDoublesResultCard(
                                results: results[1],
                                index: results[1].indexOf(e),
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
      ],
    );
  }
}

/// シングルス用のカード
class _RateSinglesResultCard extends HookConsumerWidget {
  const _RateSinglesResultCard({
    required this.results,
    required this.index,
  });

  final List<List<Result>> results;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final result = results[index][0];
    final sameMemberResults = results[index];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<bool>(
            builder: (_) => SameMemberResultPage(
              results: sameMemberResults,
            ),
          ),
        );
      },
      child: Padding(
        padding: Measure.p_v4,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.baseLight,
            borderRadius: Measure.br_4,
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
                                  appUserName ?? '',
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
                                  members.isNotEmpty
                                      ? members
                                          .firstWhere(
                                            (element) =>
                                                element.memberId ==
                                                result.opponents[0],
                                          )
                                          .memberName
                                      : '',
                                  style: TextStyles.p2(),
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
                                (sameMemberResults
                                            .where(
                                              (element) =>
                                                  element.isWinner == true,
                                            )
                                            .length /
                                        sameMemberResults.length *
                                        100)
                                    .toStringAsFixed(1),
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
                      'Latest: ${result.createdAt.dateTime!.toYYYYMMDD(
                        withJapaneseWeekDay: false,
                      )}',
                      style: TextStyles.p3(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ダブルス用のカード
class _RateDoublesResultCard extends HookConsumerWidget {
  const _RateDoublesResultCard({
    required this.results,
    required this.index,
  });

  final List<List<Result>> results;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final result = results[index][0];
    final sameMemberResults = results[index];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<bool>(
            builder: (_) => SameMemberResultPage(
              results: sameMemberResults,
            ),
          ),
        );
      },
      child: Padding(
        padding: Measure.p_v4,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: Measure.br_4,
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
                                  appUserName ?? '',
                                  style: TextStyles.p2(),
                                ),
                              ),
                              const Gap(2),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  members.isNotEmpty
                                      ? members
                                          .firstWhere(
                                            (element) =>
                                                element.memberId ==
                                                result.partner,
                                          )
                                          .memberName
                                      : '',
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
                                  members.isNotEmpty
                                      ? members
                                          .firstWhere(
                                            (element) =>
                                                element.memberId ==
                                                result.opponents[0],
                                          )
                                          .memberName
                                      : '',
                                  style: TextStyles.p2(),
                                ),
                              ),
                              const Gap(2),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  members.isNotEmpty
                                      ? members
                                          .firstWhere(
                                            (element) =>
                                                element.memberId ==
                                                result.opponents[1],
                                          )
                                          .memberName
                                      : '',
                                  style: TextStyles.p2(),
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
                                (sameMemberResults
                                            .where(
                                              (element) =>
                                                  element.isWinner == true,
                                            )
                                            .length /
                                        sameMemberResults.length *
                                        100)
                                    .toStringAsFixed(1),
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
                      'Latest: ${result.createdAt.dateTime!.toYYYYMMDD(
                        withJapaneseWeekDay: false,
                      )}',
                      style: TextStyles.p3(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
