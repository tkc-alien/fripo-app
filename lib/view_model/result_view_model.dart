import 'package:flutter/material.dart';
import 'package:fripo/domain/use_case/end_turn_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class ResultViewModel with ChangeNotifier {
  ResultViewModel() : _endTurnUseCase = sl();

  final EndTurnUseCase _endTurnUseCase;

  bool _isRequestingEndTurn = false;

  Future<void> endTurn() async {
    if (_isRequestingEndTurn) return;
    _isRequestingEndTurn = true;
    final res = await _endTurnUseCase.call();
    res.fold(
      (failure) => print(failure),
      (_) => print('NotifyNext succeed.'),
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
