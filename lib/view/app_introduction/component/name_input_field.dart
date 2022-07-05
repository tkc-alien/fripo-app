import 'package:flutter/material.dart';
import 'package:fripo/view_model/app_introduction_view_model.dart';

import '../../../define/app_const.dart';

class NameInputField extends StatefulWidget {
  const NameInputField({Key? key}) : super(key: key);

  @override
  State<NameInputField> createState() => _NameInputFieldState();
}

class _NameInputFieldState extends State<NameInputField> {
  final _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    final vm = AppIntroductionViewModel.read(context);
    vm.getNameText = getText;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: AppConst.userNameMaxLength,
      controller: _controller,
    );
  }

  String getText() => _controller.text;
}
