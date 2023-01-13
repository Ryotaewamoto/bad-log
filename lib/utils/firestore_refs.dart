import 'package:bad_log/models/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';


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

// /// rooms コレクションの参照。
// final roomsRef = db.collection('rooms').withConverter(
//       fromFirestore: (ds, _) => Room.fromDocumentSnapshot(ds),
//       toFirestore: (obj, _) => obj.toJson(),
//     );

// /// room ドキュメントの参照。
// DocumentReference<Room> roomRef({
//   required String roomId,
// }) =>
//     roomsRef.doc(roomId);

// /// votingEvents コレクションの参照。
// CollectionReference<VotingEvent> votingEventsRef({
//   required String roomId,
// }) =>
//     roomRef(roomId: roomId).collection('votingEvents').withConverter(
//           fromFirestore: (ds, _) => VotingEvent.fromDocumentSnapshot(ds),
//           toFirestore: (obj, _) => obj.toJson(),
//         );

// /// votingEvent ドキュメントの参照。
// DocumentReference<VotingEvent> votingEventRef({
//   required String roomId,
//   required String votingEventId,
// }) =>
//     votingEventsRef(roomId: roomId).doc(votingEventId);

// /// feelings コレクションの参照。
// CollectionReference<Feeling> feelingsRef({
//   required String roomId,
//   required String votingEventId,
// }) =>
//     votingEventRef(roomId: roomId, votingEventId: votingEventId)
//         .collection('feelings')
//         .withConverter(
//           fromFirestore: (ds, _) => Feeling.fromDocumentSnapshot(ds),
//           toFirestore: (obj, _) => obj.toJson(),
//         );

// /// feeling ドキュメントの参照。
// DocumentReference<Feeling> feelingRef({
//   required String roomId,
//   required String votingEventId,
//   required String userId,
// }) =>
//     feelingsRef(roomId: roomId, votingEventId: votingEventId).doc(userId);

// /// completeVotingEventRequests コレクションの参照。
// CollectionReference<CompleteVotingRequest> completeVotingRequestsRef({
//   required String roomId,
//   required String votingEventId,
// }) =>
//     votingEventRef(roomId: roomId, votingEventId: votingEventId)
//         .collection('completeVotingRequests')
//         .withConverter(
//           fromFirestore: (ds, _) =>
//               CompleteVotingRequest.fromDocumentSnapshot(ds),
//           toFirestore: (obj, _) => obj.toJson(),
//         );

// /// completeVotingEventRequest ドキュメントの参照。
// DocumentReference<CompleteVotingRequest> completeVotingRequestRef({
//   required String roomId,
//   required String votingEventId,
// }) =>
//     completeVotingRequestsRef(roomId: roomId, votingEventId: votingEventId)
//         .doc(votingEventId);

// /// votes コレクションの参照。
// CollectionReference<Vote> votesRef({
//   required String roomId,
//   required String votingEventId,
// }) =>
//     votingEventRef(roomId: roomId, votingEventId: votingEventId)
//         .collection('votes')
//         .withConverter(
//           fromFirestore: (ds, _) => Vote.fromDocumentSnapshot(ds),
//           toFirestore: (obj, _) => obj.toJson(),
//         );

// /// vote ドキュメントの参照。
// DocumentReference<Vote> voteRef({
//   required String roomId,
//   required String votingEventId,
//   required String voteId,
// }) =>
//     votesRef(roomId: roomId, votingEventId: votingEventId).doc(voteId);

// /// testNotificationRequest コレクションの参照。
// final testNotificationRequestsRef =
//     db.collection('testNotificationRequests').withConverter(
//           fromFirestore: (ds, _) =>
//               TestNotificationRequest.fromDocumentSnapshot(ds),
//           toFirestore: (obj, _) => obj.toJson(),
//         );

// /// todo コレクションの参照。
// CollectionReference<Todo> todosRef({
//   required String userId,
// }) =>
//     appUserRef(userId: userId).collection('todos').withConverter(
//           fromFirestore: (ds, _) => Todo.fromDocumentSnapshot(ds),
//           toFirestore: (obj, _) => obj.toJson(),
//         );

// /// todo ドキュメントの参照。
// DocumentReference<Todo> todoRef({
//   required String userId,
//   required String memberId,
// }) =>
//     todosRef(userId: userId).doc(memberId);
