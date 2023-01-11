import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_repository.dart';

final authProvider = Provider<FirebaseAuth>(
  (_) => FirebaseAuth.instance,
);

final authRepositoryImplProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(authProvider)),
);

final authUserProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryImplProvider).authStateChanges(),
);

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._auth);
  final FirebaseAuth _auth;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  /// ユーザー作成
  @override
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// ログイン
  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }
}
