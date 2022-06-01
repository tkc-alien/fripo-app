import 'package:flutter/material.dart';
import 'package:fripo/view/screen/app_introduction_screen.dart';
import 'package:fripo/view/screen/home_screen.dart';

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
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
    );
  }
}
