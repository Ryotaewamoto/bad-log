import 'package:flutter/material.dart';

import '/utils/constants/measure.dart';
import '/utils/text_form_styles.dart';
import '/widgets/text_form_header.dart';

class PasswordTextForm extends StatelessWidget {
  const PasswordTextForm({
    required this.controller,
    required this.isObscure,
    super.key,
  });

  final TextEditingController controller;
  final ValueNotifier<bool> isObscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const TextFormHeader(title: 'パスワード'),
          Measure.g_4,
          TextFormField(
            obscureText: isObscure.value,
            controller: controller,
            decoration: AppTextFormStyles.onPassword(
              isObscure: isObscure,
            ),
          ),
        ],
      ),
    );
  }
}
