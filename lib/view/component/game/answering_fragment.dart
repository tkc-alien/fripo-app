import 'package:flutter/cupertino.dart';
import 'package:fripo/view/component/game/answering/member_status_list.dart';
import 'package:fripo/view/component/game/answering/target_point_label.dart';
import 'package:fripo/view/component/game/answering/theme_label.dart';
import 'package:fripo/view/component/game/answering/time_limit_view.dart';
import 'package:fripo/view_model/answering_view_model.dart';
import 'package:provider/provider.dart';

import '../../../view_model/game_view_model.dart';
import 'answering/answer_input_field.dart';
import 'answering/answer_send_button.dart';

class AnsweringFragment extends StatelessWidget {
  const AnsweringFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AnsweringViewModel(),
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
        ThemeLabel(),
        TargetPointLabel(),
        TimeLimitView(),
        Expanded(child: MemberStatusList()),
      ],
    );
  }

  Widget _buildChildContent(BuildContext context) {
    return Column(
      children: const [
        ThemeLabel(),
        TargetPointLabel(),
        TimeLimitView(),
        AnswerInputField(),
        AnswerSendButton(),
        Expanded(child: MemberStatusList()),
      ],
    );
  }
}
