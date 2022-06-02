import 'package:flutter/material.dart';
import 'package:fripo/view/screen/total_result_screen.dart';
import 'package:fripo/view_model/game_view_model.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('Exit Room'),
    );
  }

  void onPressed(BuildContext context) {
    final vm = GameViewModel.read(context);
    vm.exitRoom();
    //Navigator.popUntil(context, (route) => route.isFirst);
    vm.cancelSubscriptions();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TotalResultScreen(
          members: vm.roomInfo!.members,
          turns: vm.roomInfo!.turns!,
        ),
      ),
    );
  }
}
