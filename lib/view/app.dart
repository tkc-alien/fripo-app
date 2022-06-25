import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/define/app_styles.dart';

import 'app_introduction/app_introduction_screen.dart';
import 'home/home_screen.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.shouldShowIntroduction,
  }) : super(key: key);

  final bool shouldShowIntroduction;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: shouldShowIntroduction
          ? const AppIntroductionScreen()
          : const HomeScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.primarySwatch,
        ).copyWith(
          onPrimary: AppColors.onPrimary,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: AppStyles.defaultButtonElevation,
            padding: AppStyles.defaultButtonPadding,
            shape: const StadiumBorder(),
            textStyle: AppTextStyles.defaultButtonTextStyle,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            elevation: AppStyles.defaultButtonElevation,
            padding: AppStyles.defaultButtonPadding,
            shape: const StadiumBorder(),
            textStyle: AppTextStyles.defaultButtonTextStyle,
            side: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: AppStyles.defaultInputBorderEnabled,
          focusedBorder: AppStyles.defaultInputBorderFocused,
          errorBorder: AppStyles.defaultInputBorderError,
          focusedErrorBorder: AppStyles.defaultInputBorderError,
        ),
        dividerColor: Colors.transparent,
        dialogTheme: const DialogTheme(
          backgroundColor: AppColors.primary100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            side: AppStyles.standardBorderSide,
          ),
        ),
      ),
    );
  }
}
