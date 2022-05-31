import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/domain/enum/room_state.dart';

import '../../use_case/create_room_use_case.dart';

class MockCreateRoomInteractor implements CreateRoomUseCase {
  @override
  Response<String> call() async {
    await Future.delayed(const Duration(milliseconds: 500));

    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      MockRoom.state = RoomState.preparing;
      MockRoom.members[MockRoom.userId] = MemberInfo(
        name: 'モックユーザ',
        iconUrl: '...',
        totalScore: 0,
        isActive: false,
      );
      MockRoom.addSink();
    });

    Future.delayed(const Duration(milliseconds: 1000)).then((_) {
      MockRoom.members[MockRoom.otherId] = MemberInfo(
        name: '他ユーザ',
        iconUrl: '...',
        totalScore: 0,
        isActive: true,
      );
      MockRoom.addSink();
    });

    return const Right(MockRoom.roomId);
  }
}
