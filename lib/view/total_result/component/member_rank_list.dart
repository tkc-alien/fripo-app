import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/view/app_common/profile_icon.dart';
import 'package:fripo/view_model/total_result_view_model.dart';

class MemberRankList extends StatelessWidget {
  const MemberRankList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membersWithRank = TotalResultViewModel.select(
      context,
      (vm) => vm.data?.membersWithRank,
    );

    if (membersWithRank == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: membersWithRank
          .map((e) => _MemberRankTile(e.value1, e.value3))
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
    return Card(
      margin: const EdgeInsets.all(6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              (rank + 1).toString(),
              style: const TextStyle(
                fontFamily: 'BlackHanSans',
                fontSize: 32,
              ),
            ),
            const VerticalDivider(width: 12),
            ProfileIcon(url: member.iconUrl),
            const VerticalDivider(width: 8),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: Text(
                  member.name,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const VerticalDivider(width: 8),
            Text(
              member.life.toString(),
              style: TextStyle(
                fontFamily: 'BlackHanSans',
                fontSize: 48,
                color: member.life! > 0 ? AppColors.primary : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
