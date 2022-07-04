import 'package:flutter/material.dart';
import 'package:fripo/view/pause/component/exit_game_button.dart';
import 'package:fripo/view/pause/component/open_how_to_play_button.dart';

class PauseModal extends StatelessWidget {
  const PauseModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          OpenHowToPlayButton(),
          Divider(height: 12),
          ExitGameButton(),
        ],
      ),
    );
  }
}
