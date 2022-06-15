import 'package:flutter/material.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class StartRoomButton extends StatelessWidget {
  const StartRoomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('ゲームスタート'),
    );
  }

  void onPressed(BuildContext context) {
    WaitingRoomViewModel.read(context).startRoom();
  }
}
