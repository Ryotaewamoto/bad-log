import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../widgets/white_app_bar.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WhiteAppBar(
        title: 'Sign Up',
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
          Center(
            child: Column(
              children: [
                TextFormField(),
                TextFormField(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
