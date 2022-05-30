import 'package:flutter/material.dart';
import 'package:fripo/view/screen/terms_screen.dart';

class GoToTermsButton extends StatelessWidget {
  const GoToTermsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text("Go to Terms"),
    );
  }

  void onPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TermsScreen(),
      ),
    );
  }
}
