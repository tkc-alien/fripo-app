import 'package:flutter/material.dart';
import 'package:fripo/view/game/fragment/answering/component/theme_label.dart';
import 'package:fripo/view/game/fragment/marking/component/point_marker.dart';
import 'package:fripo/view/game/fragment/marking/component/send_points_button.dart';
import 'package:fripo/view/game/fragment/marking/component/target_label.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/game_view_model.dart';
import '../../../../view_model/marking_view_model.dart';
import 'component/answer_list.dart';

class MarkingFragment extends StatelessWidget {
  const MarkingFragment({Key? key}) : super(key: key);

  static const turnInfoHeight = 120.0;
  static const sendButtonHeight = 90.0;

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
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: turnInfoHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TargetLabel(),
              ThemeLabel(),
            ],
          ),
        ),
        const Positioned(
          bottom: 0,
          right: 0,
          height: sendButtonHeight,
          child: Align(
            alignment: Alignment.bottomRight,
            child: SendPointsButton(),
          ),
        ),
        const PointMarker(),
      ],
    );
  }

  Widget _buildChildContent(BuildContext context) {
    return Column(
      children: const [
        Expanded(child: AnswerList()),
      ],
    );
  }
}
