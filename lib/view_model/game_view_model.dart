import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/domain/entity/answer_info.dart';
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

  Map<String, MemberInfo> _members = {};
  TurnInfo? _currentTurnInfo;
  bool _isUserParent = false;

  void _resolveRoomInfo(RoomInfo info) {
    print('GameVM listened RoomInfo update.');
    _members = info.members;
    _currentTurnInfo = info.turns?[info.currentTurn?.toString()];
    _isUserParent = _currentTurnInfo?.parentUserId == AppData.userId;
    notifyListeners();
  }

  AnswerInfo? getAnswerByMember(MemberInfo member) {
    // final answers = _currentTurnInfo?.answers?.values;
    // if (answers == null) return null;
    // final hasAnswer = answers.any((answer) => answer.userId == member.userId);
    // return hasAnswer
    //     ? _currentTurnInfo?.answers?.values.firstWhere(
    //         (answer) => answer.userId == member.userId,
    //       )
    //     : null;
    return null;
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
  List<MemberInfo> get members => _members.values.toList();
  TurnInfo? get currentTurnInfo => _currentTurnInfo;
  bool? get isUserParent => _isUserParent;
}
