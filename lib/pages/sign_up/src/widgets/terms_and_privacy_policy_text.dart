import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '/utils/constants/app_colors.dart';
import '/utils/constants/measure.dart';
import '/utils/constants/string.dart';
import '/utils/dialog.dart';
import '/utils/exceptions/app_exception.dart';
import '/utils/loading.dart';
import '/utils/text_styles.dart';

class TermsAndPrivacyPolicyText extends HookConsumerWidget {
  const TermsAndPrivacyPolicyText({
    required this.isCheckTerms,
    super.key,
  });

  final ValueNotifier<bool> isCheckTerms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: Measure.p_h48,
      child: Row(
        children: [
          Checkbox(
            activeColor: AppColors.secondary,
            checkColor: AppColors.baseWhite,
            value: isCheckTerms.value,
            onChanged: (value) => isCheckTerms.value = value!,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '利用規約 ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          ref
                              .watch(
                                overlayLoadingProvider.notifier,
                              )
                              .update((state) => true);
                          try {
                            if (!await launchUrl(
                              Uri.parse(termsLink),
                              mode: LaunchMode.externalApplication,
                            )) {
                              const exception = AppException(
                                message: 'Could not launch $termsLink',
                              );
                              throw exception;
                            }
                          } on AppException catch (e) {
                            await showAlertDialog(
                              context: context,
                              title: 'Error',
                              content: e.message,
                              defaultActionText: 'OK',
                            );
                          } finally {
                            ref
                                .watch(
                                  overlayLoadingProvider.notifier,
                                )
                                .update((state) => false);
                          }
                        },
                      style: TextStyles.p2(
                        color: AppColors.secondary,
                      ),
                    ),
                    TextSpan(
                      text: 'と',
                      style: TextStyles.p2(),
                    ),
                    TextSpan(
                      text: ' プライバシー・ポリシー ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          ref
                              .watch(
                                overlayLoadingProvider.notifier,
                              )
                              .update((state) => true);
                          try {
                            if (!await launchUrl(
                              Uri.parse(privacyPolicyLink),
                              mode: LaunchMode.externalApplication,
                            )) {
                              const exception = AppException(
                                message: '''
Could not launch $privacyPolicyLink .
''',
                              );
                              throw exception;
                            }
                          } on AppException catch (e) {
                            await showAlertDialog(
                              context: context,
                              title: 'Error',
                              content: e.message,
                              defaultActionText: 'OK',
                            );
                          } finally {
                            ref
                                .watch(
                                  overlayLoadingProvider.notifier,
                                )
                                .update((state) => false);
                          }
                        },
                      style: TextStyles.p2(
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'に同意する。',
                style: TextStyles.p2(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
