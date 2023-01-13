import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/app_user.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/measure.dart';
import '../utils/loading.dart';
import '../utils/text_styles.dart';
import '../widgets/white_app_bar.dart';
import 'settings_page.dart';

class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );
    return Stack(
      children: [
        Scaffold(
          appBar: WhiteAppBar(
            title: 'Account',
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<bool>(
                      builder: (_) => const SettingsPage(),
                    ),
                  );
                },
                icon: const FaIcon(
                  Icons.settings,
                  size: 32,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Measure.g_32,
              const Center(
                child: Icon(
                  Icons.account_circle,
                  color: AppColors.primary,
                  size: 128,
                ),
              ),
              Measure.g_8,
              Text(
                appUserName ?? '',
                style: TextStyles.h4(),
              ),
              Measure.g_24,
              Padding(
                padding: Measure.p_h16,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Rate', style: TextStyles.h2()),
                      ],
                    ),
                    Measure.g_8,
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.baseLight,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          )
                        ],
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: Measure.p_a8,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: AppColors.baseWhite,
                              child: Padding(
                                padding: Measure.p_a8,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Jonatan Christie',
                                              style: TextStyles.p2(),
                                            ),
                                          ),
                                          Measure.g_4,
                                          const Divider(
                                            height: 0,
                                            thickness: 2,
                                          ),
                                          Measure.g_4,
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Thomas Rouxel',
                                              style: TextStyles.p2Bold(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            '54',
                                            style: TextStyles.h1(),
                                          ),
                                          Align(
                                            child: Text(
                                              '%',
                                              style: TextStyles.h2(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Latest: 2022/03/25',
                                  style: TextStyles.p3(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
      ],
    );
  }
}
