import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/extensions/date_time.dart';
import '../widgets/white_app_bar.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar(
        title: DateTime.now().toYYYYMMDD(withJapaneseWeekDay: false),
      ),
      body: Padding(
        padding: Measure.p_a16,
        child: Column(
          children: [
            Measure.g_16,
            Row(
              // 自分/自チーム
              children: const [
                Icon(Icons.circle, size: 20, color: AppColors.accent),
                Measure.g_16,
                Text(
                  'Thomas Rouxel',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            Measure.g_16,
            Center(
              // TODO(kokorinosoba): うまくセンタリングできない
              child: Row(
                children: [
                  ScoreText(19),
                  ScoreText(
                    21,
                    bold: true,
                  ),
                  ScoreText(19),
                ],
              ),
            ),
            Measure.g_8,
            Center(
              // TODO(kokorinosoba): うまくセンタリングできない
              child: Row(
                children: [
                  ScoreText(
                    21,
                    bold: true,
                  ),
                  ScoreText(19),
                  ScoreText(
                    21,
                    bold: true,
                  ),
                ],
              ),
            ),
            Measure.g_16,
            Row(
              // 対戦相手/チーム
              children: const [
                Icon(Icons.circle, size: 20, color: AppColors.accent),
                Measure.g_16,
                Text(
                  'Jonatan Christie',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            Measure.g_32,
            Row(
              children: [
                const Text(
                  'Comment',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Measure.g_16,
                IconButton(
                  onPressed: () {},
                  icon: const CircleAvatar(
                    foregroundColor: AppColors.baseWhite,
                    backgroundColor: AppColors.secondary,
                    child: FaIcon(Icons.edit, size: 22),
                  ),
                ),
              ],
            ),
            Measure.g_16,
            const Text(
                '世界バドミントン連盟、略称BWF（英: Badminton World Federation）は、バドミントンの国際競技連盟。1934年に国際バドミントン連盟（IBF、International Badminton Federation）として設立。2006年9月に当名称に改称された。'),
          ],
        ),
      ),
    );
  }
}

class ScoreText extends StatelessWidget {
  const ScoreText(this.score, {super.key, this.bold});

  final int score;
  final bool? bold;

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
            fontWeight: bold ?? false ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
