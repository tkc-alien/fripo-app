import 'package:flutter/material.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/view_model/game_view_model.dart';

class MemberStatusList extends StatelessWidget {
  const MemberStatusList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final members = GameViewModel.select(context, (vm) => vm.roomInfo!.members);
    return ListView(
      children: members.entries
          .map((e) => _MemberStatusTile(e.key, e.value))
          .toList(),
    );
  }
}

class _MemberStatusTile extends StatelessWidget {
  const _MemberStatusTile(
    this.userId,
    this.info, {
    Key? key,
  }) : super(key: key);

  final String userId;
  final MemberInfo info;

  @override
  Widget build(BuildContext context) {
    final hasAnswer = GameViewModel.select(
      context,
      (vm) => vm.currentTurnInfo?.answers?[userId] != null,
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('name: ${info.name}'),
          Text('isActive: ${info.isActive}'),
          Text('hasAnswered: $hasAnswer'),
        ],
      ),
    );
  }
}
