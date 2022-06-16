import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/view/test_screen.dart';

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
      // home: shouldShowIntroduction
      //     ? const AppIntroductionScreen()
      //     : const HomeScreen(),
      home: const TestScreen(),
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
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 48,
            ),
            shape: const StadiumBorder(),
            textStyle: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        dividerColor: Colors.transparent,
      ),
    );
  }
}
