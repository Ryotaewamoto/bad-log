import 'package:flutter/material.dart';

import '/utils/constants/app_colors.dart';
import '/utils/text_styles.dart';

class AppTitleText extends StatelessWidget {
  const AppTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Welcome to ',
            style: TextStyles.h2(),
          ),
          TextSpan(
            text: 'BadLog',
            style: TextStyles.h2(color: AppColors.primary),
          ),
          TextSpan(
            text: ' !!',
            style: TextStyles.h2(),
          ),
        ],
      ),
    );
  }
}
