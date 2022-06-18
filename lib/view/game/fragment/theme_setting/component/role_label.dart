import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/view_model/game_view_model.dart';

const _leftWeight = 0.5;
const _rightWeight = 0.25;
const _coverWeight = 0.05;

class RoleLabel extends StatelessWidget {
  const RoleLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final role = GameViewModel.select(context, (vm) => vm.isUserParent ?? false)
        ? '親'
        : '子';
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        width: width,
        height: 60,
        child: Stack(
          children: [
            Positioned(
              left: width * (_leftWeight - _coverWeight),
              right: width * (_rightWeight - _coverWeight),
              top: 0,
              bottom: 0,
              child: Container(
                color: AppColors.secondary,
              ),
            ),
            Positioned(
              left: width * (_leftWeight - _coverWeight),
              right: width * (_rightWeight - _coverWeight),
              top: 0,
              bottom: 0,
              child: FittedBox(
                child: Text(
                  role,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: width * _leftWeight,
              child: const FittedBox(child: Text('あなたは')),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: width * _rightWeight,
              child: const FittedBox(child: Text('です')),
            ),
          ],
        ),
      );
    });
  }
}
