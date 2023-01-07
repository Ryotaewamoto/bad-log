import 'package:bad_log/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'pages/auth_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BadLog',
      theme: ThemeData(
        fontFamily: 'Helvetica',
        scaffoldBackgroundColor: AppColors.baseWhite,
      ),
      home: const AuthPage(),
    );
  }
}
