import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/app_user.dart';
import '../repositories/app_user/app_user_repository_impl.dart';
import '../repositories/auth/auth_repository_impl.dart';

/// AppUser ドキュメントを取得する FutureProvider
final appUserFutureProvider = FutureProvider.autoDispose<AppUser?>((ref) async {
  final userId = ref.watch(authRepositoryImplProvider).currentUser!.uid;
  if (userId != null) {
    final appUser =
        await ref.read(appUserRepositoryImplProvider).retrieve(userId: userId);
    return appUser;
  } else {
    return null;
  }
});
