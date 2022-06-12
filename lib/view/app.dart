import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';

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
            elevation: 0,
            padding: const EdgeInsets.all(16),
            shape: const StadiumBorder(),
            textStyle: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
