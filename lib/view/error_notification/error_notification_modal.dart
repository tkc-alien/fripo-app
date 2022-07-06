import 'package:flutter/material.dart';

class ErrorNotificationModal extends StatelessWidget {
  const ErrorNotificationModal({
    Key? key,
    this.title,
    required this.message,
    this.buttonLabel = 'OK',
  }) : super(key: key);

  final String? title;
  final String message;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Text(
              title!,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          if (title != null) const Divider(height: 12),
          Text(message),
          const Divider(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}
