import 'package:flutter/material.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class StartRoomButton extends StatefulWidget {
  const StartRoomButton({Key? key}) : super(key: key);

  @override
  State<StartRoomButton> createState() => _StartRoomButtonState();
}

class _StartRoomButtonState extends State<StartRoomButton> {
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

  void onPressed(BuildContext context) async {
    await WaitingRoomViewModel.read(context).startRoom();
  }
}
