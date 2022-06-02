import 'package:flutter/material.dart';
import 'package:fripo/domain/use_case/notify_next_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class ResultViewModel with ChangeNotifier {
  ResultViewModel() : _notifyNextUseCase = sl();

  final NotifyNextUseCase _notifyNextUseCase;

  bool _isRequestingNotifyNext = false;

  Future<void> notifyNext() async {
    if (_isRequestingNotifyNext) return;
    _isRequestingNotifyNext = true;
    final res = await _notifyNextUseCase.call();
    res.fold(
      (failure) => print(failure),
      (_) => print('NotifyNext succeed.'),
    );
    _isRequestingNotifyNext = false;
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
