import 'package:bad_log/features/auth.dart';
import 'package:bad_log/pages/error_page.dart';
import 'package:bad_log/pages/home_page.dart';
import 'package:bad_log/pages/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authUserProvider).when(
      data: (data) {
        if (data != null) {
          return const HomePage();
        } else {
          return const LogInPage();
        }
      },
      error: (error, stackTrace) {
        return const ErrorPage();
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
