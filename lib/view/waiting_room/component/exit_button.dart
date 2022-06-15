import 'package:flutter/material.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(context),
      icon: const Icon(Icons.close),
    );
  }

  void onPressed(BuildContext context) async {
    WaitingRoomViewModel.read(context).exitRoom();
    Navigator.pop(context);
  }
}
