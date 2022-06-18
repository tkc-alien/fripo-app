import 'package:flutter/material.dart';
import 'package:fripo/view_model/theme_setting_view_model.dart';

class ThemeInputField extends StatefulWidget {
  const ThemeInputField({Key? key}) : super(key: key);

  @override
  State<ThemeInputField> createState() => _ThemeInputFieldState();
}

class _ThemeInputFieldState extends State<ThemeInputField> {
  final _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    final vm = ThemeSettingViewModel.read(context);
    vm.setText = setText;
    vm.getText = getText;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      autofocus: false,
    );
  }

  void setText(String text) => _controller.text = text;

  String getText() => _controller.text;
}
