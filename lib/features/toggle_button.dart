import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const List<Widget> types = <Widget>[
  Text('Singles'),
  Text('Doubles'),
];

const List<bool> initTypes = [true, false];

/// singles か doubles かを [ToggleButtons] で選択するための Provider。
///
///　選択状態を保持していて欲しいので [.autoDispose] は使用しない。
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
