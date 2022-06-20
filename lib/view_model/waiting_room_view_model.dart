import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/domain/enum/room_state.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/exit_room_use_case.dart';
import 'package:fripo/domain/use_case/get_room_stream_use_case.dart';
import 'package:fripo/domain/use_case/start_room_use_case.dart';
import 'package:provider/provider.dart';

import '../domain/entity/member_info.dart';
import '../domain/entity/room_info.dart';
import '../injector.dart';

class WaitingRoomViewModel with ChangeNotifier {
  /// Constructor
  WaitingRoomViewModel()
      : _getRoomStreamUseCase = sl(),
        _exitRoomUseCase = sl(),
        _startRoomUseCase = sl() {
    _roomInfoSubscription =
        _getRoomStreamUseCase.call().listen(_resolveRoomInfo);
  }

  /// UseCases
  final GetRoomStreamUseCase _getRoomStreamUseCase;
  final ExitRoomUseCase _exitRoomUseCase;
  final StartRoomUseCase _startRoomUseCase;

  /// エラーメッセージ
  final errorMessageController = StreamController<String>();
  final startFlag = StreamController<bool>();

  /// 参加中のMemberリスト
  List<MemberInfo> _members = [];
  bool _isUserHost = false;
  bool _isRequestingExitRoom = false;
  bool _isRequestingStartRoom = false;

  /// Room情報のSubscription
  StreamSubscription<RoomInfo>? _roomInfoSubscription;

  int _defaultLife = 100;

  /// RoomInfoを解決
  void _resolveRoomInfo(RoomInfo info) {
    print('WaitingRoomVM listened roomInfo update.');
    _members = info.members.values.toList();
    _isUserHost = info.hostUserId == AppData.userId;
    if (info.state != RoomState.preparing) {
      startFlag.sink.add(true);
    }
    notifyListeners();
  }

  Future<void> exitRoom() async {
    if (_isRequestingExitRoom) return;
    _isRequestingExitRoom = true;
    final res = await _exitRoomUseCase.call();
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

  void setDefaultLife(int value) {
    _defaultLife = value;
  }

  void cancelSubscriptions() {
    _roomInfoSubscription?.cancel();
  }

  void closeStreams() {
    errorMessageController.close();
    startFlag.close();
  }

  void _handleFailure(Failure failure) {
    print(failure);
    errorMessageController.sink.add(failure.message);
  }

  @override
  void dispose() {
    cancelSubscriptions();
    closeStreams();
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
