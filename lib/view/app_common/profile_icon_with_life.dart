import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/view/app_common/profile_icon.dart';

class ProfileIconWithLife extends StatelessWidget {
  const ProfileIconWithLife({
    Key? key,
    required this.url,
    required this.name,
    required this.maxLife,
    required this.life,
  }) : super(key: key);

  final String url;
  final String name;
  final int maxLife;
  final int life;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: CircularProgressIndicator(
              value: (life / maxLife),
              strokeWidth: 3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Tooltip(
            richMessage: WidgetSpan(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(name),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      Text(
                        life.toString(),
                        style: const TextStyle(
                          fontFamily: 'BlackHanSans',
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            decoration: const BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(width: 2, color: AppColors.primary),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            triggerMode: TooltipTriggerMode.tap,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: ProfileIcon(url: url),
          ),
        ),
      ],
    );
  }
}
