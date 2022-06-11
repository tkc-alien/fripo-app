import 'package:flutter/material.dart';
import 'package:fripo/view_model/answering_view_model.dart';

class AnswerSendButton extends StatelessWidget {
  const AnswerSendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('Send Answer'),
    );
  }

  void onPressed(BuildContext context) {
    AnsweringViewModel.read(context).sendAnswer();
  }
}
