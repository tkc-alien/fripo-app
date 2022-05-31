import 'package:flutter/material.dart';
import 'package:fripo/view_model/answering_view_model.dart';

class TimeLimitView extends StatelessWidget {
  const TimeLimitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'TimeLeft: ${AnsweringViewModel.select(context, (vm) => vm.timeLimit)}',
    );
  }
}
