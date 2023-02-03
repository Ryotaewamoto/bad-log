import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../utils/constants/measure.dart';
import '../../widgets/gradation_background.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/white_app_bar.dart';
import '../log_in/log_in_page.dart';
import '../sign_up_page.dart';
import 'src/get_started.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const WhiteAppBar(
          title: '',
          elevation: 0,
        ),
        body: Stack(
          children: [
            const GradationBackground(
              startPoint: 0.75,
            ),
            // キーボードを開いた状態でこの画面に pop すると画面幅の問題でエラーが出るため、
            // [SingleChildScrollView] を追加している。
            SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Measure.g_32,
                  Assets.images.badLogIcon.image(
                    width: 280,
                    height: 280,
                  ),
                  Measure.g_32,
                  const AppTitleText(),
                  Measure.g_32,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: PrimaryRoundedButton(
                      text: 'アカウント作成',
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          _fadeAnimationBuilder(widget: const SignUpPage()),
                        );
                      },
                    ),
                  ),
                  Measure.g_16,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: SecondaryRoundedButton(
                      text: 'ログイン',
                      onTap: () async {
                        await Navigator.push<dynamic>(
                          context,
                          _fadeAnimationBuilder(widget: const LogInPage()),
                        );
                      },
                    ),
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
