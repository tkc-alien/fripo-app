import 'package:flutter/material.dart';
import 'package:fripo/view_model/game_view_model.dart';
import 'package:fripo/view_model/result_view_model.dart';

class GoToNextTurnButton extends StatelessWidget {
  const GoToNextTurnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUserParent = GameViewModel.select(context, (vm) => vm.isUserParent);
    if (isUserParent == null) throw Exception();

    final Function()? handler;
    final String label;

    if (isUserParent) {
      handler = () => onPressed(context);
      label = '次のターンを始める';
    } else {
      handler = null;
      label = '親を待っています...';
    }

    return ElevatedButton(
      onPressed: handler,
      child: Text(label),
    );
  }

  void onPressed(BuildContext context) {
    ResultViewModel.read(context).endTurn();
  }
}
