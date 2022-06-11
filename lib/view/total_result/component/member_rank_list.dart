import 'package:flutter/material.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/view_model/total_result_view_model.dart';

class MemberRankList extends StatelessWidget {
  const MemberRankList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membersWithRank = TotalResultViewModel.select(
      context,
      (vm) => vm.membersWithRank,
    );

    return ListView(
      children: membersWithRank
          .map((e) => _MemberRankTile(e.value1, e.value2))
          .toList(),
    );
  }
}

class _MemberRankTile extends StatelessWidget {
  const _MemberRankTile(
    this.rank,
    this.member, {
    Key? key,
  }) : super(key: key);

  final int rank;
  final MemberInfo member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('rank: $rank'),
          Text('name: ${member.name}'),
          Text('iconUrl: ${member.iconUrl}'),
          Text('totalScore: ${member.totalScore}'),
        ],
      ),
    );
  }
}
