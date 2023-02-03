import '../../models/member.dart';
import '../json_converters/union_timestamp.dart';

const initMember = Member(
  memberId: 'id-unselected',
  memberName: '選択されていません',
  createdAt: UnionTimestamp.serverTimestamp(),
  updatedAt: UnionTimestamp.serverTimestamp(),
);
