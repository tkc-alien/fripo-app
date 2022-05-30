import 'package:flutter/material.dart';
import 'package:fripo/view_model/theme_setting_view_model.dart';

class SendButton extends StatelessWidget {
  const SendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('Send theme'),
    );
  }

  void onPressed(BuildContext context) {
    ThemeSettingViewModel.read(context).sendTheme();
  }
}
