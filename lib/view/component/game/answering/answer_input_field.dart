import 'package:flutter/material.dart';
import 'package:fripo/view_model/answering_view_model.dart';

class AnswerInputField extends StatefulWidget {
  const AnswerInputField({Key? key}) : super(key: key);

  @override
  State<AnswerInputField> createState() => _AnswerInputFieldState();
}

class _AnswerInputFieldState extends State<AnswerInputField> {
  final _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    final vm = AnsweringViewModel.read(context);
    vm.getText = getText;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
    );
  }

  String getText() => _controller.text;
}
