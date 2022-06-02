import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/use_case/notify_next_use_case.dart';

import '../../entity/turn_info.dart';
import '../../enum/turn_state.dart';

class MockNotifyNextInteractor implements NotifyNextUseCase {
  @override
  Response<void> call() async {
    final currentParent = MockRoom.turns[MockRoom.currentTurn].parentUserId;
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
      final current = MockRoom.turns[MockRoom.currentTurn];
      MockRoom.turns[MockRoom.currentTurn] = current.copyWith(
        state: TurnState.answering,
        theme: 'Other set Theme',
      );
      MockRoom.addSink();
    });
  }
}
