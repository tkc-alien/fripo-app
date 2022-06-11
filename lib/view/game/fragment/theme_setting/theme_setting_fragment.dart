import 'package:flutter/cupertino.dart';
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
      children: const [
        ThemeInputField(),
        GenerateButton(),
        ThemeSendButton(),
      ],
    );
  }

  Widget _buildChildContent(BuildContext context) {
    return const Center(
      child: Text('Theme Setting'),
    );
  }
}
