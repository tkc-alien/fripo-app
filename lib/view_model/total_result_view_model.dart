import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/domain/entity/turn_info.dart';
import 'package:provider/provider.dart';

class TotalResultViewModel with ChangeNotifier {
  TotalResultViewModel({
    required Map<String, MemberInfo> members,
    required List<TurnInfo> turns,
  })  : _members = members,
        _turns = turns;

  final Map<String, MemberInfo> _members;
  final List<TurnInfo> _turns;

  List<Tuple2<int, MemberInfo>> get membersWithRank {
    return _members.values.map((member) {
      final upperCount =
          _members.values.where((other) => other.life! > member.life!).length;
      return Tuple2(upperCount + 1, member);
    }).toList();
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
  List<TurnInfo> get turns => _turns.toList();
}
