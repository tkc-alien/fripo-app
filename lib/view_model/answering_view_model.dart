import 'package:flutter/material.dart';
import 'package:fripo/domain/use_case/send_answer_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class AnsweringViewModel with ChangeNotifier {
  AnsweringViewModel() : _sendAnswerUseCase = sl() {
    startCount();
  }

  final SendAnswerUseCase _sendAnswerUseCase;

  String Function()? getText;
  bool _sendingAnswer = false;
  bool _done = false;
  int _timeLimit = 30;
  bool _isAlive = true;

  bool get canSend {
    return !(_sendingAnswer || _done);
  }

  void startCount() async {
    const dur = Duration(seconds: 1);
    while (_timeLimit > 0) {
      await Future.delayed(dur);
      if (!_isAlive) {
        return;
      }
      _timeLimit--;
      notifyListeners();
    }
    sendAnswer();
  }

  Future<void> sendAnswer() async {
    final answer = getText?.call();
    if (answer == null) {
      print('No Input Answer.');
      return;
    } else if (!canSend) {
      print('Cannot send Answer.');
      return;
    }

    _sendingAnswer = true;
    notifyListeners();

    final res = await _sendAnswerUseCase.call(answer: answer);
    _sendingAnswer = false;
    res.fold(
      (failure) => print(failure),
      (_) {
        print('SendAnswer succeed.');
        _done = true;
      },
    );

    notifyListeners();
  }

  @override
  void dispose() {
    _isAlive = false;
    super.dispose();
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
  int get timeLimit => _timeLimit;
}
