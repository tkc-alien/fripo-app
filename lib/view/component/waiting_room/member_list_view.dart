import 'package:flutter/cupertino.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class MemberListView extends StatelessWidget {
  const MemberListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final members = WaitingRoomViewModel.select(context, (vm) => vm.members);
    return ListView(
      children: members.map((e) => _MemberTile(e)).toList(),
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile(this.info, {Key? key}) : super(key: key);

  final MemberInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('userId: ${info.userId}'),
          Text('name: ${info.name}'),
          Text('iconUrl: ${info.iconUrl}'),
          Text('isActive: ${info.isActive}'),
          Text('isReady: ${info.isReady}'),
        ],
      ),
    );
  }
}
