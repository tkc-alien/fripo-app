import 'package:flutter/material.dart';
import 'package:fripo/domain/use_case/send_points_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class MarkingViewModel with ChangeNotifier {
  MarkingViewModel() : _sendPointsUseCase = sl();

  final SendPointsUseCase _sendPointsUseCase;

  final Map<String, int> _points = {};

  bool _isSendingPoints = false;

  void setPoint(String userId, int point) {
    _points[userId] = point;
  }

  Future<void> sendPoints() async {
    if (_isSendingPoints) return;
    _isSendingPoints = true;
    final res = await _sendPointsUseCase.call(points: _points);
    res.fold(
      (failure) => print(failure),
      (_) => print('SendPoints succeed.'),
    );
    _isSendingPoints = false;
  }

  static MarkingViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(MarkingViewModel vm) select,
  ) {
    return context.select(select);
  }
}
