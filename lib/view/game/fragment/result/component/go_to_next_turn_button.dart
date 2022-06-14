import 'package:flutter/material.dart';
import 'package:fripo/view_model/result_view_model.dart';

class GoToNextTurnButton extends StatelessWidget {
  const GoToNextTurnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('Go to NextTurn'),
    );
  }

  void onPressed(BuildContext context) {
    ResultViewModel.read(context).endTurn();
  }
}
