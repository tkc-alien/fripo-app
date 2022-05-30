import 'package:fripo/domain/enum/turn_state.dart';

import 'answer_info.dart';

class TurnInfo {
  TurnInfo({
    required this.parentUserId,
    required this.theme,
    required this.targetPoint,
    required this.state,
    required this.answers,
  });

  factory TurnInfo.fromMap(Map<dynamic, dynamic> map) {
    return TurnInfo(
      parentUserId: map['parentUserId'],
      theme: map['theme'],
      targetPoint: map['targetPoint'],
      state: TurnStateExt.fromInt(map['state']),
      answers: (map['answers'] as Map<dynamic, dynamic>?)?.map(
        (key, value) => MapEntry(key.toString(), AnswerInfo.fromMap(value)),
      ),
    );
  }

  TurnInfo copyWith({
    String? parentUserId,
    String? theme,
    int? targetPoint,
    TurnState? state,
    Map<String, AnswerInfo>? answers,
  }) {
    return TurnInfo(
      parentUserId: parentUserId ?? this.parentUserId,
      theme: theme ?? this.theme,
      targetPoint: targetPoint ?? this.targetPoint,
      state: state ?? this.state,
      answers: answers ?? this.answers,
    );
  }

  final String parentUserId;
  final String? theme;
  final int targetPoint;
  final TurnState state;
  final Map<String, AnswerInfo>? answers;
}
