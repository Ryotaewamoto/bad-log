import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/app_user.dart';
import '../features/member.dart';
import '../models/member.dart';
import '../models/result.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/extensions/date_time.dart';
import '../utils/text_styles.dart';
import '../widgets/white_app_bar.dart';

class ResultPage extends HookConsumerWidget {
  const ResultPage({
    required this.result,
    super.key,
  });

  final Result result;

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

    final isEditingMode = useState(false);
    final commentController = useTextEditingController(text: result.comment);
    return Scaffold(
      appBar: WhiteAppBar(
        title: DateTime.now().toYYYYMMDD(withJapaneseWeekDay: false),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: Measure.p_a16,
          child: Column(
            children: [
              Measure.g_16,
              // 自分/自チーム
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 20,
                    color: result.isWinner
                        ? AppColors.accent
                        : AppColors.baseWhite,
                  ),
                  Measure.g_16,
                  Text(
                    appUserName ?? '',
                    maxLines: 1,
                    style: TextStyles.h3().copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (result.type == 'doubles')
                Column(
                  children: [
                    Measure.g_8,
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 20,
                          color: result.isWinner
                              ? AppColors.accent
                              : AppColors.baseWhite,
                        ),
                        Measure.g_16,
                        Text(
                          members.isNotEmpty
                              ? members
                                  .firstWhere(
                                    (element) =>
                                        element.memberId == result.partner,
                                  )
                                  .memberName
                              : '',
                          maxLines: 1,
                          style: TextStyles.h3().copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              Measure.g_16,
              _PointsScore(
                result: result,
              ),
              Measure.g_16,
              // 対戦相手/チーム
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 20,
                    color: !result.isWinner
                        ? AppColors.accent
                        : AppColors.baseWhite,
                  ),
                  Measure.g_16,
                  Text(
                    members.isNotEmpty
                        ? members
                            .firstWhere(
                              (element) =>
                                  element.memberId == result.opponents[0],
                            )
                            .memberName
                        : '',
                    maxLines: 1,
                    style: TextStyles.h3().copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (result.type == 'doubles')
                Column(
                  children: [
                    Measure.g_8,
                    Row(
                      // 対戦相手/チーム
                      children: [
                        Icon(
                          Icons.circle,
                          size: 20,
                          color: !result.isWinner
                              ? AppColors.accent
                              : AppColors.baseWhite,
                        ),
                        Measure.g_16,
                        Flexible(
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
                            maxLines: 1,
                            style: TextStyles.h3().copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              Measure.g_32,
              Row(
                mainAxisAlignment: !isEditingMode.value
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'コメント',
                    style: TextStyles.h2(),
                  ),
                  if (!isEditingMode.value)
                    IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        isEditingMode.value = true;
                      },
                      icon: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: FaIcon(
                            Icons.edit,
                            size: 18,
                            color: AppColors.baseWhite,
                          ),
                        ),
                      ),
                    )
                  else
                    TextButton(
                      onPressed: () {
                        isEditingMode.value = false;
                      },
                      child: Text(
                        '保存',
                        style: TextStyles.p2(color: AppColors.secondary),
                      ),
                    ),
                ],
              ),
              Measure.g_16,
              if (!isEditingMode.value)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    result.comment.isNotEmpty
                        ? result.comment
                        : '（コメントを書いておこう！）',
                  ),
                )
              else
                TextFormField(
                  controller: commentController,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: Measure.br_8,
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.secondary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: Measure.br_8,
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreText extends StatelessWidget {
  const _ScoreText(this.score, {this.isBold});

  final int score;
  final bool? isBold;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: Text(
          score.toString(),
          style: TextStyle(
            fontSize: 30,
            fontWeight: isBold ?? false ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _PointsScore extends StatelessWidget {
  const _PointsScore({required this.result});

  final Result result;
  @override
  Column build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ScoreText(
              result.yourScore[0],
              isBold: result.yourScore[0] > result.opponentsScore[0],
            ),
            if (result.yourScore.length >= 2)
              _ScoreText(
                result.yourScore[1],
                isBold: result.yourScore[1] > result.opponentsScore[1],
              ),
            if (result.yourScore.length == 3)
              _ScoreText(
                result.yourScore[2],
                isBold: result.yourScore[2] > result.opponentsScore[2],
              ),
          ],
        ),
        Measure.g_8,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ScoreText(
              result.opponentsScore[0],
              isBold: result.opponentsScore[0] > result.yourScore[0],
            ),
            if (result.opponentsScore.length >= 2)
              _ScoreText(
                result.opponentsScore[1],
                isBold: result.opponentsScore[1] > result.yourScore[1],
              ),
            if (result.opponentsScore.length == 3)
              _ScoreText(
                result.opponentsScore[2],
                isBold: result.opponentsScore[2] > result.yourScore[2],
              ),
          ],
        ),
      ],
    );
  }
}
