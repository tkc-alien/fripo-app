import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/use_case/join_room_use_case.dart';

import '../../entity/member_info.dart';
import '../../enum/room_state.dart';

class MockJoinRoomInteractor implements JoinRoomUseCase {
  @override
  Response<String> call({required String roomId}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    MockRoom.state = RoomState.preparing;
    MockRoom.members['other1'] = MemberInfo(
      userId: 'other-user',
      name: '他ユーザ',
      iconUrl: '...',
      totalScore: 0,
      isActive: true,
      isReady: true,
    );
    MockRoom.addSink();

    MockRoom.members[MockRoom.userMemberId] = MemberInfo(
      userId: 'mock-user',
      name: 'モックユーザ',
      iconUrl: '...',
      totalScore: 0,
      isActive: false,
      isReady: false,
    );
    MockRoom.addSink();

    return const Right(MockRoom.roomId);
  }
}
