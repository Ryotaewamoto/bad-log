import 'package:flutter/material.dart';

import '/utils/constants/measure.dart';
import '/utils/text_form_styles.dart';
import '/widgets/text_form_header.dart';

class EmailTextForm extends StatelessWidget {
  const EmailTextForm({
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
          const TextFormHeader(title: 'メールアドレス'),
          Measure.g_4,
          TextFormField(
            controller: controller,
            decoration: AppTextFormStyles.onGeneral(
              iconData: Icons.mail,
            ),
          ),
        ],
      ),
    );
  }
}
