import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/entity/answer_info.dart';
import 'package:fripo/domain/enum/turn_state.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/send_answer_use_case.dart';

class MockSendAnswerInteractor implements SendAnswerUseCase {
  @override
  Response<void> call({required String answer}) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final current = MockRoom.turns[MockRoom.currentTurn.toString()];
    if (current == null) {
      return Left(Failure('Specified Turn does not exist.'));
    }

    final newAnswers = current.answers ?? {};
    newAnswers[MockRoom.userAnswerId] = AnswerInfo(
      userId: MockRoom.userId,
      answer: answer,
      score: 0,
      parentMarkedPoint: 0,
    );
    final shouldChangeState = newAnswers.length == MockRoom.members.length - 1;

    MockRoom.turns[MockRoom.currentTurn.toString()] = current.copyWith(
      answers: newAnswers,
      state: shouldChangeState ? TurnState.marking : null,
    );
    MockRoom.addSink();

    return const Right(null);
  }
}
