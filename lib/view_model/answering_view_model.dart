import 'package:flutter/material.dart';
import 'package:fripo/domain/use_case/send_answer_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class AnsweringViewModel with ChangeNotifier {
  AnsweringViewModel() : _sendAnswerUseCase = sl();

  final SendAnswerUseCase _sendAnswerUseCase;

  String Function()? getText;
  bool _sendingAnswer = false;
  bool _done = false;

  bool get canSend {
    return !(_sendingAnswer || _done);
  }

  Future<void> sendAnswer() async {
    final answer = getText?.call();
    if (answer == null) {
      return;
    } else if (!canSend) {
      return;
    }

    _sendingAnswer = true;
    notifyListeners();

    final res = await _sendAnswerUseCase.call(answer: answer);
    _sendingAnswer = false;
    res.fold(
      (failure) {},
      (_) {
        _done = true;
      },
    );

    notifyListeners();
  }

  static AnsweringViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(AnsweringViewModel vm) select,
  ) {
    return context.select(select);
  }
}

extension Getters on AnsweringViewModel {
  bool get sendingAnswer => _sendingAnswer;
  bool get done => _done;
}
