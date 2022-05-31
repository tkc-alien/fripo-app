import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/domain/enum/room_state.dart';
import 'package:fripo/domain/use_case/exit_room_use_case.dart';
import 'package:fripo/domain/use_case/get_room_stream_use_case.dart';
import 'package:fripo/domain/use_case/start_room_use_case.dart';
import 'package:provider/provider.dart';

import '../domain/entity/member_info.dart';
import '../domain/entity/room_info.dart';
import '../injector.dart';

class WaitingRoomViewModel with ChangeNotifier {
  /// Constructor
  WaitingRoomViewModel({
    required this.roomId,
  })  : _getRoomStreamUseCase = sl(),
        _exitRoomUseCase = sl(),
        _startRoomUseCase = sl() {
    _roomInfoSubscription =
        _getRoomStreamUseCase.call(roomId: roomId).listen(_resolveRoomInfo);
  }

  /// UseCases
  final GetRoomStreamUseCase _getRoomStreamUseCase;
  final ExitRoomUseCase _exitRoomUseCase;
  final StartRoomUseCase _startRoomUseCase;

  /// 参加中のRoomId
  final String roomId;

  /// 参加中のMemberリスト
  List<MemberInfo> _members = [];
  bool _isUserHost = false;
  bool _startFlg = false;
  bool _isRequestingExitRoom = false;
  bool _isRequestingStartRoom = false;

  /// Room情報のSubscription
  StreamSubscription<RoomInfo>? _roomInfoSubscription;

  /// RoomInfoを解決
  void _resolveRoomInfo(RoomInfo info) {
    print('WaitingRoomVM listened roomInfo update.');
    _members = info.members.values.toList();
    _isUserHost = info.hostUserId == AppData.userId;
    _startFlg = info.state != RoomState.preparing;
    notifyListeners();
  }

  Future<void> exitRoom() async {
    if (_isRequestingExitRoom) return;
    _isRequestingExitRoom = true;
    final res = await _exitRoomUseCase.call(roomId: roomId);
    res.fold(
      (failure) => print(failure),
      (_) => print('exitRoom succeed.'),
    );
    _isRequestingExitRoom = false;
  }

  Future<void> startRoom() async {
    if (_isRequestingStartRoom) return;
    _isRequestingStartRoom = true;
    final res = await _startRoomUseCase.call(roomId: roomId);
    res.fold(
      (failure) => print(failure),
      (_) => print('startRoom succeed.'),
    );
    _isRequestingStartRoom = false;
  }

  void cancelSubscriptions() {
    _roomInfoSubscription?.cancel();
  }

  @override
  void dispose() {
    cancelSubscriptions();
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
  bool get startFlg => _startFlg;
}
