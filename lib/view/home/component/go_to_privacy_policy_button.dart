import 'package:flutter/material.dart';

import '../../privacy_policy/privacy_policy_screen.dart';

class GoToPrivacyPolicyButton extends StatelessWidget {
  const GoToPrivacyPolicyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text("Go to PrivacyPolicy"),
    );
  }

  void onPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PrivacyPolicyScreen(),
      ),
    );
  }
}
