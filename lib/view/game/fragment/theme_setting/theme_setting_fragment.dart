import 'package:flutter/material.dart';
import 'package:fripo/view/game/fragment/theme_setting/component/example_label.dart';
import 'package:fripo/view/game/fragment/theme_setting/component/role_label.dart';
import 'package:fripo/view_model/game_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/theme_setting_view_model.dart';
import 'component/generate_button.dart';
import 'component/theme_input_field.dart';
import 'component/theme_send_button.dart';

class ThemeSettingFragment extends StatelessWidget {
  const ThemeSettingFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeSettingViewModel(),
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
      children: [
        const Padding(
          padding: EdgeInsets.all(32),
          child: RoleLabel(),
        ),
        const Text('お題を決めよう'),
        const Padding(
          padding: EdgeInsets.all(24),
          child: ThemeInputField(),
        ),
        Row(
          children: const [
            Expanded(
              flex: 1,
              child: GenerateButton(),
            ),
            VerticalDivider(width: 16),
            Expanded(
              flex: 2,
              child: ThemeSendButton(),
            ),
          ],
        ),
        const Spacer(),
        const ExampleLabel(),
      ],
    );
  }

  Widget _buildChildContent(BuildContext context) {
    return const Center(
      child: Text('Theme Setting'),
    );
  }
}
