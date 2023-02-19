import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/auth/sign_up.dart';
import '../../gen/assets.gen.dart';
import '../../utils/async_value_error_dialog.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/measure.dart';
import '../../utils/constants/string.dart';
import '../../utils/dialog.dart';
import '../../utils/exceptions/app_exception.dart';
import '../../utils/loading.dart';
import '../../utils/scaffold_messenger_service.dart';
import '../../utils/text_form_styles.dart';
import '../../utils/text_styles.dart';
import '../../widgets/gradation_background.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/text_form_header.dart';
import '../../widgets/white_app_bar.dart';
import '../home/home_page.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      signUpControllerProvider,
      (_, state) async {
        if (state.isLoading) {
          ref.watch(overlayLoadingProvider.notifier).update((state) => true);
          return;
        }

        await state.when(
          data: (_) async {
            // ローディングを非表示にする
            ref.watch(overlayLoadingProvider.notifier).update((state) => false);

            // ログインできたらスナックバーでメッセージを表示してホーム画面に遷移する
            ref
                .read(scaffoldMessengerServiceProvider)
                .showSnackBar('アカウントを作成しました！');

            await Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          error: (e, s) async {
            // ローディングを非表示にする
            ref.watch(overlayLoadingProvider.notifier).update((state) => false);

            // エラーが発生したらエラーダイアログを表示する
            state.showAlertDialogOnError(context);
          },
          loading: () {
            // ローディングを表示する
            ref.watch(overlayLoadingProvider.notifier).update((state) => true);
          },
        );
      },
    );

    // Provider
    final state = ref.watch(signUpControllerProvider);

    // Hooks
    final isObscure = useState(true);
    final isCheckTerms = useState(false);
    final userNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: const WhiteAppBar(
              title: 'アカウント作成',
              elevation: 0,
              automaticallyImplyLeading: true,
            ),
            body: Stack(
              children: [
                const GradationBackground(),
                SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      Measure.g_24,
                      Assets.images.badLogIcon.image(
                        width: 200,
                        height: 200,
                      ),
                      Measure.g_24,
                      UserNameTextForm(
                        controller: userNameController,
                      ),
                      Measure.g_16,
                      EmailTextForm(
                        controller: emailController,
                      ),
                      Measure.g_16,
                      PasswordTextForm(
                        controller: passwordController,
                        isObscure: isObscure,
                      ),
                      Measure.g_32,
                      TermsAndPrivacyPolicyText(
                        isCheckTerms: isCheckTerms,
                      ),
                      Measure.g_32,
                      Padding(
                        padding: Measure.p_h32,
                        child: PrimaryRoundedButton(
                          text: 'アカウントを作成',
                          onTap: state.isLoading
                              ? null
                              : () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  await ref
                                      .read(signUpControllerProvider.notifier)
                                      .signUp(
                                        isCheckTerms: isCheckTerms.value,
                                        userName: userNameController.value.text,
                                        email: emailController.value.text,
                                        password: passwordController.value.text,
                                      );
                                },
                        ),
                      ),
                      Measure.g_32,
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
        ],
      ),
    );
  }
}

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
      padding: Measure.p_h32,
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
