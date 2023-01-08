import 'package:bad_log/utils/extensions/widget_ref.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth.dart';
import 'error_page.dart';
import 'get_started_page.dart';
import 'home_page.dart';

/// 目には見えないが、アプリケーション上の全てのページがこの Scaffold の上に載るので
/// ScaffoldMessengerService でどこからでもスナックバーなどが表示できるようになっている。
class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.handleConnectivity();
    return Scaffold(
      body: ref.watch(authUserProvider).when(
        data: (data) {
          if (data != null) {
            return const HomePage();
          } else {
            return const GetStartedPage();
          }
        },
        error: (error, stackTrace) {
          return const ErrorPage();
        },
        loading: () {
          return const SizedBox();
        },
      ),
    );
  }
}
