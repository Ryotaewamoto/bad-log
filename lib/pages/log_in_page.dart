import 'package:bad_log/features/auth.dart';
import 'package:bad_log/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogInPage extends HookConsumerWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            // 匿名ユーザーでサインインする
            await ref.watch(authProvider).signInAnonymously();

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
          },
          child: const Text('Log In'),
        ),
      ),
    );
  }
}
