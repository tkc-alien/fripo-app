import 'package:flutter/material.dart';

class ErrorNotificationModal extends StatelessWidget {
  const ErrorNotificationModal({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'エラーが発生しました',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const Divider(height: 12),
          Text(message),
          const Divider(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ゲームを終了する'),
          ),
        ],
      ),
    );
  }
}
