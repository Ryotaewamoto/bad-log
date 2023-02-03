import 'package:flutter/material.dart';

import '/utils/constants/app_colors.dart';
import '/utils/text_styles.dart';

class ForgetPasswordTextButton extends StatelessWidget {
  const ForgetPasswordTextButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        'パスワードを忘れた方はこちら',
        style: TextStyles.p1(color: AppColors.secondary),
      ),
    );
  }
}
