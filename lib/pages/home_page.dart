import 'package:bad_log/utils/constants/measure.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../utils/constants/app_colors.dart';
import '../widgets/white_app_bar.dart';
import 'account_page.dart';
import 'create_result_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: WhiteAppBar(
          title: '',
          leading: IconButton(
            onPressed: () {},
            icon: const FaIcon(
              Icons.sort,
              size: 32,
            ),
          ),
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
        body: const Center(
          child: Text('home'),
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
    return Card(
      color: AppColors.baseLight,
      child: InkWell(
        onTap: () {
          // ここにタップ時の処理を記述
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
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: [
                        AppColors.baseWhite,
                        AppColors.accent,
                      ],
                      stops: [
                        0.5,
                        1.0,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: Measure.p_a8,
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.circle,
                                size: 20, color: AppColors.accent),
                            Measure.g_8,
                            Text('Jonatan Christie'),
                          ],
                        ),
                        // ******* Gap(2)を定数化する *******
                        const Gap(2),
                        Row(
                          children: const [
                            Icon(Icons.circle,
                                size: 20, color: AppColors.accent),
                            Measure.g_8,
                            Text('Thomas Rouxel'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: Measure.p_v4,
                  child: Padding(
                    padding: Measure.p_h8,
                    child: Row(
                      children: [
                        // ******* 色がおかしい *******
                        const Icon(Icons.watch_later,
                            size: 18, color: AppColors.textColor),
                        Measure.g_8,
                        Text(DateFormat('yyyy/MM/dd').format(DateTime.now())),
                      ],
                    ),
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
    );
  }
}
