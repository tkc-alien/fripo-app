import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fripo/view/app_common/profile_icon.dart';

class ProfileIconWithLife extends StatelessWidget {
  const ProfileIconWithLife({
    Key? key,
    required this.url,
    required this.maxLife,
    required this.life,
  }) : super(key: key);

  final String url;
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
            message: life.toString(),
            child: ProfileIcon(url: url),
          ),
        ),
      ],
    );
  }
}
