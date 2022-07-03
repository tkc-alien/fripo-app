import 'package:flutter/material.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/domain/enum/turn_state.dart';
import 'package:fripo/domain/use_case/get_room_data_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class TotalResultViewModel with ChangeNotifier {
  TotalResultViewModel() : _getRoomDataUseCase = sl() {
    fetch();
  }

  final GetRoomDataUseCase _getRoomDataUseCase;

  List<MemberWithRankData>? _membersWithRank;
  List<TurnLogData>? _turns;

  Future<void> fetch() async {
    final res = await _getRoomDataUseCase.call();
    res.fold(
      (failure) => print(failure),
      (room) {
        // メンバーデータを詰め替え
        final members = room.members.entries;
        _membersWithRank = members.map((member) {
          return MemberWithRankData(
            rank: members
                    .where((other) => other.value.life! > member.value.life!)
                    .length +
                1,
            userId: member.key,
            member: member.value,
          );
        }).toList()
          ..sort((a, b) => a.rank.compareTo(b.rank));

        // ターンデータを詰め替え
        _turns = [];
        final turns = room.turns ?? [];
        for (var turnId = 0; turnId < turns.length; turnId++) {
          final turn = turns[turnId];
          // 整合性チェック
          if (turn.state.errorMessage != null ||
              turn.theme == null ||
              turn.answers == null ||
              turn.answers!.values.any((e) => e.point == null)) continue;

          print('turnId $turnId passed null check.');

          // 回答データを結合して詰め替え
          final answers = <AnswerData>[];
          for (var answer in turn.answers!.entries) {
            final member = room.members[answer.key];
            if (member == null) continue;
            answers.add(AnswerData(
              userName: member.name,
              userIconUrl: member.iconUrl,
              answer: answer.value.answer,
              point: answer.value.point!,
            ));
          }

          // 詰め替え
          _turns?.add(
            TurnLogData(
              turnId: turnId + 1,
              theme: turn.theme!,
              targetPoint: turn.targetPoint,
              answers: answers,
            ),
          );
        }

        // 通知
        notifyListeners();
      },
    );
  }

  static TotalResultViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(TotalResultViewModel vm) select,
  ) {
    return context.select(select);
  }
}

extension Getters on TotalResultViewModel {
  List<MemberWithRankData>? get membersWithRank => _membersWithRank;
  List<TurnLogData>? get turns => _turns;
}

class MemberWithRankData {
  MemberWithRankData({
    required this.rank,
    required this.userId,
    required this.member,
  });

  final String userId;
  final int rank;
  final MemberInfo member;
}

class TurnLogData {
  TurnLogData({
    required this.turnId,
    required this.theme,
    required this.targetPoint,
    required this.answers,
  });

  final int turnId;
  final String theme;
  final int targetPoint;
  final List<AnswerData> answers;
}

class AnswerData {
  AnswerData({
    required this.userName,
    required this.userIconUrl,
    required this.answer,
    required this.point,
  });

  final String userName;
  final String userIconUrl;
  final String answer;
  final int point;
}
