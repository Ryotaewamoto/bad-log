import 'package:bad_log/utils/constants/app_colors.dart';
import 'package:bad_log/utils/constants/measure.dart';
import 'package:bad_log/utils/text_styles.dart';
import 'package:bad_log/widgets/rounded_button.dart';
import 'package:bad_log/widgets/white_app_bar.dart';
import 'package:flutter/material.dart';

import 'log_in_page.dart';
import 'sign_up_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const WhiteAppBar(title: ''),
        body: Stack(
          children: [
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [
                      0.75,
                      1.0,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      AppColors.baseWhite,
                      AppColors.accent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Column(
                children: [
                  Measure.g_32,
                  Measure.g_32,
                  Container(
                    width: 150,
                    height: 150,
                    color: AppColors.baseLight,
                  ),
                  Measure.g_32,
                  Measure.g_32,
                  Text(
                    'Welcome to BadLog !!',
                    style: TextStyles.h3(),
                  ),
                  Measure.g_32,
                  PrimaryRoundedButton(
                    text: 'Create an account',
                    onTap: () {
                      Navigator.push(
                        context,
                        _fadeAnimationBuilder(widget: const SignUpPage()),
                      );
                    },
                  ),
                  Measure.g_16,
                  SecondaryRoundedButton(
                    text: 'Log In',
                    onTap: () async {
                      await Navigator.push(
                        context,
                        _fadeAnimationBuilder(widget: const LogInPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PageRouteBuilder<dynamic> _fadeAnimationBuilder({required Widget widget}) {
  return PageRouteBuilder<dynamic>(
    transitionDuration: const Duration(milliseconds: 400),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) {
      // 表示する画面のWidget
      return widget;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // 遷移時のアニメーションを指定
      const begin = 0.0;
      const end = 1.0;
      final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: Curves.easeInOut));
      final doubleAnimation = animation.drive<double>(tween);
      return FadeTransition(
        opacity: doubleAnimation,
        child: child,
      );
    },
  );
}
