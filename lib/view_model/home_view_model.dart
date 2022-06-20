import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/create_room_use_case.dart';
import 'package:fripo/domain/use_case/get_user_data_use_case.dart';
import 'package:fripo/domain/use_case/join_room_use_case.dart';
import 'package:provider/provider.dart';

import '../domain/entity/user_info.dart';
import '../injector.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel()
      : _getUserDataUseCase = sl(),
        _createRoomUseCase = sl(),
        _joinRoomUseCase = sl() {
    fetchUserData();
  }

  final GetUserDataUseCase _getUserDataUseCase;
  final CreateRoomUseCase _createRoomUseCase;
  final JoinRoomUseCase _joinRoomUseCase;

  final errorMessageController = StreamController<String>();

  UserInfo? _user;

  Future<void> fetchUserData() async {
    final res = await _getUserDataUseCase.call();
    res.fold(
      (failure) => handleFailure,
      (data) {
        _user = data;
        notifyListeners();
      },
    );
  }

  Future<String?> createRoom() async {
    final res = await _createRoomUseCase.call();
    return res.fold(
      (failure) {
        handleFailure(failure);
        return null;
      },
      (data) => data,
    );
  }

  Future<String?> joinRoom(String roomId) async {
    final res = await _joinRoomUseCase.call(roomId: roomId);
    return res.fold(
      (failure) {
        handleFailure(failure);
        return null;
      },
      (_) => roomId,
    );
  }

  void handleFailure(Failure failure) {
    errorMessageController.sink.add(failure.message);
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
  UserInfo? get user => _user;
}
