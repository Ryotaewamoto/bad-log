import '../../models/app_user.dart';
import '../../models/deleted_user.dart';

abstract class AppUserRepository {
  Future<void> create({
    required String userId,
    required AppUser appUser,
  });

  Future<AppUser?> fetch({required String userId});

  Future<void> update({
    required String userId,
    required AppUser appUser,
  });

  Future<void> delete({required DeletedUser deletedUser});
}
