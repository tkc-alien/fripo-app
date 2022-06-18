import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fripo/view_model/answering_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/game_view_model.dart';
import '../common/target_point_label.dart';
import '../common/theme_label.dart';
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
        Divider(height: 32),
        Text('今回のお題は...'),
        Divider(height: 16),
        ThemeLabel(),
        Divider(height: 32),
        SizedBox(
          height: 60,
          child: MemberStatusList(),
        ),
        Divider(height: 32),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 32,
          ),
          child: TargetPointLabel(),
        ),
        Expanded(
          child: Center(child: Text('子の回答待ち...')),
        ),
      ],
    );
  }

  Widget _buildChildContent(BuildContext context) {
    return Column(
      children: const [
        ThemeLabel(),
        TargetPointLabel(),
        AnswerInputField(),
        AnswerSendButton(),
        Expanded(child: MemberStatusList()),
      ],
    );
  }
}
