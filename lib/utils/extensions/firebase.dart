import 'package:firebase_core/firebase_core.dart';

extension FirebaseExceptionEx on FirebaseException {
  String get toJapanese {
    switch (code) {
      case 'network-request-failed':
        return '通信がエラーになったのか、またはタイムアウトになりました。通信環境がいい所で再度やり直してください。';
      case 'weak-password':
        return 'パスワードが短すぎます。6文字以上を入力してください。';
      case 'invalid-email':
        return 'メールアドレスが正しくありません';
      case 'email-already-in-use':
        return 'メールアドレスがすでに使用されています。ログインするか別のメールアドレスで作成してください';
      default: //想定外
        return 'アカウントの作成に失敗しました。通信環境がいい所で再度やり直してください。';
    }
  }
}
