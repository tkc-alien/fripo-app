import 'package:flutter/material.dart';

class ExitConfirmModal extends StatelessWidget {
  const ExitConfirmModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'ゲームをやめますか？',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const Divider(height: 8),
          const Text(
            'ルームから退出し、トップ画面に戻ります。再びこのルームに合流することはできません。',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const Divider(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('退出する'),
          ),
          const Divider(height: 8),
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('ゲームに戻る'),
          ),
        ],
      ),
    );
  }
}
