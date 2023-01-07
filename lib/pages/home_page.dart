import 'package:bad_log/pages/account_page.dart';
import 'package:bad_log/widgets/white_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar(
        title: '',
        leading: IconButton(
          onPressed: () {},
          icon: const FaIcon(
            Icons.sort,
            size: 32,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<bool>(
                  builder: (_) => const AccountPage(),
                ),
              );
            },
            icon: const FaIcon(
              Icons.account_circle_rounded,
              size: 32,
            ),
          )
        ],
      ),
      body: const Center(
        child: Text('home'),
      ),
    );
  }
}
