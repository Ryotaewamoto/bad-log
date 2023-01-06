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
      ),
      home: const AuthPage(),
    );
  }
}
