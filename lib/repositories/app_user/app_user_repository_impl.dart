import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/app_user.dart';
import '../../utils/firestore_refs.dart';
import '../../utils/logger.dart';
import 'app_user_repository.dart';

final appUserRepositoryImplProvider = Provider<AppUserRepository>(
  (ref) => AppUserRepositoryImpl(),
);

class AppUserRepositoryImpl implements AppUserRepository {
  /// 指定した userId のユーザーを `SetOptions(merge: true)` で作成する。
  @override
  Future<void> create({
    required String userId,
    required AppUser appUser,
  }) async {
    await appUserRef(userId: userId).set(
      appUser,
      SetOptions(merge: true),
    );
  }

  Future<AppUser?> fetchAppUser({
    required String userId,
  }) async {
    return null;
  }

  @override
  Future<void> delete({required String userId}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> retrieve({required String userId}) async {
    final ds = await appUserRef(userId: userId).get();
    if (!ds.exists) {
      logger.warning('Document not found: ${ds.reference.path}');
      return null;
    }
    return ds.data()!;
  }

  @override
  Future<void> update({required String userId, required AppUser appUser}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
