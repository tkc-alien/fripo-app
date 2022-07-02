import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/define/app_styles.dart';
import 'package:fripo/view_model/game_view_model.dart';

class ParentLabel extends StatelessWidget {
  const ParentLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.borderedContainerDecoration,
      padding: const EdgeInsets.all(20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
          ),
          children: [
            const TextSpan(
              text: '親',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 28,
              ),
            ),
            const TextSpan(text: 'は\n'),
            TextSpan(
              text: GameViewModel.select(
                context,
                (vm) => vm.parentMember!.name,
              ),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(text: ' さんです'),
          ],
        ),
      ),
    );
  }
}
