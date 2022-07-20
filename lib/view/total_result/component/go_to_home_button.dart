import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';

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
      child: const Text('ホーム画面へ'),
    );
  }

  void onPressed(BuildContext context) async {
    await AppReview.requestReview;
    if (!mounted) return;
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
