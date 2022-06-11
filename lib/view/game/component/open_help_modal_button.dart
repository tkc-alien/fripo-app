import 'package:flutter/material.dart';

import '../../help/help_modal.dart';

class OpenHelpModalButton extends StatelessWidget {
  const OpenHelpModalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('Open HelpModal'),
    );
  }

  void onPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const HelpModal(),
    );
  }
}
