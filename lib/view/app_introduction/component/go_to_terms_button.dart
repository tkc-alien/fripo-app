import 'package:flutter/material.dart';
import 'package:fripo/view/terms/terms_screen.dart';

class GoToTermsButton extends StatelessWidget {
  const GoToTermsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TermsScreen()),
      ),
      child: const Text('利用規約'),
    );
  }
}
