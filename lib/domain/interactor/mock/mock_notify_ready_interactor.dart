import 'package:dartz/dartz.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/entity/turn_info.dart';
import 'package:fripo/domain/enum/room_state.dart';
import 'package:fripo/domain/enum/turn_state.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/notify_ready_use_case.dart';

import '../../../data/mock/mock_room.dart';
import '../../entity/member_info.dart';

class MockNotifyReadyInteractor implements NotifyReadyUseCase {
  @override
  Response<void> call() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final current = MockRoom.members[MockRoom.userMemberId];
    if (current == null) {
      return Left(Failure('Specified Member does not exist.'));
    }

    MockRoom.members[MockRoom.userMemberId] = MemberInfo.copyWith(
      current,
      isReady: true,
    );
    if (MockRoom.members.values.every((e) => e.isReady)) {
      MockRoom.state = RoomState.onGame;
      Future.delayed(const Duration(milliseconds: 50), () {
        MockRoom.currentTurn = 1;
        MockRoom.turns['1'] = TurnInfo(
          parentUserId: MockRoom.members.values.first.userId,
          theme: null,
          targetPoint: 50,
          state: TurnState.themeSetting,
          answers: null,
        );
        MockRoom.addSink();
        Future.delayed(const Duration(milliseconds: 3000), () {
          final current = MockRoom.turns[MockRoom.currentTurn.toString()];
          if (current == null) throw Exception();
          MockRoom.turns[MockRoom.currentTurn.toString()] = current.copyWith(
            theme: 'Test Theme',
            state: TurnState.answering,
          );
          MockRoom.addSink();
        });
      });
    }
    MockRoom.addSink();

    return const Right(null);
  }
}
