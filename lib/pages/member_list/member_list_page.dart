import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/member.dart';
import '../../models/member.dart';
import '../../repositories/auth/auth_repository_impl.dart';
import '../../utils/async_value_error_dialog.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/measure.dart';
import '../../utils/dialog.dart';
import '../../utils/json_converters/union_timestamp.dart';
import '../../utils/loading.dart';
import '../../utils/scaffold_messenger_service.dart';
import '../../utils/text_styles.dart';
import '../../widgets/white_app_bar.dart';

class MemberListPage extends HookConsumerWidget {
  const MemberListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen<AsyncValue<void>>(
        memberAddControllerProvider,
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
      )
      ..listen<AsyncValue<void>>(
        memberUpdateControllerProvider,
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
                  .showSnackBar('メンバーの情報を更新しました！');

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
        memberDeleteControllerProvider,
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
                  .showSnackBar('メンバーを削除しました。');

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

    final members = ref.watch(membersProvider).maybeWhen<List<Member>>(
          data: (data) {
            return data.where((element) => element.active == true).toList();
          },
          orElse: () => [],
        );

    final userId = ref.watch(authRepositoryImplProvider).currentUser?.uid;

    final useMemberNameController = useTextEditingController();
    final useReNameController = useTextEditingController();

    return Scaffold(
      appBar: WhiteAppBar(
        title: 'メンバー',
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () async {
              if (members.length < 20) {
                await addMemberDialog(
                  context,
                  useMemberNameController,
                  onPressed: () async {
                    final member = Member(
                      memberName: useMemberNameController.value.text,
                      active: true,
                      createdAt: const UnionTimestamp.serverTimestamp(),
                      updatedAt: const UnionTimestamp.serverTimestamp(),
                    );

                    if (userId != null) {
                      await ref
                          .read(memberAddControllerProvider.notifier)
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
            icon: const FaIcon(
              Icons.add,
              size: 32,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
      body: Column(
        children: members
            .map(
              (e) => Slidable(
                startActionPane: ActionPane(
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await showActionDialog(
                          context: context,
                          title: 'メンバーの削除',
                          content:
                              '''${e.memberName} を削除します。\n\n削除した場合、このメンバーを含む試合結果は残ります。しかし、以後同名の人物を追加した場合でも、その試合結果は新しい試合結果としてまとめられます。これを踏まえた上でメンバーを削除しますか？''',
                          onPressed: () async {
                            if (userId != null) {
                              await ref
                                  .read(memberDeleteControllerProvider.notifier)
                                  .deleteMember(
                                    userId: userId,
                                    memberId: e.memberId,
                                    member: e,
                                  );
                            }
                          },
                        );
                      },
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.baseWhite,
                      icon: Icons.delete_forever,
                      label: '削除',
                    ),
                    SlidableAction(
                      onPressed: (context) async {
                        useReNameController.text = e.memberName;
                        await editMemberDialog(
                          context,
                          useReNameController,
                          onPressed: () async {
                            final member = e.copyWith(
                              memberName: useReNameController.value.text,
                            );

                            if (userId != null) {
                              await ref
                                  .read(memberUpdateControllerProvider.notifier)
                                  .updateMember(
                                    userId: userId,
                                    memberId: e.memberId,
                                    member: member,
                                  );
                            }
                          },
                        );
                      },
                      backgroundColor: AppColors.secondary,
                      foregroundColor: AppColors.baseWhite,
                      icon: Icons.edit,
                      label: '編集',
                    ),
                  ],
                ),
                key: ValueKey(members.indexOf(e)),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: AppColors.baseLight)),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: Measure.p_h16,
                      child: Padding(
                        padding: Measure.p_v4,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_circle_rounded,
                              size: 32,
                              color: AppColors.primary,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  e.memberName,
                                  style: TextStyles.p1(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
