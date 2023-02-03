import 'package:flutter/material.dart';

import '/utils/constants/app_colors.dart';

class ResetPasswordBackButton extends StatelessWidget {
  const ResetPasswordBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.close,
          size: 32,
          color: AppColors.baseDark,
        ),
      ),
    );
  }
}
