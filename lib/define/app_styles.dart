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
    vertical: 12,
    horizontal: 48,
  );

  static const defaultButtonElevation = 0.0;

  static const defaultInputBorderRadius = BorderRadius.zero;

  static const defaultInputBorderEnabled = OutlineInputBorder(
    borderRadius: defaultInputBorderRadius,
    borderSide: BorderSide(
      color: AppColors.black,
    ),
  );

  static const defaultInputBorderFocused = OutlineInputBorder(
    borderRadius: defaultInputBorderRadius,
    borderSide: BorderSide(
      color: AppColors.primary,
    ),
  );

  static const defaultInputBorderError = OutlineInputBorder(
    borderRadius: defaultInputBorderRadius,
    borderSide: BorderSide(
      color: AppColors.error,
    ),
  );
}

class AppTextStyles {
  AppTextStyles._();

  static const defaultButtonTextStyle = TextStyle(
    fontSize: 16,
  );
}
