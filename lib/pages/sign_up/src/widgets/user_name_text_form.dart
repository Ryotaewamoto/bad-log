import 'package:flutter/material.dart';

import '/utils/constants/measure.dart';
import '/utils/text_form_styles.dart';
import '/widgets/text_form_header.dart';

class UserNameTextForm extends StatelessWidget {
  const UserNameTextForm({
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
          const TextFormHeader(title: 'ユーザ名'),
          Measure.g_4,
          TextFormField(
            maxLength: 20,
            controller: controller,
            decoration: AppTextFormStyles.onGeneral(
              iconData: Icons.account_circle,
            ),
          ),
        ],
      ),
    );
  }
}
