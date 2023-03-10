import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/app_user.dart';
import '../repositories/app_user/app_user_repository_impl.dart';
import '../repositories/auth/auth_repository_impl.dart';

/// appUser ドキュメントを取得する [FutureProvider]。
final appUserFutureProvider = FutureProvider.autoDispose<AppUser?>((ref) async {
  final userId = ref.watch(authRepositoryImplProvider).currentUser!.uid;
  final appUser =
      await ref.read(appUserRepositoryImplProvider).fetch(userId: userId);
  return appUser;
});
