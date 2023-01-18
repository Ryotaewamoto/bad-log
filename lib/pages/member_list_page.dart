import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/member.dart';
import '../models/member.dart';
import '../repositories/auth/auth_repository_impl.dart';
import '../utils/async_value_error_dialog.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/dialog.dart';
import '../utils/json_converters/union_timestamp.dart';
import '../utils/loading.dart';
import '../utils/scaffold_messenger_service.dart';
import '../utils/text_styles.dart';
import '../widgets/white_app_bar.dart';

class MemberListPage extends HookConsumerWidget {
  const MemberListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      createMemberControllerProvider,
      (_, state) async {
        if (state.isLoading) {
          ref.watch(overlayLoadingProvider.notifier).update((state) => true);
          return;
        }

        await state.when(
          data: (_) async {
            // ローディングを非表示にする
            ref.watch(overlayLoadingProvider.notifier).update((state) => false);

            // ログインできたらスナックバーでメッセージを表示してホーム画面に遷移する
            ref
                .read(scaffoldMessengerServiceProvider)
                .showSnackBar('Success !');

            Navigator.of(context).pop();
          },
          error: (e, s) async {
            // ローディングを非表示にする
            ref.watch(overlayLoadingProvider.notifier).update((state) => false);

            // エラーが発生したらエラーダイアログを表示する
            state.showAlertDialogOnError(context);
          },
          loading: () {
            // ローディングを表示する
            ref.watch(overlayLoadingProvider.notifier).update((state) => true);
          },
        );
      },
    );

    final members = ref.watch(membersProvider).maybeWhen<List<Member>>(
          data: (data) {
            return data;
          },
          orElse: () => [],
        );

    final userId = ref.watch(authRepositoryImplProvider).currentUser?.uid;

    final useMemberNameController = useTextEditingController();

    return Scaffold(
      appBar: WhiteAppBar(
        title: 'Members',
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              addMemberDialog(
                context,
                useMemberNameController,
                onPressed: () async {
                  final member = Member(
                    memberName: useMemberNameController.value.text,
                    createdAt: UnionTimestamp.dateTime(DateTime.now()),
                    updatedAt: UnionTimestamp.dateTime(DateTime.now()),
                  );

                  if (userId != null) {
                    await ref
                        .read(createMemberControllerProvider.notifier)
                        .createMember(
                          userId: userId,
                          member: member,
                        );
                  }
                },
              );
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
              (e) => DecoratedBox(
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
            )
            .toList(),
      ),
    );
  }
}
