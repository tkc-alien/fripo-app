import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/domain/enum/room_state.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/cancel_disconnected_event_use_case.dart';
import 'package:fripo/domain/use_case/cancel_join_room_use_case.dart';
import 'package:fripo/domain/use_case/get_connection_stream_use_case.dart';
import 'package:fripo/domain/use_case/get_room_stream_use_case.dart';
import 'package:fripo/domain/use_case/notify_active_use_case.dart';
import 'package:fripo/domain/use_case/register_disconnected_event_use_case.dart';
import 'package:fripo/domain/use_case/start_room_use_case.dart';
import 'package:fripo/domain/use_case/update_default_life_use_case.dart';
import 'package:provider/provider.dart';

import '../domain/entity/member_info.dart';
import '../domain/entity/room_info.dart';
import '../injector.dart';

class WaitingRoomViewModel with ChangeNotifier {
  /// Constructor
  WaitingRoomViewModel()
      : _getRoomStreamUseCase = sl(),
        _getConnectionStreamUseCase = sl(),
        _registerDisconnectedEventUseCase = sl(),
        _cancelDisconnectedEventUseCase = sl(),
        _notifyActiveUseCase = sl(),
        _updateDefaultLifeUseCase = sl(),
        _cancelJoinRoomUseCase = sl(),
        _startRoomUseCase = sl() {
    _registerDisconnectedEventUseCase.call();
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
  final UpdateDefaultLifeUseCase _updateDefaultLifeUseCase;
  final CancelJoinRoomUseCase _cancelJoinRoomUseCase;
  final StartRoomUseCase _startRoomUseCase;

  /// エラーメッセージ
  final errorMessageController = StreamController<String>();
  final defaultLifeController = StreamController<int>();
  final startFlag = StreamController<bool>();
  final forceExitFlag = StreamController<bool>();

  /// 参加中のMemberリスト
  List<MemberInfo> _members = [];
  bool _isUserHost = false;
  bool _isRequestingExitRoom = false;
  bool _isRequestingStartRoom = false;

  /// Room情報のSubscription
  StreamSubscription<RoomInfo>? _roomInfoSubscription;
  StreamSubscription<bool>? _connectionSubscription;

  int _defaultLife = 100;

  /// RoomInfoを解決
  void _resolveRoomInfo(RoomInfo info) {
    print('WaitingRoomVM listened roomInfo update.');
    _members = info.members.values.toList();
    _isUserHost = info.hostUserId == AppData.userId;
    defaultLifeController.sink.add(info.defaultLife ?? 100);
    if (info.state == RoomState.onGame) {
      startFlag.sink.add(true);
    } else if (info.state.errorMessage != null) {
      forceExitFlag.sink.add(true);
      errorMessageController.sink.add(info.state.errorMessage!);
    }
    notifyListeners();
  }

  void _listenConnection(bool connection) {
    if (connection == false) {
      return;
    }
    _registerDisconnectedEventUseCase.call();
  }

  Future<void> updateDefaultLife(int value) async {
    _updateDefaultLifeUseCase.call(defaultLife: value);
    _defaultLife = value;
    notifyListeners();
  }

  Future<void> exitRoom() async {
    if (_isRequestingExitRoom) return;
    _isRequestingExitRoom = true;
    final res = await _cancelJoinRoomUseCase.call();
    res.fold(
      (failure) => _handleFailure(failure),
      (_) => print('exitRoom succeed.'),
    );
    _isRequestingExitRoom = false;
  }

  Future<void> startRoom() async {
    if (_isRequestingStartRoom) return;
    _isRequestingStartRoom = true;
    final res = await _startRoomUseCase.call(defaultLife: _defaultLife);
    res.fold(
      (failure) => _handleFailure(failure),
      (_) => print('startRoom succeed.'),
    );
    _isRequestingStartRoom = false;
  }

  Future<void> notifyActive(bool isActive) async {
    _notifyActiveUseCase.call(isActive: isActive);
  }

  void _handleFailure(Failure failure) {
    print(failure);
    errorMessageController.sink.add(failure.message);
  }

  void close() {
    _cancelDisconnectedEventUseCase.call();

    _roomInfoSubscription?.cancel();
    _connectionSubscription?.cancel();

    errorMessageController.close();
    defaultLifeController.close();
    startFlag.close();
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }

  static WaitingRoomViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(WaitingRoomViewModel vm) select,
  ) {
    return context.select(select);
  }
}

extension Getters on WaitingRoomViewModel {
  List<MemberInfo> get members => _members;
  bool get isUserHost => _isUserHost;
  int get defaultLife => _defaultLife;
}
