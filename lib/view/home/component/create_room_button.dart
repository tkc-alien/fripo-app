import 'package:flutter/material.dart';
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
    final createdRoomId = await HomeViewModel.read(context).createRoom();
    if (!mounted) return;
    if (createdRoomId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WaitingRoomScreen(roomId: createdRoomId),
        ),
      );
    } else {
      print(HomeViewModel.read(context).errorMessage);
    }
  }
}
