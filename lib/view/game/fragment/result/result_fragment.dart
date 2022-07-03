import 'package:flutter/material.dart';
import 'package:fripo/view/game/fragment/common/target_and_theme_label.dart';
import 'package:fripo/view_model/result_view_model.dart';
import 'package:provider/provider.dart';

import 'component/go_to_next_turn_button.dart';
import 'component/result_list.dart';

class ResultFragment extends StatelessWidget {
  const ResultFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResultViewModel(),
      builder: (context, child) {
        return Column(
          children: const [
            TargetAndThemeLabel(forceToShowTarget: true),
            Expanded(child: ResultList()),
            Divider(height: 8),
            GoToNextTurnButton(),
            Divider(height: 8),
          ],
        );
      },
    );
  }
}
