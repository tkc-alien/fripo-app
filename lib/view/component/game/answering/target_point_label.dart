import 'package:flutter/material.dart';

import '../../../../view_model/game_view_model.dart';

class TargetPointLabel extends StatelessWidget {
  const TargetPointLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isParent = GameViewModel.select(context, (vm) => vm.isUserParent);

    String label;

    if (isParent == null) {
      throw Exception();
    } else if (isParent) {
      label = 'Parent cannot see this label.';
    } else {
      label = GameViewModel.select(
        context,
        (vm) => vm.currentTurnInfo?.targetPoint,
      ).toString();
    }

    return Text('TargetPoint: $label');
  }
}
