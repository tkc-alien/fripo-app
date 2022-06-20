import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/domain/entity/room_info.dart';
import 'package:fripo/domain/entity/turn_info.dart';
import 'package:fripo/domain/enum/room_state.dart';
import 'package:fripo/domain/use_case/exit_room_use_case.dart';
import 'package:fripo/domain/use_case/get_room_stream_use_case.dart';
import 'package:provider/provider.dart';

import '../domain/entity/member_info.dart';
import '../domain/error/failure.dart';
import '../injector.dart';

class GameViewModel with ChangeNotifier {
  GameViewModel()
      : _getRoomStreamUseCase = sl(),
        _exitRoomUseCase = sl() {
    _roomInfoSubscription =
        _getRoomStreamUseCase.call().listen(_resolveRoomInfo);
  }

  /// UseCases
  final GetRoomStreamUseCase _getRoomStreamUseCase;
  final ExitRoomUseCase _exitRoomUseCase;

  final errorMessageController = StreamController<String>();
  final finishEventController = StreamController<bool>();

  StreamSubscription<RoomInfo>? _roomInfoSubscription;

  RoomInfo? _roomInfo;
  bool _isUserParent = false;

  void _resolveRoomInfo(RoomInfo info) {
    _roomInfo = info;
    _isUserParent = currentTurnInfo?.parentUserId == AppData.userId;
    if (info.state != RoomState.onGame) {
      finishEventController.sink.add(true);
    }
    notifyListeners();
  }

  TurnInfo? get currentTurnInfo {
    return _roomInfo?.turns?[_roomInfo!.currentTurn! - 1];
  }

  MemberInfo? get parentMember {
    return _roomInfo?.members[currentTurnInfo?.parentUserId];
  }

  Future<void> exitRoom() async {
    final res = await _exitRoomUseCase.call();
    res.fold(
      (failure) => handleFailure,
      (_) => {},
    );
  }

  void cancelSubscriptions() {
    _roomInfoSubscription?.cancel();
  }

  void closeStreams() {
    errorMessageController.close();
    finishEventController.close();
  }

  void handleFailure(Failure failure) {
    errorMessageController.sink.add(failure.message);
  }

  @override
  void dispose() {
    cancelSubscriptions();
    closeStreams();
    super.dispose();
  }

  static GameViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(GameViewModel vm) select,
  ) {
    return context.select(select);
  }
}

extension Getters on GameViewModel {
  RoomInfo? get roomInfo => _roomInfo;
  bool? get isUserParent => _isUserParent;
}
