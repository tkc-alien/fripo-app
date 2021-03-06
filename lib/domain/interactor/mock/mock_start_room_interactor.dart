import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/entity/turn_info.dart';
import 'package:fripo/domain/enum/room_state.dart';
import 'package:fripo/domain/enum/turn_state.dart';
import 'package:fripo/domain/use_case/start_room_use_case.dart';

import '../../error/failure.dart';

class MockStartRoomInteractor implements StartRoomUseCase {
  @override
  Response<void> call({required int defaultLife}) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (MockRoom.members.length > 2) {
      MockRoom.state = RoomState.onGame;
      MockRoom.currentTurn = 1;
      MockRoom.turns.clear();
      MockRoom.addSink();
      Future.delayed(const Duration(milliseconds: 30), () {
        MockRoom.turns.add(TurnInfo(
          parentUserId: MockRoom.hostUserId,
          theme: null,
          targetPoint: 30,
          state: TurnState.themeSetting,
          answers: null,
        ));
        MockRoom.addSink();
      });
      return const Right(null);
    } else {
      return const Left(Failure('Room does not have enough members.'));
    }
  }
}
