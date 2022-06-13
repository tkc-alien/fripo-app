import 'package:dartz/dartz.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/use_case/join_room_use_case.dart';

import '../../entity/member_info.dart';
import '../../enum/room_state.dart';

class MockJoinRoomInteractor implements JoinRoomUseCase {
  @override
  Response<void> call({required String roomId}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    MockRoom.state = RoomState.preparing;
    MockRoom.hostUserId = MockRoom.otherId1;
    MockRoom.members[MockRoom.otherId1] = MemberInfo(
      name: 'USER-1',
      iconUrl: '...',
      totalScore: 0,
      isActive: true,
    );
    MockRoom.members[MockRoom.otherId2] = MemberInfo(
      name: 'USER-2',
      iconUrl: '...',
      totalScore: 0,
      isActive: true,
    );
    MockRoom.addSink();

    Future.delayed(const Duration(milliseconds: 50), () {
      MockRoom.members[MockRoom.userId] = MemberInfo(
        name: 'TEST-USER',
        iconUrl: '...',
        totalScore: 0,
        isActive: true,
      );
      MockRoom.addSink();
    });

    AppData.roomId = MockRoom.roomId;

    return const Right(null);
  }
}
