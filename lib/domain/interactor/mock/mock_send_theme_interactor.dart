import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/enum/turn_state.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/send_theme_use_case.dart';

import '../../entity/answer_info.dart';

class MockSendThemeInteractor implements SendThemeUseCase {
  @override
  Response<void> call({required String theme}) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final current = MockRoom.turns[MockRoom.currentTurn.toString()];
    if (current == null) {
      return const Left(Failure('No Turn object found'));
    }

    MockRoom.turns[MockRoom.currentTurn.toString()] = current.copyWith(
      theme: theme,
      state: TurnState.answering,
    );
    MockRoom.addSink();

    Future.delayed(const Duration(milliseconds: 5000), () {
      final current = MockRoom.turns[MockRoom.currentTurn.toString()];
      if (current == null) return;
      final newAnswers = current.answers ?? {};
      newAnswers[MockRoom.otherId] = AnswerInfo(
        answer: 'Mock Answer',
        score: 0,
        parentMarkedPoint: 0,
      );
      MockRoom.turns[MockRoom.currentTurn.toString()] = current.copyWith(
        answers: newAnswers,
        state: TurnState.marking,
      );
      MockRoom.addSink();
    });

    return const Right(null);
  }
}
