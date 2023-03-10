import 'package:flutter/material.dart';

import '../widgets/text_form_header.dart';
import 'constants/app_colors.dart';
import 'constants/measure.dart';
import 'text_styles.dart';

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  required String defaultActionText,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        if (cancelActionText != null)
          TextButton(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        TextButton(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}

Future<bool?> showActionDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback? onPressed,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<void> addMemberDialog(
  BuildContext context,
  TextEditingController controller, {
  required VoidCallback onPressed,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: Measure.p_a16,
        title: Text(
          'メンバーを追加',
          style: TextStyles.h3(),
        ),
        content: SizedBox(
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.account_circle_rounded,
                size: 48,
                color: AppColors.primary,
              ),
              const TextFormHeader(title: '名前'),
              Measure.g_4,
              TextFormField(
                maxLength: 20,
                controller: controller,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.secondaryPale,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.baseLight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'キャンセル',
              style: TextStyles.p1(
                color: AppColors.baseDark,
              ),
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              '追加',
              style: TextStyles.p1(
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> editMemberDialog(
  BuildContext context,
  TextEditingController controller, {
  required VoidCallback onPressed,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: Measure.p_a16,
        title: Text(
          'メンバー名の変更',
          style: TextStyles.h3(),
        ),
        content: SizedBox(
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.account_circle_rounded,
                size: 48,
                color: AppColors.primary,
              ),
              const TextFormHeader(title: '名前'),
              Measure.g_4,
              TextFormField(
                maxLength: 20,
                controller: controller,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.secondaryPale,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.baseLight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'キャンセル',
              style: TextStyles.p1(
                color: AppColors.baseDark,
              ),
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              '変更',
              style: TextStyles.p1(
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      );
    },
  );
}
