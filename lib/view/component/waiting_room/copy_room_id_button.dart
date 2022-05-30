import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class CopyRoomIdButton extends StatelessWidget {
  const CopyRoomIdButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('Copy RoomId'),
    );
  }

  void onPressed(BuildContext context) async {
    final roomId = WaitingRoomViewModel.read(context).roomId;
    await Clipboard.setData(ClipboardData(text: roomId));
  }
}
