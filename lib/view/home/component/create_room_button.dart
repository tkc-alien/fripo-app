import 'package:flutter/material.dart';
import 'package:fripo/view/loading_indigator/loading_indicator_modal.dart';
import 'package:fripo/view_model/home_view_model.dart';

import '../../waiting_room/waiting_room_screen.dart';

class CreateRoomButton extends StatefulWidget {
  const CreateRoomButton({Key? key}) : super(key: key);

  @override
  State<CreateRoomButton> createState() => _CreateRoomButtonState();
}

class _CreateRoomButtonState extends State<CreateRoomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text("ルーム作成"),
    );
  }

  void onPressed(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => const LoadingIndicatorModal(),
      barrierDismissible: false,
    );
    final createdRoomId = await HomeViewModel.read(context).createRoom();
    if (!mounted) return;
    Navigator.pop(context);
    if (createdRoomId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WaitingRoomScreen(roomId: createdRoomId),
        ),
      );
    }
  }
}
