import 'package:flutter/material.dart';

import '../../terms/terms_screen.dart';

class GoToTermsButton extends StatelessWidget {
  const GoToTermsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(context),
      icon: const Icon(Icons.help_outline),
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
