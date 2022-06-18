import 'package:flutter/material.dart';
import 'package:fripo/view/exit_confirm/exit_confirm_modal.dart';
import 'package:fripo/view_model/game_view_model.dart';

class ExitButton extends StatefulWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  State<ExitButton> createState() => _ExitButtonState();
}

class _ExitButtonState extends State<ExitButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(context),
      icon: const Icon(Icons.logout),
    );
  }

  void onPressed(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ExitConfirmModal(),
    );
    if (!mounted || confirmed != true) return;
    final vm = GameViewModel.read(context);
    vm.exitRoom();
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
