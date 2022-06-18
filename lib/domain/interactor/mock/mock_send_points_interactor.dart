import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/entity/answer_info.dart';
import 'package:fripo/domain/enum/turn_state.dart';
import 'package:fripo/domain/use_case/send_points_use_case.dart';

class MockSendPointsInteractor implements SendPointsUseCase {
  @override
  Response<void> call({required Map<String, int> points}) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final current = MockRoom.turns[MockRoom.currentTurnId];
    final answers = current.answers!;
    final targetPoint = current.targetPoint;
    points.forEach((userId, point) {
      final dif = (targetPoint - point).abs();
      answers[userId] = AnswerInfo(
        answer: answers[userId]!.answer,
        difference: dif,
        point: point,
      );
      MockRoom.members[userId] = MockRoom.members[userId]!.copyWith(
        life: MockRoom.members[userId]!.life - dif,
      );
    });
    MockRoom.turns[MockRoom.currentTurnId] = current.copyWith(
      state: TurnState.result,
      answers: answers,
    );
    MockRoom.addSink();
    return const Right(null);
  }
}
