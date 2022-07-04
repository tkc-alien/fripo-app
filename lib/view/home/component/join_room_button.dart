import 'package:flutter/material.dart';
import 'package:fripo/view_model/home_view_model.dart';

import '../../loading_indigator/loading_indicator_modal.dart';
import '../../room_id_input/room_id_input_modal.dart';
import '../../waiting_room/waiting_room_screen.dart';

class JoinRoomButton extends StatefulWidget {
  const JoinRoomButton({Key? key}) : super(key: key);

  @override
  State<JoinRoomButton> createState() => _JoinRoomButtonState();
}

class _JoinRoomButtonState extends State<JoinRoomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('ルーム参加'),
    );
  }

  void onPressed(BuildContext context) async {
    final roomId = await showDialog<String>(
      context: context,
      builder: (_) => const RoomIdInputModal(),
    );
    if (!mounted || roomId == null) return;
    showDialog(
      context: context,
      builder: (_) => const LoadingIndicatorModal(),
      barrierDismissible: false,
    );
    final joinedRoomId = await HomeViewModel.read(context).joinRoom(roomId);
    if (!mounted) return;
    Navigator.pop(context);
    if (joinedRoomId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WaitingRoomScreen(roomId: joinedRoomId),
        ),
      );
    }
  }
}
