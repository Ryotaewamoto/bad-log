import 'package:flutter/material.dart';

import '../widgets/white_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: WhiteAppBar(
        title: 'Settings',
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Text('Settings page'),
      ),
    );
  }
}
