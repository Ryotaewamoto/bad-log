import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/result.dart';
import '../utils/constants/measure.dart';
import '../widgets/app_over_scroll_indicator.dart';
import '../widgets/match_result_card.dart';
import '../widgets/white_app_bar.dart';

class SameMemberResultPage extends HookConsumerWidget {
  const SameMemberResultPage({
    required this.results,
    super.key,
  });

  final List<Result> results;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const WhiteAppBar(
        title: '',
        automaticallyImplyLeading: true,
      ),
      body: AppOverScrollIndicator(
        child: SingleChildScrollView(
          child: Padding(
            padding: Measure.p_h16,
            child: Column(
              children: [
                Measure.g_8,
                Column(
                  children: results
                      .map(
                        (result) => MatchResultCard(
                          result: result,
                        ),
                      )
                      .toList(),
                ),
                Measure.g_8,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
