import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repositories/auth_repository_impl.dart';
import '../widgets/white_app_bar.dart';
import 'auth_page.dart';
import 'settings_page.dart';

class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: WhiteAppBar(
        title: 'Account',
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<bool>(
                  builder: (_) => const SettingsPage(),
                ),
              );
            },
            icon: const FaIcon(
              Icons.settings,
              size: 32,
            ),
          ),
        ],
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            // ログアウト
            await ref.watch(authRepositoryImplProvider).signOut();

            // https://twitter.com/riscait/status/1607587400271921152
            // context.mounted が可能になった時に置き換える
            // ignore: use_build_context_synchronously
            await Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => const AuthPage(),
              ),
              (_) => false,
            );
          },
          child: const Text('Log Out'),
        ),
      ),
    );
  }
}
