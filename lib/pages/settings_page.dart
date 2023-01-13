import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/member.dart';
import '../repositories/auth/auth_repository_impl.dart';
import '../utils/constants/app_colors.dart';
import '../utils/dialog.dart';
import '../utils/text_styles.dart';
import '../widgets/white_app_bar.dart';
import 'auth_page.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(authRepositoryImplProvider).currentUser!.email;
    final members = ref.watch(membersProvider).maybeWhen<int>(
          data: (data) {
            return data.length;
          },
          orElse: () => 0,
        );
    return Scaffold(
      appBar: const WhiteAppBar(
        title: 'Settings',
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {},
            highlightColor: AppColors.secondaryPale,
            splashColor: AppColors.secondaryPale,
            child: SizedBox(
              height: 64,
              child: ListTile(
                horizontalTitleGap: 0,
                title: Text(
                  'Account',
                  style: TextStyles.h4(),
                ),
                subtitle: Text(
                  userEmail ?? '',
                  style: TextStyles.p2(),
                ),
              ),
            ),
          ),
          const Divider(
            height: 0,
            color: AppColors.baseLight,
          ),
          InkWell(
            onTap: () {},
            highlightColor: AppColors.secondaryPale,
            splashColor: AppColors.secondaryPale,
            child: SizedBox(
              height: 64,
              child: ListTile(
                title: Text(
                  'Members',
                  style: TextStyles.h4(),
                ),
                subtitle: Text(
                  '$members / 20',
                  style: TextStyles.p2(),
                ),
              ),
            ),
          ),
          const Divider(
            height: 0,
            color: AppColors.baseLight,
          ),
          InkWell(
            onTap: () {},
            highlightColor: AppColors.secondaryPale,
            splashColor: AppColors.secondaryPale,
            child: SizedBox(
              height: 64,
              child: ListTile(
                title: Text(
                  'Terms',
                  style: TextStyles.h4(),
                ),
              ),
            ),
          ),
          const Divider(
            height: 0,
            color: AppColors.baseLight,
          ),
          InkWell(
            onTap: () {},
            highlightColor: AppColors.secondaryPale,
            splashColor: AppColors.secondaryPale,
            child: SizedBox(
              height: 64,
              child: ListTile(
                title: Text(
                  'Privacy Policy',
                  style: TextStyles.h4(),
                ),
              ),
            ),
          ),
          const Divider(
            height: 0,
            color: AppColors.baseLight,
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                await showActionDialog(
                  context: context,
                  title: 'Log Out',
                  content: 'Do you want to log out ?',
                  onPressed: () async {
                    // ログアウト
                    await ref.watch(authRepositoryImplProvider).signOut();

                    // https://twitter.com/riscait/status/1607587400271921152
                    // context.mounted が可能になった時に置き換える
                    // ignore: use_build_context_synchronously
                    await Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (_) => const AuthPage(),
                      ),
                      (_) => false,
                    );
                  },
                );
              },
              child: Text(
                'Log Out',
                style: TextStyles.p2(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
