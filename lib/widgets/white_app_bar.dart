import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/text_styles.dart';

class WhiteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WhiteAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading,
      centerTitle: true,
      elevation: 0,
      title: Text(title, style: TextStyles.h2()),
      backgroundColor: AppColors.baseWhite,
      iconTheme: const IconThemeData(color: AppColors.primary),
      actions: actions,
    );
  }
}
