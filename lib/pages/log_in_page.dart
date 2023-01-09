import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth.dart';
import '../gen/assets.gen.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/loading.dart';
import '../widgets/rounded_button.dart';
import '../widgets/white_app_bar.dart';
import 'home_page.dart';

class LogInPage extends HookConsumerWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: const WhiteAppBar(
              title: 'Log In',
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
                      const Text('何も入力しなくても現状はログインできます'),
                      TextFormField(),
                      TextFormField(),
                      Measure.g_16,
                      PrimaryRoundedButton(
                        text: 'Log In',
                        onTap: () async {
                          try {
                            ref
                                .watch(overlayLoadingProvider.notifier)
                                .update((state) => true);
                            // 匿名ユーザーでサインインする
                            await ref.watch(authProvider).signInAnonymously();

                            ref
                                .watch(overlayLoadingProvider.notifier)
                                .update((state) => false);

                            // https://twitter.com/riscait/status/1607587400271921152
                            // context.mounted が可能になった時に置き換える
                            // ignore: use_build_context_synchronously
                            await Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (_) => const HomePage(),
                              ),
                            );
                          } on Exception catch (e) {
                            throw Exception(e.toString());
                          } finally {
                            ref
                                .watch(overlayLoadingProvider.notifier)
                                .update((state) => false);
                          }
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
      ),
    );
  }
}
