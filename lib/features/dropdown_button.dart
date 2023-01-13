import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/member.dart';
import '../utils/fakes/member.dart';

/// 味方の [Member] の状態を保持する Provider。
final dropdownButtonPartnerMemberProvider =
    StateNotifierProvider.autoDispose<DropdownButtonMemberNotifier, Member>((ref) {
  return DropdownButtonMemberNotifier();
});

/// 1人目の対戦相手の [Member] の状態を保持する Provider。
final dropdownButtonFirstOpponentMemberProvider =
    StateNotifierProvider.autoDispose<DropdownButtonMemberNotifier, Member>(
        (ref) {
  return DropdownButtonMemberNotifier();
});

/// 2人目の対戦相手の [Member] の状態を保持する Provider。
final dropdownButtonSecondOpponentMemberProvider =
    StateNotifierProvider.autoDispose<DropdownButtonMemberNotifier, Member>(
        (ref) {
  return DropdownButtonMemberNotifier();
});

class DropdownButtonMemberNotifier extends StateNotifier<Member> {
  DropdownButtonMemberNotifier() : super(initMember);

  void selectedMember(Member? member) {
    if (member != null) {
      state = state.copyWith(
        memberId: member.memberId,
        memberName: member.memberName,
        createdAt: member.createdAt,
        updatedAt: member.updatedAt,
      );
    }
  }
}
