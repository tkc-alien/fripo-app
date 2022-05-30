import 'package:flutter/cupertino.dart';
import 'package:fripo/view/component/game/theme_setting/generate_button.dart';
import 'package:fripo/view/component/game/theme_setting/send_button.dart';
import 'package:fripo/view/component/game/theme_setting/theme_input_field.dart';
import 'package:fripo/view_model/game_view_model.dart';
import 'package:provider/provider.dart';

import '../../../view_model/theme_setting_view_model.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          ThemeInputField(),
          GenerateButton(),
          SendButton(),
        ],
      ),
    );
  }

  Widget _buildChildContent(BuildContext context) {
    return const Center(
      child: Text('Theme Setting'),
    );
  }
}
