import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fripo/view/game/fragment/common/target_and_theme_label.dart';
import 'package:fripo/view_model/answering_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/game_view_model.dart';
import 'component/answer_input_field.dart';
import 'component/answer_send_button.dart';
import 'component/member_status_list.dart';

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TargetAndThemeLabel(),
        SizedBox(
          height: 100,
          child: MemberStatusList(),
        ),
        Divider(height: 32),
        Expanded(
          child: Center(child: Text('子の回答待ち...')),
        ),
      ],
    );
  }

  Widget _buildChildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TargetAndThemeLabel(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: AnswerInputField(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Align(child: AnswerSendButton()),
        ),
      ],
    );
  }
}
