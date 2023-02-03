import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/result_types.dart';

/// アプリの表記のみ日本語。英語に対応する際は [.enName] を使用する。
final List<Widget> types =
    ResultTypes.values.map((type) => Text(type.jpName)).toList();

const List<bool> initTypes = [true, false];

/// singles か doubles かを [ToggleButtons] で選択するための [Provider]。
///
/// [ToggleButtons] の形式上、bool 型の [List] を使用している。
///
/// 選択状態を保持していて欲しいので [.autoDispose] は使用しない。
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
