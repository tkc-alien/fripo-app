import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fripo/domain/enum/room_state.dart';
import 'package:fripo/domain/use_case/exit_room_use_case.dart';
import 'package:fripo/domain/use_case/get_room_stream_use_case.dart';
import 'package:fripo/domain/use_case/notify_ready_use_case.dart';
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
        _notifyReadyUseCase = sl() {
    _roomInfoSubscription =
        _getRoomStreamUseCase.call(roomId: roomId).listen(_resolveRoomInfo);
  }

  /// UseCases
  final GetRoomStreamUseCase _getRoomStreamUseCase;
  final ExitRoomUseCase _exitRoomUseCase;
  final NotifyReadyUseCase _notifyReadyUseCase;

  /// 参加中のRoomId
  final String roomId;

  /// 参加中のMemberリスト
  List<MemberInfo> _members = [];

  bool _startFlg = false;

  /// Room情報のSubscription
  StreamSubscription<RoomInfo>? _roomInfoSubscription;

  /// RoomInfoを解決
  void _resolveRoomInfo(RoomInfo info) {
    print('WaitingRoomVM listened roomInfo update.');
    _members = info.members.values.toList();
    _startFlg = info.state != RoomState.preparing;
    notifyListeners();
  }

  Future<void> notifyReady() async {
    final res = await _notifyReadyUseCase.call();
    res.fold(
      (failure) => print(failure),
      (_) => print('notifyReady succeed.'),
    );
  }

  Future<void> exitRoom() async {
    final res = await _exitRoomUseCase.call(roomId: roomId);
    res.fold(
      (failure) => print(failure),
      (_) => print('exitRoom succeed.'),
    );
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
  bool get startFlg => _startFlg;
}
