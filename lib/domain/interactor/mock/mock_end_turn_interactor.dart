import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/enum/room_state.dart';
import 'package:fripo/domain/use_case/end_turn_use_case.dart';

import '../../entity/turn_info.dart';
import '../../enum/turn_state.dart';

class MockEndTurnInteractor implements EndTurnUseCase {
  @override
  Response<void> call() async {
    if (MockRoom.members.values.any((element) => element.life! <= 0)) {
      MockRoom.state = RoomState.result;
      MockRoom.addSink();
      return const Right(null);
    }

    final currentParent = MockRoom.turns[MockRoom.currentTurnId].parentUserId;
    final String newParentId;
    switch (currentParent) {
      case MockRoom.userId:
        newParentId = MockRoom.otherId1;
        _setThemeAsync();
        break;
      case MockRoom.otherId1:
        newParentId = MockRoom.otherId2;
        _setThemeAsync();
        break;
      case MockRoom.otherId2:
        newParentId = MockRoom.userId;
        break;
      default:
        newParentId = MockRoom.userId;
    }

    MockRoom.currentTurn++;
    MockRoom.turns.add(TurnInfo(
      parentUserId: newParentId,
      theme: null,
      targetPoint: 30,
      state: TurnState.themeSetting,
      answers: null,
    ));
    MockRoom.addSink();
    return const Right(null);
  }

  void _setThemeAsync() async {
    Future.delayed(const Duration(milliseconds: 5000), () {
      final current = MockRoom.turns[MockRoom.currentTurnId];
      MockRoom.turns[MockRoom.currentTurnId] = current.copyWith(
        state: TurnState.answering,
        theme: 'Other set Theme',
      );
      MockRoom.addSink();
    });
  }
}
