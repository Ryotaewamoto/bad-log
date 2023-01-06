import 'package:bad_log/features/auth.dart';
import 'package:bad_log/pages/home_page.dart';
import 'package:bad_log/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
            appBar: AppBar(
              title: const Text('LogIn'),
            ),
            body: Center(
              child: Column(
                children: [
                  const Text('何も入力しなくても現状はログインできます'),
                  TextFormField(),
                  TextFormField(),
                  TextButton(
                    onPressed: () async {
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
                        await Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (_) => const HomePage(),
                          ),
                          (_) => false,
                        );
                      } on Exception catch (e) {
                        throw Exception(e.toString());
                      } finally {
                        ref
                            .watch(overlayLoadingProvider.notifier)
                            .update((state) => false);
                      }
                    },
                    child: const Text('Log In'),
                  ),
                ],
              ),
            ),
          ),
          if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
        ],
      ),
    );
  }
}
