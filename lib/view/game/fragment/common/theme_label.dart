import 'package:flutter/material.dart';
import 'package:fripo/define/app_styles.dart';
import 'package:fripo/view_model/game_view_model.dart';

class ThemeLabel extends StatelessWidget {
  const ThemeLabel({Key? key}) : super(key: key);

  static const height = 80.0;

  @override
  Widget build(BuildContext context) {
    final theme =
        GameViewModel.select(context, (vm) => vm.currentTurnInfo?.theme);
    if (theme == null) throw Exception();
    return Container(
      height: height,
      decoration: AppStyles.borderedContainerDecoration,
      alignment: Alignment.center,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 24,
            ),
            child: Text(
              theme,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
