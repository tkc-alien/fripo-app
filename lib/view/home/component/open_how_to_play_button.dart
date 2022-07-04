import 'package:flutter/material.dart';
import 'package:fripo/view/how_to_play/how_to_play_modal.dart';

class OpenHowToPlayButton extends StatelessWidget {
  const OpenHowToPlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(context),
      child: const Text('遊び方'),
    );
  }

  void onPressed(BuildContext context) {
    showDialog(context: context, builder: (_) => const HowToPlayModal());
  }
}
