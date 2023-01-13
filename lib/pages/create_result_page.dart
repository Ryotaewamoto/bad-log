import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/dropdown_button.dart';
import '../features/member.dart';
import '../features/radio_button.dart';
import '../features/toggle_button.dart';
import '../models/member.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/fakes/member.dart';
import '../utils/text_styles.dart';
import '../widgets/number_picker/numberpicker.dart';
import '../widgets/rounded_button.dart';
import '../widgets/white_app_bar.dart';

class CreateResultPage extends HookConsumerWidget {
  const CreateResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersProvider).maybeWhen<List<Member>>(
          data: (data) {
            return [initMember, ...data];
          },
          orElse: () => [
            initMember,
          ],
        );

    final selectedPartnerMember = ref.watch(
      dropdownButtonPartnerMemberProvider,
    );
    final selectedFirstOpponentMember = ref.watch(
      dropdownButtonFirstOpponentMemberProvider,
    );
    final selectedSecondOpponentMember = ref.watch(
      dropdownButtonSecondOpponentMemberProvider,
    );

    final yours1gameNumberState = useState(0);
    final opponents1gameNumberState = useState(0);

    final yours2gameNumberState = useState(0);
    final opponents2gameNumberState = useState(0);

    final yours3gameNumberState = useState(0);
    final opponents3gameNumberState = useState(0);

    return Scaffold(
      appBar: const WhiteAppBar(
        title: 'New',
        automaticallyImplyLeading: true,
      ),
      body: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: AppColors.secondary,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification notification) {
            notification.disallowIndicator(); // disallowGlow()を呼ぶ
            return false;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: Measure.p_h16,
              child: Column(
                children: [
                  const Gap(24),
                  ToggleButtons(
                    onPressed: (int index) {
                      ref
                          .watch(selectTypesProvider.notifier)
                          .changeSelectType(index);
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    borderColor: AppColors.secondary,
                    selectedColor: AppColors.baseWhite,
                    fillColor: AppColors.secondary,
                    color: AppColors.secondary,
                    highlightColor: AppColors.secondaryPale,
                    splashColor: AppColors.secondaryPale,
                    constraints: const BoxConstraints(
                      minHeight: 50,
                      minWidth: 130,
                    ),
                    isSelected: ref.watch(selectTypesProvider),
                    children: types,
                  ),
                  const Gap(32),
                  Row(
                    children: [
                      Text('Members', style: TextStyles.h2()),
                    ],
                  ),
                  Measure.g_16,
                  if (!(ref.watch(selectTypesProvider).first == true))
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Partner',
                            style: TextStyles.p1Bold(),
                          ),
                        ),
                        Measure.g_4,
                        Padding(
                          padding: Measure.p_h8,
                          child: DropdownMemberSelectButton(
                            membersList: members,
                            selectedSecondOpponentMember: selectedPartnerMember,
                            onChanged: (value) => ref
                                .read(
                                  dropdownButtonPartnerMemberProvider.notifier,
                                )
                                .selectedMember(value),
                          ),
                        ),
                        Measure.g_12,
                      ],
                    ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Opponent',
                          style: TextStyles.p1Bold(),
                        ),
                      ),
                      Measure.g_4,
                      Padding(
                        padding: Measure.p_h8,
                        child: DropdownMemberSelectButton(
                          membersList: members,
                          selectedSecondOpponentMember:
                              selectedFirstOpponentMember,
                          onChanged: (value) => ref
                              .read(
                                dropdownButtonFirstOpponentMemberProvider
                                    .notifier,
                              )
                              .selectedMember(value),
                        ),
                      ),
                      Measure.g_12,
                    ],
                  ),
                  if (!(ref.watch(selectTypesProvider).first == true))
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Opponent',
                            style: TextStyles.p1Bold(),
                          ),
                        ),
                        Measure.g_4,
                        Padding(
                          padding: Measure.p_h8,
                          child: DropdownMemberSelectButton(
                            membersList: members,
                            selectedSecondOpponentMember:
                                selectedSecondOpponentMember,
                            onChanged: (value) => ref
                                .read(
                                  dropdownButtonSecondOpponentMemberProvider
                                      .notifier,
                                )
                                .selectedMember(value),
                          ),
                        ),
                        Measure.g_12,
                      ],
                    ),
                  Measure.g_12,
                  Row(
                    children: [
                      Text('Scores', style: TextStyles.h2()),
                    ],
                  ),
                  Measure.g_16,
                  Row(
                    children: [
                      Row(
                        children: <Widget>[
                          Radio(
                            activeColor: AppColors.secondary,
                            value: '1game',
                            groupValue: ref.watch(is1gameRadioButtonProvider),
                            onChanged: (value) {
                              ref
                                  .watch(is1gameRadioButtonProvider.notifier)
                                  .update((state) => value);
                            },
                          ),
                          const Text('1 Game'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            activeColor: AppColors.secondary,
                            value: '3games',
                            groupValue: ref.watch(is1gameRadioButtonProvider),
                            onChanged: (value) {
                              ref
                                  .watch(is1gameRadioButtonProvider.notifier)
                                  .update((state) => value);
                            },
                          ),
                          const Text('3 Games'),
                        ],
                      ),
                    ],
                  ),
                  Measure.g_24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 80,
                        child: Center(child: Text('Yours')),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      SizedBox(
                        width: 80,
                        child: Center(child: Text('Opponents')),
                      ),
                    ],
                  ),
                  Measure.g_12,
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScoreSelectCard(state: yours1gameNumberState),
                          const SizedBox(
                            width: 80,
                          ),
                          ScoreSelectCard(state: opponents1gameNumberState),
                        ],
                      ),
                      Measure.g_12,
                    ],
                  ),
                  if (ref.watch(is1gameRadioButtonProvider) == '3games')
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ScoreSelectCard(state: yours2gameNumberState),
                            const SizedBox(
                              width: 80,
                            ),
                            ScoreSelectCard(state: opponents2gameNumberState),
                          ],
                        ),
                        Measure.g_12,
                      ],
                    ),
                  if (ref.watch(is1gameRadioButtonProvider) == '3games')
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ScoreSelectCard(state: yours3gameNumberState),
                            const SizedBox(
                              width: 80,
                            ),
                            ScoreSelectCard(state: opponents3gameNumberState),
                          ],
                        ),
                        Measure.g_12,
                      ],
                    ),
                  Measure.g_24,
                  PrimaryRoundedButton(
                    text: 'Save new result',
                    onTap: () => () {},
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreSelectCard extends StatelessWidget {
  const ScoreSelectCard({
    super.key,
    required this.state,
  });

  final ValueNotifier<int> state;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 114,
      decoration: BoxDecoration(
        color: AppColors.baseWhite,
        borderRadius: Measure.br_16,
        border: Border.all(
          color: AppColors.baseLight,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
          )
        ],
      ),
      child: NumberPicker(
        textStyle: const TextStyle(
          fontSize: 24,
          color: AppColors.textColor,
        ),
        selectedTextStyle: const TextStyle(
          fontSize: 40,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold,
        ),
        itemHeight: 38,
        value: state.value,
        minValue: 0,
        maxValue: 30,
        haptic: true,
        onChanged: (value) => state.value = value,
      ),
    );
  }
}

class DropdownMemberSelectButton extends HookWidget {
  const DropdownMemberSelectButton({
    super.key,
    required this.selectedSecondOpponentMember,
    required this.onChanged,
    required this.membersList,
  });

  final Member selectedSecondOpponentMember;
  final void Function(Member?)? onChanged;
  final List<Member> membersList;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: Measure.br_8,
        border: Border.all(
          color: selectedSecondOpponentMember == initMember
              ? AppColors.baseLight
              : AppColors.secondary,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Member?>(
            isExpanded: true,
            underline: Container(),
            value: selectedSecondOpponentMember, //追加
            style: const TextStyle(fontSize: 16, color: Colors.black),
            icon: const Icon(
              Icons.expand_more,
              color: AppColors.secondary,
            ),
            onChanged: onChanged, //追加
            items: membersList.map<DropdownMenuItem<Member?>>((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value.memberName),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
