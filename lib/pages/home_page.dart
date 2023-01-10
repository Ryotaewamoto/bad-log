import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/constants/app_colors.dart';
import '../widgets/white_app_bar.dart';
import 'account_page.dart';
import 'create_result_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
            ),
          ],
        ),
        body: const Center(
          child: Text('home'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondary,
          child: const FaIcon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<bool>(
                builder: (_) => const CreateResultPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
