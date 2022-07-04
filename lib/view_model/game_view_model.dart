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
import '../domain/use_case/cancel_disconnected_event_use_case.dart';
import '../domain/use_case/get_connection_stream_use_case.dart';
import '../domain/use_case/notify_active_use_case.dart';
import '../domain/use_case/register_disconnected_event_use_case.dart';
import '../injector.dart';

class GameViewModel with ChangeNotifier {
  GameViewModel()
      : _getRoomStreamUseCase = sl(),
        _getConnectionStreamUseCase = sl(),
        _registerDisconnectedEventUseCase = sl(),
        _cancelDisconnectedEventUseCase = sl(),
        _notifyActiveUseCase = sl(),
        _exitRoomUseCase = sl() {
    _roomInfoSubscription =
        _getRoomStreamUseCase.call().listen(_resolveRoomInfo);
    _connectionSubscription =
        _getConnectionStreamUseCase.call().listen(_listenConnection);
  }

  /// UseCases
  final GetRoomStreamUseCase _getRoomStreamUseCase;
  final GetConnectionStreamUseCase _getConnectionStreamUseCase;
  final RegisterDisconnectedEventUseCase _registerDisconnectedEventUseCase;
  final CancelDisconnectedEventUseCase _cancelDisconnectedEventUseCase;
  final NotifyActiveUseCase _notifyActiveUseCase;
  final ExitRoomUseCase _exitRoomUseCase;

  final errorMessageController = StreamController<String>();
  final finishEventController = StreamController<RoomState>();

  StreamSubscription<RoomInfo>? _roomInfoSubscription;
  StreamSubscription<bool>? _connectionSubscription;

  RoomInfo? _roomInfo;
  bool _isUserParent = false;

  MemberInfo? getMember(String userId) => _roomInfo?.members[userId];

  void _resolveRoomInfo(RoomInfo info) {
    _roomInfo = info;
    _isUserParent = currentTurnInfo?.parentUserId == AppData.userId;
    if (info.state != RoomState.onGame) {
      finishEventController.sink.add(info.state);
    }
    notifyListeners();
  }

  void _listenConnection(bool connection) {
    if (!connection) {
      return;
    }
    _registerDisconnectedEventUseCase.call();
  }

  TurnInfo? get currentTurnInfo {
    return _roomInfo?.turns?[_roomInfo!.currentTurn! - 1];
  }

  MemberInfo? get parentMember {
    return _roomInfo?.members[currentTurnInfo?.parentUserId];
  }

  Future<void> notifyActive(bool isActive) async {
    _notifyActiveUseCase.call(isActive: isActive);
  }

  Future<void> exitRoom() async {
    final res = await _exitRoomUseCase.call();
    res.fold(
      (failure) => handleFailure,
      (_) => {},
    );
  }

  void handleFailure(Failure failure) {
    errorMessageController.sink.add(failure.message);
  }

  void close() {
    _cancelDisconnectedEventUseCase.call();

    _roomInfoSubscription?.cancel();
    _connectionSubscription?.cancel();

    errorMessageController.close();
    finishEventController.close();
  }

  @override
  void dispose() {
    close();
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
