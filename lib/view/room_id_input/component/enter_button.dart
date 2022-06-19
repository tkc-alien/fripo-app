import 'package:flutter/material.dart';
import 'package:fripo/view_model/room_id_input_view_model.dart';

class EnterButton extends StatelessWidget {
  const EnterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('確定する'),
    );
  }

  void onPressed(BuildContext context) {
    final vm = RoomIdInputViewModel.read(context);
    if (vm.validateFunc?.call() == true) {
      vm.saveFunc?.call();
      final roomId = vm.roomId;
      Navigator.pop(context, roomId);
    }
  }
}
