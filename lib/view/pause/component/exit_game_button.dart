import 'package:flutter/material.dart';
import 'package:fripo/define/app_events.dart';

class ExitGameButton extends StatelessWidget {
  const ExitGameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context, PauseEvent.exitGame),
      child: const Text('ゲームをやめる'),
    );
  }
}
