import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';

import '../../../../view_model/game_view_model.dart';

class TargetPointLabel extends StatelessWidget {
  const TargetPointLabel({Key? key, this.forceShow = false}) : super(key: key);

  static const height = 60.0;

  final bool forceShow;

  @override
  Widget build(BuildContext context) {
    final isParent = GameViewModel.select(context, (vm) => vm.isUserParent);

    String label;

    if (isParent == null) {
      throw Exception();
    } else if (forceShow || !isParent) {
      label = GameViewModel.select(
        context,
        (vm) => vm.currentTurnInfo?.targetPoint,
      ).toString();
    } else {
      label = '??';
    }

    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            '目指すマッチ度',
            style: TextStyle(fontSize: 18),
          ),
          const VerticalDivider(width: 16),
          Center(
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.asset('assets/image/bubble.png'),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  right: 8,
                  bottom: 8,
                  child: FittedBox(
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
