import 'package:bad_log/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'pages/auth_page.dart';
import 'utils/global_key.dart';
import 'utils/scaffold_messenger_service.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'BadLog',
      theme: ThemeData(
        fontFamily: 'Helvetica',
        scaffoldBackgroundColor: AppColors.baseWhite,
      ),
      scaffoldMessengerKey: ref.watch(scaffoldMessengerKeyProvider),
      navigatorKey: ref.watch(navigatorKeyProvider),
      home: const AuthPage(),
    );
  }
}
