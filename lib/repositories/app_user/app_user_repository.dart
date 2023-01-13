import '../../models/app_user.dart';

abstract class AppUserRepository {
  Future<void> create({
    required String userId,
    required AppUser appUser,
  });

  Future<AppUser?> retrieve({required String userId});

  Future<void> update({
    required String userId,
    required AppUser appUser,
  });

  Future<void> delete({required String userId});
}
