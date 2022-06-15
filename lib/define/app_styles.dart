import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';

class AppStyles {
  AppStyles._();

  static const standardBorderSide = BorderSide(
    color: AppColors.primary,
    width: 6,
  );

  static const borderedContainerDecoration = BoxDecoration(
    color: AppColors.primary50,
    border: Border(
      left: standardBorderSide,
      top: standardBorderSide,
      right: standardBorderSide,
      bottom: standardBorderSide,
    ),
    borderRadius: BorderRadius.all(Radius.circular(48)),
  );
}

class AppTextStyles {
  AppTextStyles._();
}
