import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/send_password_reset_email.dart';
import '../features/auth/sign_in.dart';
import '../gen/assets.gen.dart';
import '../utils/async_value_error_dialog.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/loading.dart';
import '../utils/scaffold_messenger_service.dart';
import '../utils/text_form_styles.dart';
import '../utils/text_styles.dart';
import '../widgets/rounded_button.dart';
import '../widgets/white_app_bar.dart';
import 'home_page.dart';

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
                  .showSnackBar('You are now logged !');

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
              title: 'Log In',
              elevation: 0,
              automaticallyImplyLeading: true,
            ),
            body: Stack(
              children: [
                const SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        stops: [
                          0.80,
                          1.0,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          AppColors.baseWhite,
                          AppColors.accent,
                        ],
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Column(
                      children: [
                        Measure.g_24,
                        Assets.images.badLogIcon.image(
                          width: 200,
                          height: 200,
                        ),
                        Measure.g_24,
                        const TextFormHeader(title: 'Email'),
                        Measure.g_4,
                        TextFormField(
                          controller: useEmailController,
                          decoration: AppTextFormStyles.onGeneral(
                            iconData: Icons.mail,
                          ),
                        ),
                        Measure.g_16,
                        const TextFormHeader(title: 'Password'),
                        Measure.g_4,
                        TextFormField(
                          obscureText: isObscure.value,
                          controller: usePasswordController,
                          decoration: AppTextFormStyles.onPassword(
                            isObscure: isObscure,
                          ),
                        ),
                        Measure.g_32,
                        InkWell(
                          // behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            await _sendPasswordResetEmailSheet(
                              context,
                              useSendEmailController,
                              sendEmailState,
                              ref,
                            );
                          },
                          child: Text(
                            'Lost your password?',
                            style: TextStyles.p1(color: AppColors.secondary),
                          ),
                        ),
                        Measure.g_32,
                        PrimaryRoundedButton(
                          text: 'Log In',
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
                        Measure.g_32,
                      ],
                    ),
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
              const Gap(80),
              Align(
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
              ),
              const Gap(60),
              const Icon(
                Icons.lock,
                size: 80,
                color: AppColors.baseWhite,
              ),
              const Gap(60),
              Text(
                'パスワードの再設定メールを送信',
                style: TextStyles.h3(
                  color: AppColors.baseWhite,
                ),
              ),
              const Gap(60),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
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
                      controller: useSendEmailController,
                      decoration: AppTextFormStyles.onGeneral(
                        iconData: Icons.mail,
                        color: AppColors.baseWhite,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(60),
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
