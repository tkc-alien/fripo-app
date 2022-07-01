import 'package:flutter/material.dart';
import 'package:fripo/view_model/result_view_model.dart';

class GoToNextTurnButton extends StatelessWidget {
  const GoToNextTurnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasNotified = ResultViewModel.select(context, (vm) => vm.hasNotified);

    final Function()? handler;
    final String label;

    if (!hasNotified) {
      handler = () => onPressed(context);
      label = '準備完了';
    } else {
      handler = null;
      label = '他のメンバーを待っています';
    }

    return ElevatedButton(
      onPressed: handler,
      child: Text(label),
    );
  }

  void onPressed(BuildContext context) {
    ResultViewModel.read(context).notifyReady();
  }
}
