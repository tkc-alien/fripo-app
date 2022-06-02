import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/domain/entity/room_info.dart';
import 'package:fripo/domain/entity/turn_info.dart';
import 'package:fripo/domain/use_case/exit_room_use_case.dart';
import 'package:fripo/domain/use_case/get_room_stream_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class GameViewModel with ChangeNotifier {
  GameViewModel({
    required this.roomId,
  })  : _getRoomStreamUseCase = sl(),
        _exitRoomUseCase = sl() {
    _roomInfoSubscription =
        _getRoomStreamUseCase.call(roomId: roomId).listen(_resolveRoomInfo);
  }

  /// UseCases
  final GetRoomStreamUseCase _getRoomStreamUseCase;
  final ExitRoomUseCase _exitRoomUseCase;

  final String roomId;

  StreamSubscription<RoomInfo>? _roomInfoSubscription;

  RoomInfo? _roomInfo;
  bool _isUserParent = false;

  void _resolveRoomInfo(RoomInfo info) {
    print('GameVM listened RoomInfo update.');
    _roomInfo = info;
    _isUserParent = currentTurnInfo?.parentUserId == AppData.userId;
    notifyListeners();
  }

  TurnInfo? get currentTurnInfo {
    return _roomInfo?.turns?[_roomInfo!.currentTurn!];
  }

  Future<void> exitRoom() async {
    final res = await _exitRoomUseCase.call(roomId: roomId);
    res.fold(
      (failure) => print(failure),
      (_) => print('Exit Room succeed.'),
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
