import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 1game か 3games のどちらの状態かを保持する [Provider]。
final is1gameRadioButtonProvider = StateProvider<String?>(
  (ref) => '1game',
);
