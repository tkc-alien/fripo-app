import 'package:flutter/cupertino.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/view_model/game_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../domain/enum/turn_state.dart';
import '../fragment/answering/answering_fragment.dart';
import '../fragment/marking/marking_fragment.dart';
import '../fragment/result/result_fragment.dart';
import '../fragment/theme_setting/theme_setting_fragment.dart';

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
        return const MarkingFragment();
      case TurnState.result:
        return const ResultFragment();
      default:
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: AppColors.primary,
            size: 40,
          ),
        );
    }
  }
}
