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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                '親にはナイショの',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
              Text(
                '目標点数',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
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
                  left: 2,
                  top: 4,
                  right: 2,
                  bottom: 2,
                  child: FittedBox(
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontFamily: 'BlackHanSans',
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
