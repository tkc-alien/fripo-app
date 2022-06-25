import 'package:flutter/material.dart';
import 'package:fripo/view_model/game_view_model.dart';

class CurrentTurnLabel extends StatelessWidget {
  const CurrentTurnLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('TURN'),
        Text(
          GameViewModel.select(
            context,
            (vm) => vm.roomInfo?.currentTurn?.toString() ?? '',
          ),
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
      ],
    );
  }
}
