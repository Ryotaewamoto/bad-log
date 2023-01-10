import 'package:bad_log/widgets/async_value_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/sign_up.dart';
import '../gen/assets.gen.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/loading.dart';
import '../utils/scaffold_messenger_service.dart';
import '../widgets/rounded_button.dart';
import '../widgets/white_app_bar.dart';
import 'home_page.dart';

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
                .showSnackBar('Created a new account !');

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
    final state = ref.watch(signUpControllerProvider);
    return Stack(
      children: [
        Scaffold(
          appBar: const WhiteAppBar(
            title: 'Sign Up',
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: Column(
                  children: [
                    Measure.g_24,
                    Assets.images.badLogIcon.image(width: 200, height: 200),
                    Measure.g_24,
                    TextFormField(),
                    TextFormField(),
                    Measure.g_16,
                    PrimaryRoundedButton(
                      text: 'Sign up',
                      onTap: state.isLoading
                          ? null
                          : () async {
                              await ref
                                  .read(signUpControllerProvider.notifier)
                                  .signUp(
                                    email: 'sample6@gmail.com',
                                    password: 'password',
                                  );
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
      ],
    );
  }
}
