import 'package:flutter/material.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/create_room_use_case.dart';
import 'package:fripo/domain/use_case/join_room_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel()
      : _createRoomUseCase = sl(),
        _joinRoomUseCase = sl();

  final CreateRoomUseCase _createRoomUseCase;
  final JoinRoomUseCase _joinRoomUseCase;

  String? _errorMessage;

  Future<String?> createRoom() async {
    final res = await _createRoomUseCase.call();
    return res.fold(
      (failure) {
        resolveFailure(failure);
        return null;
      },
      (data) => data,
    );
  }

  Future<String?> joinRoom(String roomId) async {
    final res = await _joinRoomUseCase.call(roomId: roomId);
    return res.fold(
      (failure) {
        resolveFailure(failure);
        return null;
      },
      (_) => roomId,
    );
  }

  void resolveFailure(Failure failure) {
    _errorMessage = failure.message;
    notifyListeners();
  }

  static HomeViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(HomeViewModel vm) select,
  ) {
    return context.select(select);
  }
}

extension Getters on HomeViewModel {
  String? get errorMessage => _errorMessage;
}
