import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/dropdown_button.dart';
import '../features/member.dart';
import '../features/radio_button.dart';
import '../features/result.dart';
import '../features/toggle_button.dart';
import '../models/member.dart';
import '../models/result.dart';
import '../repositories/auth/auth_repository_impl.dart';
import '../utils/async_value_error_dialog.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/constants/member.dart';
import '../utils/dialog.dart';
import '../utils/json_converters/union_timestamp.dart';
import '../utils/loading.dart';
import '../utils/result_format.dart';
import '../utils/result_types.dart';
import '../utils/scaffold_messenger_service.dart';
import '../utils/text_styles.dart';
import '../widgets/app_over_scroll_indicator.dart';
import '../widgets/number_picker/numberpicker.dart';
import '../widgets/rounded_button.dart';
import '../widgets/white_app_bar.dart';

class CreateResultPage extends HookConsumerWidget {
  const CreateResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen<AsyncValue<void>>(
        createResultControllerProvider,
        (_, state) async {
          if (state.isLoading) {
            ref.watch(overlayLoadingProvider.notifier).update((state) => true);
            return;
          }

          await state.when(
            data: (_) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              // ログインできたらスナックバーでメッセージを表示してホーム画面に遷移する
              ref
                  .read(scaffoldMessengerServiceProvider)
                  .showSnackBar('Success !');

              Navigator.of(context).pop();
            },
            error: (e, s) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              // エラーが発生したらエラーダイアログを表示する
              state.showAlertDialogOnError(context);
            },
            loading: () {
              // ローディングを表示する
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => true);
            },
          );
        },
      )
      ..listen<AsyncValue<void>>(
        memberControllerProvider,
        (_, state) async {
          if (state.isLoading) {
            ref.watch(overlayLoadingProvider.notifier).update((state) => true);
            return;
          }

          await state.when(
            data: (_) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              // スナックバーでメッセージを表示してホーム画面に遷移する
              ref
                  .read(scaffoldMessengerServiceProvider)
                  .showSnackBar('メンバーを追加しました！');

              Navigator.of(context).pop();
            },
            error: (e, s) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              // エラーが発生したらエラーダイアログを表示する
              state.showAlertDialogOnError(context);
            },
            loading: () {
              // ローディングを表示する
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => true);
            },
          );
        },
      );

    // Provider
    final members = ref.watch(membersProvider).maybeWhen<List<Member>>(
          data: (data) {
            final members =
                data.where((element) => element.active == true).toList();
            return [initMember, ...members];
          },
          orElse: () => [
            initMember,
          ],
        );

    final userId = ref.watch(authRepositoryImplProvider).currentUser?.uid;

    final selectedPartnerMember = ref.watch(
      dropdownButtonPartnerMemberProvider,
    );
    final selectedFirstOpponentMember = ref.watch(
      dropdownButtonFirstOpponentMemberProvider,
    );
    final selectedSecondOpponentMember = ref.watch(
      dropdownButtonSecondOpponentMemberProvider,
    );

    // Hooks
    final useMemberNameController = useTextEditingController();

    final yours1gameNumberState = useState(0);
    final opponents1gameNumberState = useState(0);

    final yours2gameNumberState = useState(0);
    final opponents2gameNumberState = useState(0);

    final yours3gameNumberState = useState(0);
    final opponents3gameNumberState = useState(0);

    return Stack(
      children: [
        Scaffold(
          appBar: const WhiteAppBar(
            title: '試合結果の追加',
            automaticallyImplyLeading: true,
          ),
          body: AppOverScrollIndicator(
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
                      borderRadius: Measure.br_8,
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
                        Text('メンバー', style: TextStyles.h2()),
                        IconButton(
                          splashRadius: 20,
                          onPressed: () async {
                            // 注意:
                            // 追加メンバーを指定した状態でメンバーと追加しようとすると
                            // [DropdownButton] の [value] に関してエラーが出る。
                            // そのため選択したメンバーをリセットする。
                            ref
                                .read(
                                  dropdownButtonFirstOpponentMemberProvider
                                      .notifier,
                                )
                                .selectedMember(initMember);
                            if (members.length < 20) {
                              await addMemberDialog(
                                context,
                                useMemberNameController,
                                onPressed: () async {
                                  final member = Member(
                                    memberName:
                                        useMemberNameController.value.text,
                                    active: true,
                                    createdAt:
                                        const UnionTimestamp.serverTimestamp(),
                                    updatedAt:
                                        const UnionTimestamp.serverTimestamp(),
                                  );

                                  if (userId != null) {
                                    await ref
                                        .read(memberControllerProvider.notifier)
                                        .createMember(
                                          userId: userId,
                                          member: member,
                                        );
                                  }

                                  useMemberNameController.clear();
                                },
                              );
                            } else {
                              await showAlertDialog(
                                context: context,
                                title: 'メンバーの上限',
                                defaultActionText: 'OK',
                                content: '''メンバーの数が上限の20人に達しています。\n今後の
                                    アップデートにより人数を増やす予定です。''',
                              );
                            }
                          },
                          icon: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: FaIcon(
                                Icons.add,
                                size: 18,
                                color: AppColors.baseWhite,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Measure.g_16,
                    if (!(ref.watch(selectTypesProvider).first == true))
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'パートナー',
                              style: TextStyles.p1Bold(),
                            ),
                          ),
                          Measure.g_4,
                          Padding(
                            padding: Measure.p_h8,
                            child: _DropdownMemberSelectButton(
                              membersList: members,
                              selectedSecondOpponentMember:
                                  selectedPartnerMember,
                              onChanged: (value) => ref
                                  .read(
                                    dropdownButtonPartnerMemberProvider
                                        .notifier,
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
                            '対戦相手',
                            style: TextStyles.p1Bold(),
                          ),
                        ),
                        Measure.g_4,
                        Padding(
                          padding: Measure.p_h8,
                          child: _DropdownMemberSelectButton(
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
                              '対戦相手',
                              style: TextStyles.p1Bold(),
                            ),
                          ),
                          Measure.g_4,
                          Padding(
                            padding: Measure.p_h8,
                            child: _DropdownMemberSelectButton(
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
                        Text('得点', style: TextStyles.h2()),
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
                                    .watch(
                                      is1gameRadioButtonProvider.notifier,
                                    )
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
                                    .watch(
                                      is1gameRadioButtonProvider.notifier,
                                    )
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
                          child: Center(child: Text('自分')),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        SizedBox(
                          width: 80,
                          child: Center(child: Text('相手')),
                        ),
                      ],
                    ),
                    Measure.g_12,
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _ScoreSelectCard(state: yours1gameNumberState),
                            const SizedBox(
                              width: 80,
                            ),
                            _ScoreSelectCard(
                              state: opponents1gameNumberState,
                            ),
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
                              _ScoreSelectCard(state: yours2gameNumberState),
                              const SizedBox(
                                width: 80,
                              ),
                              _ScoreSelectCard(
                                state: opponents2gameNumberState,
                              ),
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
                              _ScoreSelectCard(state: yours3gameNumberState),
                              const SizedBox(
                                width: 80,
                              ),
                              _ScoreSelectCard(
                                state: opponents3gameNumberState,
                              ),
                            ],
                          ),
                          Measure.g_12,
                        ],
                      ),
                    Measure.g_24,
                    PrimaryRoundedButton(
                      text: '追加',
                      onTap: () async {
                        // 二重の処理を防ぐために先にローディングの状態にしておく。

                        ref
                            .watch(overlayLoadingProvider.notifier)
                            .update((state) => true);
                        // 点数のバリデーション
                        final is1game =
                            ref.watch(is1gameRadioButtonProvider) == '1game';
                        final scores = scoreFormat(
                          is1game: is1game,
                          yours1gameNumber: yours1gameNumberState.value,
                          yours2gameNumber: yours2gameNumberState.value,
                          yours3gameNumber: yours3gameNumberState.value,
                          opponents1gameNumber: opponents1gameNumberState.value,
                          opponents2gameNumber: opponents2gameNumberState.value,
                          opponents3gameNumber: opponents3gameNumberState.value,
                        );
                        final yourScore = scores[0];
                        final opponentsScore = scores[1];

                        // 勝者のバリデーション
                        final isWinner = isWinnerValidation(
                          is1game: is1game,
                          yourScore: yourScore,
                          opponentsScore: opponentsScore,
                        );

                        // メンバーのバリデーション
                        final isSingles =
                            ref.watch(selectTypesProvider).first == true;
                        final partner = partnerFormat(
                          isSingles: isSingles,
                          partnerId: selectedPartnerMember.memberId,
                        );
                        final opponents = opponentsFormat(
                          isSingles: isSingles,
                          firstOpponentId: selectedFirstOpponentMember.memberId,
                          secondOpponentId:
                              selectedSecondOpponentMember.memberId,
                        );

                        final result = Result(
                          type: ref.watch(selectTypesProvider).first == true
                              ? ResultTypes.singles.name
                              : ResultTypes.doubles.name,
                          partner: partner,
                          opponents: opponents,
                          yourScore: yourScore,
                          opponentsScore: opponentsScore,
                          isWinner: isWinner,
                          createdAt: const UnionTimestamp.serverTimestamp(),
                          updatedAt: const UnionTimestamp.serverTimestamp(),
                        );

                        if (userId != null) {
                          await ref
                              .read(createResultControllerProvider.notifier)
                              .createResult(
                                userId: userId,
                                result: result,
                              );
                        }
                      },
                    ),
                    const Gap(40),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
      ],
    );
  }
}

class _ScoreSelectCard extends StatelessWidget {
  const _ScoreSelectCard({
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

class _DropdownMemberSelectButton extends HookWidget {
  const _DropdownMemberSelectButton({
    required this.selectedSecondOpponentMember,
    required this.onChanged,
    required this.membersList,
  });

  final Member? selectedSecondOpponentMember;
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
