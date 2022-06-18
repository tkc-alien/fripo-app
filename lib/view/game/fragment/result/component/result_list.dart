import 'package:flutter/cupertino.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/view_model/game_view_model.dart';

class ResultList extends StatelessWidget {
  const ResultList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final members = GameViewModel.select(context, (vm) => vm.roomInfo!.members);

    return ListView(
      children: members.entries
          .map((entry) => _ResultTile(entry.key, entry.value))
          .toList(),
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile(
    this.userId,
    this.memberInfo, {
    Key? key,
  }) : super(key: key);

  final String userId;
  final MemberInfo memberInfo;

  @override
  Widget build(BuildContext context) {
    final answerInfo = GameViewModel.select(
      context,
      (vm) => vm.currentTurnInfo?.answers?[userId],
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('userId: $userId'),
          Text('name: ${memberInfo.name}'),
          Text('iconUrl: ${memberInfo.iconUrl}'),
          Text('answer: ${answerInfo?.answer ?? 'No Answer'}'),
          Text('point: ${answerInfo?.point ?? '-'}'),
          Text('score: ${answerInfo?.difference ?? '-'}'),
          Text('totalScore: ${memberInfo.life}'),
        ],
      ),
    );
  }
}
