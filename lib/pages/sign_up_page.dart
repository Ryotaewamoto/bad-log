import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../widgets/rounded_button.dart';
import '../widgets/white_app_bar.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WhiteAppBar(
        title: 'Sign Up',
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          const SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [
                    0.80,
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
                Measure.g_24,
                Assets.images.badLogIcon.image(width: 200, height: 200),
                Measure.g_24,
                const Text('現状、ボタンを押しても反応しません。'),
                TextFormField(),
                TextFormField(),
                Measure.g_16,
                PrimaryRoundedButton(
                  text: 'Sign up',
                  onTap: () async {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
