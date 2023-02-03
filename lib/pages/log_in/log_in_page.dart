import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/auth/send_password_reset_email.dart';
import '../../features/auth/sign_in.dart';
import '../../gen/assets.gen.dart';
import '../../utils/async_value_error_dialog.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/measure.dart';
import '../../utils/loading.dart';
import '../../utils/scaffold_messenger_service.dart';
import '../../utils/text_styles.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/white_app_bar.dart';
import '../home_page.dart';
import 'src/log_in.dart';
import 'src/widgets/reset_email_text_form.dart';
import 'src/widgets/reset_password_back_button.dart';

class LogInPage extends HookConsumerWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen<AsyncValue<void>>(
        signInControllerProvider,
        (_, state) async {
          if (state.isLoading) {
            ref.watch(overlayLoadingProvider.notifier).update((state) => true);
            return;
          }

          await state.when(
            data: (_) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              // ログインできたらスナックバーでメッセージを表示してホーム画面に遷移する
              ref
                  .read(scaffoldMessengerServiceProvider)
                  .showSnackBar('ログインしました！');

              await Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            error: (e, s) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              // エラーが発生したらエラーダイアログを表示する
              state.showAlertDialogOnError(context);
            },
            loading: () {
              // ローディングを表示する
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => true);
            },
          );
        },
      )
      ..listen<AsyncValue<void>>(
        sendPasswordResetEmailControllerProvider,
        (_, state) async {
          if (state.isLoading) {
            ref.watch(overlayLoadingProvider.notifier).update((state) => true);
            return;
          }

          await state.when(
            data: (_) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              Navigator.of(context).pop();

              // ログインできたらスナックバーでメッセージを表示してホーム画面に遷移する
              ref
                  .read(scaffoldMessengerServiceProvider)
                  .showSnackBar('Success of sending email !');
            },
            error: (e, s) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              // エラーが発生したらエラーダイアログを表示する
              state.showAlertDialogOnError(context);
            },
            loading: () {
              // ローディングを表示する
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => true);
            },
          );
        },
      );

    // Provider
    final signInstate = ref.watch(signInControllerProvider);
    final sendEmailState = ref.watch(sendPasswordResetEmailControllerProvider);

    // Hooks
    final isObscure = useState(true);
    final useEmailController = useTextEditingController();
    final usePasswordController = useTextEditingController();
    final useSendEmailController = useTextEditingController();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: const WhiteAppBar(
              title: 'ログイン',
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
                      EmailTextForm(
                        controller: useEmailController,
                      ),
                      Measure.g_16,
                      PasswordTextForm(
                        controller: usePasswordController,
                        isObscure: isObscure,
                      ),
                      Measure.g_32,
                      ForgetPasswordTextButton(
                        onTap: () async {
                          await _sendPasswordResetEmailSheet(
                            context,
                            useSendEmailController,
                            sendEmailState,
                            ref,
                          );
                        },
                      ),
                      Measure.g_32,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: PrimaryRoundedButton(
                          text: 'ログイン',
                          onTap: signInstate.isLoading
                              ? null
                              : () async {
                                  await ref
                                      .read(signInControllerProvider.notifier)
                                      .signIn(
                                        email: useEmailController.value.text,
                                        password:
                                            usePasswordController.value.text,
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

  Future<void> _sendPasswordResetEmailSheet(
    BuildContext context,
    TextEditingController useSendEmailController,
    AsyncValue<void> sendEmailState,
    WidgetRef ref,
  ) async {
    await showModalBottomSheet<bool>(
      backgroundColor: AppColors.secondary,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              Measure.g_80,
              const ResetPasswordBackButton(),
              Measure.g_60,
              const Icon(
                Icons.lock,
                size: 80,
                color: AppColors.baseWhite,
              ),
              Measure.g_60,
              Text(
                'パスワードの再設定メールを送信',
                style: TextStyles.h3(
                  color: AppColors.baseWhite,
                ),
              ),
              Measure.g_60,
              ResetEmailTextForm(
                controller: useSendEmailController,
              ),
              Measure.g_60,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: SecondaryRoundedButton(
                  text: '送信',
                  onTap: sendEmailState.isLoading
                      ? null
                      : () async {
                          await ref
                              .read(
                                sendPasswordResetEmailControllerProvider
                                    .notifier,
                              )
                              .sendPasswordResetEmail(
                                email: useSendEmailController.value.text,
                              );
                        },
                ),
              ),
            ],
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Measure.r_16,
          topRight: Measure.r_16,
        ),
      ),
    );
  }
}
