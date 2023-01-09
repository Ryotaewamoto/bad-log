import 'package:bad_log/utils/constants/app_colors.dart';
import 'package:bad_log/utils/constants/measure.dart';
import 'package:bad_log/widgets/white_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const List<Widget> types = <Widget>[
  Text('Singles'),
  Text('Doubles'),
];

const List<bool> initTypes = [true, false];

final selectTypesProvider =
    StateNotifierProvider<SelectTypesNotifier, List<bool>>(
  (ref) => SelectTypesNotifier(),
);

class SelectTypesNotifier extends StateNotifier<List<bool>> {
  SelectTypesNotifier() : super(initTypes);

  void changeSelectType(int index) {
    state = [false, false];
    state[index] = true;
  }
}

final List<bool> selectedTypes = <bool>[true, false];

class CreatePage extends HookConsumerWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const WhiteAppBar(
        title: 'New',
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: Measure.p_a16,
        child: Column(
          children: [
            ToggleButtons(
              onPressed: (int index) {
                // The button that is tapped is set to true, and the others to false.
                ref.watch(selectTypesProvider.notifier).changeSelectType(index);
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: AppColors.secondary,
              selectedColor: AppColors.baseWhite,
              fillColor: AppColors.secondary,
              color: AppColors.secondary,
              constraints: const BoxConstraints(
                minHeight: 40,
                minWidth: 80,
              ),
              isSelected: ref.watch(selectTypesProvider),
              children: types,
            ),
            const Center(
              child: Text('result_detail'),
            ),
          ],
        ),
      ),
    );
  }
}
