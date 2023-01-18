import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';

class AppOverScrollIndicator extends StatelessWidget {
  const AppOverScrollIndicator({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: AppColors.secondary,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification notification) {
          notification.disallowIndicator(); // disallowGlow()を呼ぶ
          return false;
        },
        child: child,
      ),
    );
  }
}
