import 'package:flutter/material.dart';

import 'constants/app_colors.dart';
import 'text_styles.dart';

class TextFormHeader extends StatelessWidget {
  const TextFormHeader({
    required this.title,
    this.color = AppColors.baseBlack,
    super.key,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: TextStyles.h4(color: color)),
    );
  }
}

class AppTextFormStyles {
  AppTextFormStyles();

  static InputDecoration onGeneral({
    required IconData iconData,
    Color color = AppColors.baseLight,
  }) =>
      InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: Icon(
          iconData,
          color: color,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondaryPale,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
      );

  static InputDecoration onPassword({
    required ValueNotifier<bool> isObscure,
  }) =>
      InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: const Icon(
          Icons.lock,
          color: AppColors.baseLight,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondaryPale,
            width: 2,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.baseLight,
          ),
        ),
        suffixIcon: isObscure.value
            ? IconButton(
                icon: const Icon(
                  Icons.visibility_off,
                  color: AppColors.baseLight,
                ),
                onPressed: () {
                  isObscure.value = false;
                },
              )
            : IconButton(
                icon: const Icon(
                  Icons.visibility,
                  color: AppColors.baseLight,
                ),
                onPressed: () {
                  isObscure.value = true;
                },
              ),
      );
}
