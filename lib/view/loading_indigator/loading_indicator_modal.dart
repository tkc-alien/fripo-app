import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingIndicatorModal extends StatelessWidget {
  const LoadingIndicatorModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 80,
        width: 80,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        child: FittedBox(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: AppColors.primary,
            size: 40,
          ),
        ),
      ),
    );
  }
}
