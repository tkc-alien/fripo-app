import 'package:flutter/material.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class StartRoomButton extends StatelessWidget {
  const StartRoomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUserHost =
        WaitingRoomViewModel.select(context, (vm) => vm.isUserHost);

    final Function()? handler;
    final String label;

    if (isUserHost) {
      handler = () => onPressed(context);
      label = 'ゲームスタート';
    } else {
      handler = null;
      label = '待機中...';
    }

    return ElevatedButton(
      onPressed: handler,
      child: Text(label),
    );
  }

  void onPressed(BuildContext context) {
    WaitingRoomViewModel.read(context).startRoom();
  }
}
