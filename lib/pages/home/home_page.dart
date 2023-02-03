import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/result.dart';
import '../../models/result.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/measure.dart';
import '../../widgets/app_over_scroll_indicator.dart';
import '../../widgets/match_result_card.dart';
import '../../widgets/white_app_bar.dart';
import '../account/account_page.dart';
import '../create_result/create_result_page.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(resultsProvider).maybeWhen<List<Result>>(
          data: (data) {
            return data.sublist(0, data.length >= 50 ? 50 : data.length);
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
                  Measure.g_8,
                  Column(
                    children: results
                        .map(
                          (result) => MatchResultCard(
                            result: result,
                          ),
                        )
                        .toList(),
                  ),
                  Measure.g_8,
                  Text('最新の試合結果を ${results.length} 件表示しています。'),
                  Measure.g_16,
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
