import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';
import '../models/deleted_user.dart';
import '../models/member.dart';
import '../models/result.dart';

final _db = FirebaseFirestore.instance;

/// appUsers コレクションの参照。
final appUsersRef = _db.collection('appUsers').withConverter(
      fromFirestore: (ds, _) => AppUser.fromDocumentSnapshot(ds),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// appUser ドキュメントの参照。
DocumentReference<AppUser> appUserRef({
  required String userId,
}) =>
    appUsersRef.doc(userId);

/// members コレクションの参照。
CollectionReference<Member> membersRef({
  required String userId,
}) =>
    appUserRef(userId: userId).collection('members').withConverter(
          fromFirestore: (ds, _) => Member.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// member ドキュメントの参照。
DocumentReference<Member> memberRef({
  required String userId,
  required String memberId,
}) =>
    membersRef(userId: userId).doc(memberId);

/// results コレクションの参照。
CollectionReference<Result> resultsRef({
  required String userId,
}) =>
    appUserRef(userId: userId).collection('results').withConverter(
          fromFirestore: (ds, _) => Result.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// result ドキュメントの参照。
DocumentReference<Result> resultRef({
  required String userId,
  required String resultId,
}) =>
    resultsRef(userId: userId).doc(resultId);

/// deletedUsers コレクションの参照。
final deletedUsersRef = _db.collection('deletedUsers').withConverter(
      fromFirestore: (ds, _) => DeletedUser.fromDocumentSnapshot(ds),
      toFirestore: (obj, _) => obj.toJson(),
    );
