import 'package:flutter/material.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('Exit'),
    );
  }

  void onPressed(BuildContext context) async {
    WaitingRoomViewModel.read(context).exitRoom();
    Navigator.pop(context);
  }
}
