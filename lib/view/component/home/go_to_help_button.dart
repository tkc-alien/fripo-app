import 'package:flutter/material.dart';
import 'package:fripo/view/screen/help_screen.dart';

class GoToHelpButton extends StatelessWidget {
  const GoToHelpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text("Go to Help"),
    );
  }

  void onPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const HelpScreen(),
      ),
    );
  }
}
