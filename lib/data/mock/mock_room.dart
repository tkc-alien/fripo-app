import 'dart:async';

import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/domain/entity/turn_info.dart';

import '../../domain/entity/room_info.dart';
import '../../domain/enum/room_state.dart';

class MockRoom {
  static const roomId = '00000';
  static const userMemberId = 'mock-member';

  static RoomState state = RoomState.preparing;
  static Map<String, MemberInfo> members = {};
  static Map<String, TurnInfo> turns = {};
  static int currentTurn = 1;

  static var _data = StreamController<RoomInfo>();

  static Stream<RoomInfo> get stream => _data.stream;

  static void newStream() {
    _data.close();
    _data = StreamController<RoomInfo>();
  }

  static void addSink() {
    _data.sink.add(
      RoomInfo(
        state: state,
        members: members,
        turns: turns,
        currentTurn: currentTurn,
      ),
    );
  }
}
