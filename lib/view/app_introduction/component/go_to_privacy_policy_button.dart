import 'package:flutter/material.dart';
import 'package:fripo/view/privacy_policy/privacy_policy_screen.dart';

class GoToPrivacyPolicyButton extends StatelessWidget {
  const GoToPrivacyPolicyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
      ),
      child: const Text('プライバシーポリシー'),
    );
  }
}
