import 'package:flutter/material.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/view/app_common/profile_icon.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class MemberListView extends StatelessWidget {
  const MemberListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final members = WaitingRoomViewModel.select(context, (vm) => vm.members);
    return ListView(
      children: members.map((info) => _MemberTile(info)).toList(),
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile(this.info, {Key? key}) : super(key: key);

  final MemberInfo info;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileIcon(url: info.iconUrl),
      title: Text(info.name),
    );
  }
}
