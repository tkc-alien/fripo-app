import 'package:flutter/material.dart';
import 'package:fripo/view/app_common/profile_icon_with_life.dart';
import 'package:fripo/view_model/game_view_model.dart';

class MemberList extends StatelessWidget {
  const MemberList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxLife =
        GameViewModel.select(context, (vm) => vm.roomInfo?.defaultLife);
    final members = GameViewModel.select(context, (vm) => vm.roomInfo?.members);

    if (maxLife == null ||
        members == null ||
        members.values.any((member) => member.life == null)) {
      return const SizedBox();
    }

    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: members.values.map((member) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: FittedBox(
              child: ProfileIconWithLife(
                name: member.name,
                url: member.iconUrl,
                maxLife: maxLife,
                life: member.life!,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
