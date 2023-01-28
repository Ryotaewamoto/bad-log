import '../../models/member.dart';
import '../json_converters/union_timestamp.dart';

final initMember = Member(
  memberId: 'id-unselected',
  memberName: '選択されていません',
  createdAt: UnionTimestamp.dateTime(DateTime.now()),
  updatedAt: UnionTimestamp.dateTime(DateTime.now()),
);
