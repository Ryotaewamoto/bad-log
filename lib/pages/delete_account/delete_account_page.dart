import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/auth/delete_account.dart';
import '../../utils/async_value_error_dialog.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/measure.dart';
import '../../utils/dialog.dart';
import '../../utils/loading.dart';
import '../../utils/scaffold_messenger_service.dart';
import '../../utils/text_styles.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/white_app_bar.dart';
import '../auth_page.dart';

class DeleteAccountPage extends HookConsumerWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      deleteAccountControllerProvider,
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
                .showSnackBar('アカウントを削除しました。');

            await Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => const AuthPage(),
              ),
              (_) => false,
            );
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

    // Provider
    final state = ref.watch(deleteAccountControllerProvider);

    return Scaffold(
      appBar: const WhiteAppBar(
        title: 'アカウントの削除',
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: Measure.p_a16,
        child: Column(
          children: [
            Measure.g_32,
            const Center(
              child: Icon(
                Icons.warning,
                size: 80,
                color: AppColors.primary,
              ),
            ),
            Measure.g_32,
            Padding(
              padding: Measure.p_h16,
              child: Center(
                child: Text(
                  'アカウントの削除により、以下の影響が生じます。',
                  style: TextStyles.p1(),
                ),
              ),
            ),
            Measure.g_32,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '削除したアカウントでのログインができなくなります。',
                style: TextStyles.p2(),
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'アプリ内で登録した試合結果やメンバーの情報はすべて削除されます。',
                style: TextStyles.p2(),
              ),
            ),
            const Divider(),
            Measure.g_32,
            Measure.g_32,
            PrimaryRoundedButton(
              text: '同意',
              onTap: () async {
                await showActionDialog(
                  context: context,
                  title: 'アカウントの削除',
                  content: 'アカウントを削除します。本当によろしいですか？',
                  onPressed: state.isLoading
                      ? null
                      : () async {
                          await ref
                              .read(deleteAccountControllerProvider.notifier)
                              .deleteAccount();
                        },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
