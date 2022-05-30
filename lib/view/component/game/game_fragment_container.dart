import 'package:flutter/cupertino.dart';
import 'package:fripo/view/component/game/answering_fragment.dart';
import 'package:fripo/view/component/game/theme_setting_fragment.dart';
import 'package:fripo/view_model/game_view_model.dart';

import '../../../domain/enum/turn_state.dart';

class GameFragmentContainer extends StatefulWidget {
  const GameFragmentContainer({Key? key}) : super(key: key);

  @override
  State<GameFragmentContainer> createState() => _GameFragmentContainerState();
}

class _GameFragmentContainerState extends State<GameFragmentContainer> {
  @override
  Widget build(BuildContext context) {
    final turnState =
        GameViewModel.select(context, (vm) => vm.currentTurnInfo?.state);

    switch (turnState) {
      case TurnState.themeSetting:
        return const ThemeSettingFragment();
      case TurnState.answering:
        return const AnsweringFragment();
      case TurnState.marking:
        return Container();
      case TurnState.result:
        return Container();
      default:
        return const Center(child: Text('No State'));
    }
  }
}
