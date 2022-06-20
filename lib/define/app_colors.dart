import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xffff7d30);

  static const primary50 = Color(0xffffefe6);
  static const primary100 = Color(0xffffd8c1);
  static const primary200 = Color(0xffffbe98);
  static const primary300 = Color(0xffffa46e);
  static const primary400 = Color(0xffff914f);
  static const primary500 = Color(0xffff7d30);
  static const primary600 = Color(0xffff752b);
  static const primary700 = Color(0xffff6a24);
  static const primary800 = Color(0xffff601e);
  static const primary900 = Color(0xffff4d13);

  static const primarySwatch = MaterialColor(0xffff7d30, {
    50: primary50,
    100: primary100,
    200: primary200,
    300: primary300,
    400: primary400,
    500: primary500,
    600: primary600,
    700: primary700,
    800: primary800,
    900: primary900,
  });

  static const secondary = Color(0xffffed03);
  static const onPrimary = Color(0xffffffff);

  static const black = Color(0xff000000);
  static const error = Color(0xffee5555);

  static const profileIconBack = Color(0xff999999);
}
