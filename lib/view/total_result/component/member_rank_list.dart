import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/view/app_common/profile_icon.dart';
import 'package:fripo/view_model/total_result_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MemberRankList extends StatelessWidget {
  const MemberRankList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membersWithRank = TotalResultViewModel.select(
      context,
      (vm) => vm.membersWithRank,
    );

    final turns = TotalResultViewModel.select(context, (vm) => vm.turns);

    if (membersWithRank == null || turns == null) {
      return Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AppColors.primary,
          size: 40,
        ),
      );
    }

    return ListView(
      children: [
        ...membersWithRank
            .map((e) => _MemberRankTile(e.rank, e.member))
            .toList(),
        ...turns.map((e) => TurnLogTile(e)).toList(),
      ],
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
              rank.toString(),
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

class TurnLogTile extends StatelessWidget {
  const TurnLogTile(this.data, {Key? key}) : super(key: key);

  final TurnLogData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 32, color: Colors.black),
        Text(
          'TURN ${data.turnId}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                data.theme,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const VerticalDivider(width: 12),
            Text(
              data.targetPoint.toString(),
              style: const TextStyle(
                fontFamily: 'BlackHanSans',
                fontSize: 48,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        for (var answer in data.answers)
          Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              children: [
                ProfileIcon(url: answer.userIconUrl),
                const VerticalDivider(width: 12),
                Expanded(
                  child: Text(answer.answer),
                ),
                const VerticalDivider(width: 12),
                SizedBox(
                  width: 64,
                  child: Text(
                    answer.point.toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontFamily: 'BlackHanSans',
                      fontSize: 32,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
