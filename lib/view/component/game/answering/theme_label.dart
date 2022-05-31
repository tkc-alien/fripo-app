import 'package:flutter/material.dart';
import 'package:fripo/view_model/game_view_model.dart';

class ThemeLabel extends StatelessWidget {
  const ThemeLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme =
        GameViewModel.select(context, (vm) => vm.currentTurnInfo?.theme);
    if (theme == null) return const Text('Theme is not set.');
    return Text('Theme: $theme');
  }
}
