import 'package:flutter/material.dart';

import '/utils/constants/app_colors.dart';

class GradationBackground extends StatelessWidget {
  const GradationBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
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
    );
  }
}
