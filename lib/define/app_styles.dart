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

  static const defaultButtonPadding = EdgeInsets.symmetric(
    vertical: 16,
    horizontal: 48,
  );

  static const defaultButtonElevation = 0.0;
}

class AppTextStyles {
  AppTextStyles._();

  static const defaultButtonTextStyle = TextStyle(
    fontSize: 20,
  );
}
