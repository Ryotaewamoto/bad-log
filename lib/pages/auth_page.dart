import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth.dart';
import 'error_page.dart';
import 'get_started_page.dart';
import 'home_page.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authUserProvider).when(
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
    );
  }
}
