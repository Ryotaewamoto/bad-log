import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth.dart';
import '../widgets/white_app_bar.dart';
import 'get_started_page.dart';

class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const WhiteAppBar(
        title: '',
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            // ログアウト
            await ref.watch(authProvider).signOut();

            // https://twitter.com/riscait/status/1607587400271921152
            // context.mounted が可能になった時に置き換える
            // ignore: use_build_context_synchronously
            await Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => const GetStartedPage(),
              ),
            );
          },
          child: const Text('Log Out'),
        ),
      ),
    );
  }
}
