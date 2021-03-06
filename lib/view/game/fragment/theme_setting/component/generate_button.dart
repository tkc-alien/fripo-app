import 'package:flutter/material.dart';
import 'package:fripo/view_model/theme_setting_view_model.dart';

class GenerateButton extends StatelessWidget {
  const GenerateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(context),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 18,
        ),
      ),
      child: const Text('ランダム'),
    );
  }

  void onPressed(BuildContext context) {
    ThemeSettingViewModel.read(context).generateRandomTheme();
  }
}
