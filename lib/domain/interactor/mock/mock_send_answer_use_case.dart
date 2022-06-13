import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/entity/answer_info.dart';
import 'package:fripo/domain/enum/turn_state.dart';
import 'package:fripo/domain/use_case/send_answer_use_case.dart';

class MockSendAnswerInteractor implements SendAnswerUseCase {
  @override
  Response<void> call({required String answer}) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final current = MockRoom.turns[MockRoom.currentTurnId];

    final newAnswers = current.answers ?? {};
    newAnswers[MockRoom.userId] = AnswerInfo(
      answer: answer,
      score: null,
      parentMarkedPoint: null,
    );

    final parent = current.parentUserId;
    if (parent == MockRoom.otherId1) {
      newAnswers[MockRoom.otherId2] = AnswerInfo(
        answer: 'MockAnswer',
        score: null,
        parentMarkedPoint: null,
      );
    } else if (parent == MockRoom.otherId2) {
      newAnswers[MockRoom.otherId1] = AnswerInfo(
        answer: 'MockAnswer',
        score: null,
        parentMarkedPoint: null,
      );
    }

    MockRoom.turns[MockRoom.currentTurnId] = current.copyWith(
      answers: newAnswers,
      state: TurnState.marking,
    );
    MockRoom.addSink();

    Future.delayed(const Duration(milliseconds: 5000), () {
      final current = MockRoom.turns[MockRoom.currentTurnId];
      const point = 50;
      current.answers!.forEach((key, value) {
        final score = 50 - (current.targetPoint - point).abs();
        current.answers![key] = AnswerInfo(
          answer: value.answer,
          score: score,
          parentMarkedPoint: point,
        );

        final currentMember = MockRoom.members[key]!;
        MockRoom.members[key] = currentMember.copyWith(
          totalScore: currentMember.totalScore + score,
        );
      });
      MockRoom.turns[MockRoom.currentTurnId] = current.copyWith(
        state: TurnState.result,
      );
      MockRoom.addSink();
    });

    return const Right(null);
  }
}
