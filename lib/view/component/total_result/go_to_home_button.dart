import 'package:flutter/material.dart';

class GoToHomeButton extends StatelessWidget {
  const GoToHomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('Go to Home'),
    );
  }

  void onPressed(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
