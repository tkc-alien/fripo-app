import 'package:flutter/material.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/view_model/game_view_model.dart';

class MemberStatusList extends StatelessWidget {
  const MemberStatusList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final members = GameViewModel.select(context, (vm) => vm.members);
    return ListView(
      children: members.map((info) => _MemberStatusTile(info)).toList(),
    );
  }
}

class _MemberStatusTile extends StatelessWidget {
  const _MemberStatusTile(this.info, {Key? key}) : super(key: key);

  final MemberInfo info;

  @override
  Widget build(BuildContext context) {
    final hasAnswer = GameViewModel.select(
      context,
      (vm) => vm.getAnswerByMember(info) != null,
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('userId: ${info.userId}'),
          Text('isActive: ${info.isActive}'),
          Text('hasAnswered: $hasAnswer'),
        ],
      ),
    );
  }
}
