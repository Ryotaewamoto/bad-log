import '../../models/member.dart';
import '../json_converters/union_timestamp.dart';

final List<Member> fakeMembers = [
  initMember,
  Member(
    memberId: 'id-aaaaaaaa',
    memberName: 'Viktor AXELSEN',
    createdAt: UnionTimestamp.dateTime(DateTime.now()),
    updatedAt: UnionTimestamp.dateTime(DateTime.now()),
  ),
  Member(
    memberId: 'id-bbbbbbbb',
    memberName: 'LEE Zii Jia',
    createdAt: UnionTimestamp.dateTime(DateTime.now()),
    updatedAt: UnionTimestamp.dateTime(DateTime.now()),
  ),
  Member(
    memberId: 'id-cccccccc',
    memberName: 'Jonatan CHRISTIE',
    createdAt: UnionTimestamp.dateTime(DateTime.now()),
    updatedAt: UnionTimestamp.dateTime(DateTime.now()),
  ),
  Member(
    memberId: 'id-dddddddd',
    memberName: 'Anthony Sinisuka GINTING',
    createdAt: UnionTimestamp.dateTime(DateTime.now()),
    updatedAt: UnionTimestamp.dateTime(DateTime.now()),
  ),
];

final initMember = Member(
  memberId: 'id-unselected',
  memberName: 'Unselected',
  createdAt: UnionTimestamp.dateTime(DateTime.now()),
  updatedAt: UnionTimestamp.dateTime(DateTime.now()),
);
