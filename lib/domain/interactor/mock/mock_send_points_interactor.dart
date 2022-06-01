import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/entity/answer_info.dart';
import 'package:fripo/domain/enum/turn_state.dart';
import 'package:fripo/domain/use_case/send_points_use_case.dart';

class MockSendPointsInteractor implements SendPointsUseCase {
  @override
  Response<void> call({required Map<String, int> points}) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final current = MockRoom.turns[MockRoom.currentTurn];
    final answers = current.answers!;
    final targetPoint = current.targetPoint;
    points.forEach((userId, point) {
      final score = 50 - (targetPoint - point).abs();
      answers[userId] = AnswerInfo(
        answer: answers[userId]!.answer,
        score: score,
        parentMarkedPoint: point,
      );
    });
    MockRoom.turns[MockRoom.currentTurn] = current.copyWith(
      state: TurnState.result,
      answers: answers,
    );
    MockRoom.addSink();
    return const Right(null);
  }
}
