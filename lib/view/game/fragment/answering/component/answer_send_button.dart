import 'package:flutter/material.dart';
import 'package:fripo/view_model/answering_view_model.dart';

class AnswerSendButton extends StatelessWidget {
  const AnswerSendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final void Function()? handler;
    final String label;
    final canSend = AnsweringViewModel.select(context, (vm) => vm.canSend);
    if (canSend) {
      handler = () => onPressed(context);
      label = '回答を送信する';
    } else {
      handler = null;
      label = '回答済み';
    }

    return ElevatedButton(
      onPressed: handler,
      child: Text(label),
    );
  }

  void onPressed(BuildContext context) {
    AnsweringViewModel.read(context).sendAnswer();
  }
}
