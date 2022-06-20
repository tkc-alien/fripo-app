import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/domain/entity/turn_info.dart';
import 'package:fripo/domain/use_case/get_room_data_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class TotalResultViewModel with ChangeNotifier {
  TotalResultViewModel() : _getRoomDataUseCase = sl() {
    fetch();
  }

  final GetRoomDataUseCase _getRoomDataUseCase;

  TotalResultData? _data;

  Future<void> fetch() async {
    final res = await _getRoomDataUseCase.call();
    res.fold(
      (failure) => print(failure),
      (room) {
        final members = room.members.entries;
        final membersWithRank = members.map((member) {
          return Tuple3(
            members
                .where((other) => other.value.life! > member.value.life!)
                .length,
            member.key,
            member.value,
          );
        }).toList();
        final turns = room.turns ?? [];
        _data = TotalResultData(
          membersWithRank: membersWithRank,
          turns: turns,
        );
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
  TotalResultData? get data => _data;
}

class TotalResultData {
  TotalResultData({
    required this.membersWithRank,
    required this.turns,
  });

  final List<Tuple3<int, String, MemberInfo>> membersWithRank;
  final List<TurnInfo> turns;
}
