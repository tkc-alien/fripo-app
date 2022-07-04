import 'package:flutter/material.dart';
import 'package:fripo/view/game/fragment/common/target_and_theme_label.dart';
import 'package:fripo/view/game/fragment/common/target_point_label.dart';
import 'package:fripo/view/game/fragment/common/theme_label.dart';
import 'package:fripo/view/game/fragment/marking/component/anonymous_answer_list.dart';
import 'package:fripo/view/game/fragment/marking/component/point_marker.dart';
import 'package:fripo/view/game/fragment/marking/component/send_points_button.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/game_view_model.dart';
import '../../../../view_model/marking_view_model.dart';

class MarkingFragment extends StatelessWidget {
  const MarkingFragment({Key? key}) : super(key: key);

  static const topHeight = TargetPointLabel.height +
      ThemeLabel.height +
      TargetAndThemeLabel.dividerHeight +
      TargetAndThemeLabel.bottomPadding;
  static const sendButtonHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MarkingViewModel(),
      builder: (context, child) {
        final isParent = GameViewModel.select(context, (vm) => vm.isUserParent);

        if (isParent == null) {
          throw Exception();
        } else {
          return isParent
              ? _buildParentContent(context)
              : _buildChildContent(context);
        }
      },
    );
  }

  Widget _buildParentContent(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: topHeight,
          child: TargetAndThemeLabel(),
        ),
        Positioned(
          bottom: 8,
          right: 0,
          left: 0,
          height: sendButtonHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Spacer(),
              Expanded(child: SendPointsButton()),
            ],
          ),
        ),
        const PointMarker(),
      ],
    );
  }

  Widget _buildChildContent(BuildContext context) {
    return Column(
      children: const [
        TargetAndThemeLabel(),
        Text('親が点数をつけています...'),
        Divider(),
        Expanded(child: AnonymousAnswerList()),
      ],
    );
  }
}
