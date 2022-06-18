import 'package:flutter/material.dart';

import '../../help/help_modal.dart';

class OpenHelpModalButton extends StatelessWidget {
  const OpenHelpModalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(context),
      icon: const Icon(Icons.help_outline),
    );
  }

  void onPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const HelpModal(),
    );
  }
}
