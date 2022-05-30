import 'package:flutter/material.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class RoomIdLabel extends StatelessWidget {
  const RoomIdLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'RoomID is ${WaitingRoomViewModel.select(context, (vm) => vm.roomId)}',
    );
  }
}
