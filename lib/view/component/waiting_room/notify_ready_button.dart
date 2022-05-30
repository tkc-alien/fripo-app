import 'package:flutter/material.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class NotifyReadyButton extends StatelessWidget {
  const NotifyReadyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('Notify Ready'),
    );
  }

  void onPressed(BuildContext context) {
    WaitingRoomViewModel.read(context).notifyReady();
  }
}
