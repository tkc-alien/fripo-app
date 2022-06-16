import 'package:flutter/material.dart';
import 'package:fripo/view/game/fragment/answering/component/theme_label.dart';
import 'package:fripo/view/game/fragment/marking/component/target_label.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/game_view_model.dart';
import '../../../../view_model/marking_view_model.dart';
import 'component/answer_list.dart';

class MarkingFragment extends StatelessWidget {
  const MarkingFragment({Key? key}) : super(key: key);

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
    return Column(
      children: const [
        TargetLabel(),
        ThemeLabel(),
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
