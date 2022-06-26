import 'package:flutter/material.dart';
import 'package:fripo/define/app_events.dart';
import 'package:fripo/view/pause/pause_modal.dart';

import '../../../view_model/game_view_model.dart';
import '../../exit_confirm/exit_confirm_modal.dart';

class PauseButton extends StatefulWidget {
  const PauseButton({Key? key}) : super(key: key);

  @override
  State<PauseButton> createState() => _PauseButtonState();
}

class _PauseButtonState extends State<PauseButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(context),
      icon: const Icon(Icons.settings),
    );
  }

  void onPressed(BuildContext context) async {
    final event = await showDialog<PauseEvent>(
      context: context,
      builder: (_) => const PauseModal(),
    );
    if (!mounted) return;
    switch (event) {
      case PauseEvent.exitGame:
        exitGame(context);
        break;
      case null:
        break;
    }
  }

  void exitGame(BuildContext context) async {
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
