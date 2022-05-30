import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/domain/entity/member_info.dart';
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

  Map<String, MemberInfo>? _members;
  int? _currentTurn;
  TurnInfo? _currentTurnInfo;
  bool _isUserParent = false;

  void _resolveRoomInfo(RoomInfo info) {
    print('GameVM listened RoomInfo update.');
    _members = info.members;
    _currentTurn = info.currentTurn;
    _currentTurnInfo = info.turns?[info.currentTurn?.toString()];
    _isUserParent = _currentTurnInfo?.parentUserId ==
        MockRoom.userMemberId; // TODO 一時的にハードコーデイング　parentUserIdの仕様が曖昧なので要相談
    notifyListeners();
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
  List<MemberInfo>? get members => _members?.values.toList();
  TurnInfo? get currentTurnInfo => _currentTurnInfo;
  bool? get isUserParent => _isUserParent;
}
