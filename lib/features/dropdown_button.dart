import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/member.dart';
import '../utils/fakes/member.dart';

final dropdownButtonPartnerMemberProvider =
    StateNotifierProvider<DropdownButtonMemberNotifier, Member>((ref) {
  return DropdownButtonMemberNotifier();
});

final dropdownButtonFirstOpponentMemberProvider =
    StateNotifierProvider.autoDispose<DropdownButtonMemberNotifier, Member>(
        (ref) {
  return DropdownButtonMemberNotifier();
});

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
