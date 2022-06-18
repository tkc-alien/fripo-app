import 'package:flutter/material.dart';

class ExitConfirmModal extends StatelessWidget {
  const ExitConfirmModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('退出しますか？'),
      content: const Text('ルームから退出し、トップ画面に戻ります。再びこのルームに合流することはできません。'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('ゲームに戻る'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('退出する'),
        ),
      ],
    );
  }
}
