import 'package:flutter/material.dart';
import 'package:fripo/domain/use_case/notify_ready_for_next_turn_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class ResultViewModel with ChangeNotifier {
  ResultViewModel() : _notifyReadyForNextTurnUseCase = sl();

  final NotifyReadyForNextTurnUseCase _notifyReadyForNextTurnUseCase;

  bool _hasNotified = false;
  bool _isRequestingEndTurn = false;

  Future<void> notifyReady() async {
    if (_isRequestingEndTurn) return;
    _isRequestingEndTurn = true;
    final res = await _notifyReadyForNextTurnUseCase.call();
    res.fold(
      (failure) => print(failure),
      (_) {
        print('NotifyNext succeed.');
        _hasNotified = true;
        notifyListeners();
      },
    );
    _isRequestingEndTurn = false;
  }

  static ResultViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(ResultViewModel vm) select,
  ) {
    return context.select(select);
  }
}

extension Getters on ResultViewModel {
  bool get hasNotified => _hasNotified;
}
