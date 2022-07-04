import 'package:flutter/material.dart';
import 'package:fripo/view/privacy_policy/privacy_policy_screen.dart';
import 'package:fripo/view/terms/terms_screen.dart';

class HelpModal extends StatelessWidget {
  const HelpModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text('利用規約'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TermsScreen()),
          ),
        ),
        ListTile(
          title: const Text('プライバシーポリシー'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}
