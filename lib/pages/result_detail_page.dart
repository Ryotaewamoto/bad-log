import 'package:bad_log/widgets/white_app_bar.dart';
import 'package:flutter/material.dart';

class ResultDetailPage extends StatelessWidget {
  const ResultDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: WhiteAppBar(title: 'New'),
      body: Center(child: Text('result_detail')),
    );
  }
}
