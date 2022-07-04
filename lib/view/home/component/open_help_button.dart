import 'package:flutter/material.dart';
import 'package:fripo/view/help/help_modal.dart';

class OpenHelpButton extends StatelessWidget {
  const OpenHelpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(context),
      icon: const Icon(Icons.help_outline),
    );
  }

  void onPressed(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => const HelpModal());
  }
}
