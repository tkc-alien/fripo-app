import 'package:flutter/cupertino.dart';
import 'package:fripo/define/app_styles.dart';
import 'package:fripo/view_model/game_view_model.dart';

class ThemeLabel extends StatelessWidget {
  const ThemeLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.borderedContainerDecoration,
      child: Text(
        GameViewModel.select(context, (vm) => vm.currentTurnInfo?.theme) ??
            'None',
      ),
    );
  }
}
