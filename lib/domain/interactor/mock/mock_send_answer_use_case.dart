import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/entity/answer_info.dart';
import 'package:fripo/domain/enum/turn_state.dart';
import 'package:fripo/domain/interactor/mock/mock_end_turn_interactor.dart';
import 'package:fripo/domain/use_case/send_answer_use_case.dart';

class MockSendAnswerInteractor implements SendAnswerUseCase {
  @override
  Response<void> call({required String answer}) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final current = MockRoom.turns[MockRoom.currentTurnId];

    final newAnswers = current.answers ?? {};
    newAnswers[MockRoom.userId] = AnswerInfo(
      answer: answer,
      difference: null,
      point: null,
    );

    final parent = current.parentUserId;
    if (parent == MockRoom.otherId1) {
      newAnswers[MockRoom.otherId2] = AnswerInfo(
        answer: 'MockAnswer',
        difference: null,
        point: null,
      );
    } else if (parent == MockRoom.otherId2) {
      newAnswers[MockRoom.otherId1] = AnswerInfo(
        answer: 'MockAnswer',
        difference: null,
        point: null,
      );
    }

    MockRoom.turns[MockRoom.currentTurnId] = current.copyWith(
      answers: newAnswers,
      state: TurnState.marking,
    );
    MockRoom.addSink();

    Future.delayed(const Duration(milliseconds: 5000), () {
      final current = MockRoom.turns[MockRoom.currentTurnId];
      final dif = (current.targetPoint - 55).abs();
      current.answers!.forEach((key, value) {
        current.answers![key] = AnswerInfo(
          answer: value.answer,
          difference: dif,
          point: 55,
        );

        final currentMember = MockRoom.members[key]!;
        MockRoom.members[key] = currentMember.copyWith(
          life: currentMember.life! - dif,
        );
      });
      MockRoom.turns[MockRoom.currentTurnId] = current.copyWith(
        state: TurnState.result,
      );
      MockRoom.addSink();

      Future.delayed(const Duration(milliseconds: 3000), () {
        MockEndTurnInteractor().call();
      });
    });

    return const Right(null);
  }
}
