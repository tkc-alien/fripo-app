import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/domain/entity/turn_info.dart';
import 'package:fripo/domain/enum/room_state.dart';

class RoomInfo {
  RoomInfo({
    required this.state,
    required this.members,
    required this.turns,
    required this.maxTurn,
    required this.currentTurn,
    required this.currentTurnId,
    required this.hostUserId,
  });

  factory RoomInfo.fromMap(Map<dynamic, dynamic> map) {
    return RoomInfo(
      state: RoomStateExt.fromInt(map['state']),
      members: (map['members'] as Map<dynamic, dynamic>).map(
        (key, value) => MapEntry(key.toString(), MemberInfo.fromMap(value)),
      ),
      turns: (map['turns'] as Map<dynamic, dynamic>?)?.map(
        (k, v) => MapEntry(k, TurnInfo.fromMap(v)),
      ),
      maxTurn: map['maxTurn'],
      currentTurn: map['currentTurn'],
      currentTurnId: map['currentTurnId'],
      hostUserId: map['hostUserId'],
    );
  }

  final RoomState state;
  final Map<String, MemberInfo> members;
  final Map<String, TurnInfo>? turns;
  final int? maxTurn;
  final int? currentTurn;
  final String? currentTurnId;
  final String hostUserId;
}
