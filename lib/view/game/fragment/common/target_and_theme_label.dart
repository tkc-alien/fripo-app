import 'package:flutter/material.dart';
import 'package:fripo/view/game/fragment/common/target_point_label.dart';
import 'package:fripo/view/game/fragment/common/theme_label.dart';

class TargetAndThemeLabel extends StatelessWidget {
  const TargetAndThemeLabel({
    Key? key,
    this.forceToShowTarget = false,
  }) : super(key: key);

  static const dividerHeight = 8.0;
  static const bottomPadding = 32.0;

  final bool forceToShowTarget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TargetPointLabel(forceShow: forceToShowTarget),
        const Divider(height: dividerHeight),
        const ThemeLabel(),
        const Divider(height: bottomPadding),
      ],
    );
  }
}
