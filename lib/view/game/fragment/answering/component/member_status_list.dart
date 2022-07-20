import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/view/app_common/profile_icon.dart';
import 'package:fripo/view_model/game_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MemberStatusList extends StatelessWidget {
  const MemberStatusList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final members = GameViewModel.select(
      context,
      (vm) => vm.roomInfo?.members.entries.toList(),
    );
    final parentId = GameViewModel.select(
      context,
      (vm) => vm.currentTurnInfo?.parentUserId,
    );

    if (members == null || parentId == null) return const SizedBox.shrink();

    members.removeWhere((element) => element.key == parentId);

    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: members.map((e) => _MemberStatusTile(e.key, e.value)).toList(),
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

    Widget child;
    if (hasAnswer) {
      child = Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
          boxShadow: [BoxShadow(blurRadius: 1)],
        ),
        child: const Icon(
          Icons.done,
          size: 12,
          color: AppColors.onPrimary,
        ),
      );
    } else {
      child = Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 1)],
        ),
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AppColors.primary,
          size: 12,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: ProfileIcon(url: info.iconUrl),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            width: 20,
            height: 20,
            child: child,
          ),
        ],
      ),
    );
  }
}
