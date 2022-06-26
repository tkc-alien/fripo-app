import 'package:flutter/material.dart';
import 'package:fripo/view/review_request/review_request_modal.dart';

class GoToHomeButton extends StatefulWidget {
  const GoToHomeButton({Key? key}) : super(key: key);

  @override
  State<GoToHomeButton> createState() => _GoToHomeButtonState();
}

class _GoToHomeButtonState extends State<GoToHomeButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('Go to Home'),
    );
  }

  void onPressed(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => const ReviewRequestModal(),
    );
    if (!mounted) return;
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
