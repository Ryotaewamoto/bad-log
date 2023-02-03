import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/auth/sign_up.dart';
import '../../gen/assets.gen.dart';
import '../../utils/async_value_error_dialog.dart';
import '../../utils/constants/measure.dart';
import '../../utils/loading.dart';
import '../../utils/scaffold_messenger_service.dart';
import '../../widgets/gradation_background.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/white_app_bar.dart';
import '../home_page.dart';
import 'src/sign_up.dart';

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
