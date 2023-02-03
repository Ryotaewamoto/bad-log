import 'package:flutter/material.dart';

import '/utils/constants/app_colors.dart';
import '/utils/constants/measure.dart';
import '/utils/text_form_styles.dart';
import '/utils/text_styles.dart';
import '/widgets/text_form_header.dart';

class ResetEmailTextForm extends StatelessWidget {
  const ResetEmailTextForm({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          const TextFormHeader(
            title: 'Email',
            color: AppColors.baseWhite,
          ),
          Measure.g_16,
          TextFormField(
            style: TextStyles.p1(
              color: AppColors.baseWhite,
            ),
            controller: controller,
            decoration: AppTextFormStyles.onGeneral(
              iconData: Icons.mail,
              color: AppColors.baseWhite,
            ),
          ),
        ],
      ),
    );
  }
}
