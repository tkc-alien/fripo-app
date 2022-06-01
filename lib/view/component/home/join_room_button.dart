import 'package:flutter/material.dart';
import 'package:fripo/view/modal/room_id_input_modal.dart';
import 'package:fripo/view/screen/waiting_room_screen.dart';
import 'package:fripo/view_model/home_view_model.dart';

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
      child: const Text('Join Room'),
    );
  }

  void onPressed(BuildContext context) async {
    final roomId = await showDialog<String>(
      context: context,
      builder: (_) => const RoomIdInputModal(),
    );
    if (!mounted || roomId == null) return;
    final joinedRoomId = await HomeViewModel.read(context).joinRoom(roomId);
    if (!mounted) return;
    if (joinedRoomId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WaitingRoomScreen(roomId: joinedRoomId),
        ),
      );
    } else {
      print(HomeViewModel.read(context).errorMessage);
    }
  }
}