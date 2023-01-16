import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/extensions/date_time.dart';
import '../widgets/white_app_bar.dart';
import 'account_page.dart';
import 'create_result_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // TODO(kokorinosoba): 表示用のデータをどのように取得するかわからない

  @override
  Widget build(BuildContext context) {
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
        body: ListView.builder(
          padding: Measure.p_h16,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return const MatchResultCard();
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondary,
          child: const FaIcon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<bool>(
                builder: (_) => const CreateResultPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MatchResultCard extends StatelessWidget {
  const MatchResultCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            print('Card Tapped');
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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        stops: [
                          0.75,
                          1.0,
                        ],
                        colors: [
                          AppColors.baseWhite,
                          AppColors.accent,
                        ],
                        transform: GradientRotation(math.pi / 4),
                      ),
                    ),
                    child: Padding(
                      padding: Measure.p_a8,
                      child: Column(
                        children: [
                          Row(
                            // 自分/自チーム
                            children: const [
                              Icon(
                                Icons.circle,
                                size: 20,
                                color: AppColors.accent,
                              ),
                              Measure.g_8,
                              Text('Jonatan Christie'),
                            ],
                          ),
                          const Gap(2),
                          Row(
                            // 対戦相手/チーム
                            children: const [
                              Icon(
                                Icons.circle,
                                size: 20,
                                color: AppColors.accent,
                              ),
                              Measure.g_8,
                              Text('Thomas Rouxel'),
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
                          color: AppColors.textColor,
                        ),
                        Measure.g_8,
                        Text(
                          DateTime.now().toYYYYMMDD(withJapaneseWeekDay: false),
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
