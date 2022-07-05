import 'package:flutter/material.dart';

class IconPickButton extends StatelessWidget {
  const IconPickButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => onPressed(context),
      icon: const Icon(Icons.image_outlined),
      label: const Text('画像を選択'),
    );
  }

  void onPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('テストプレイ版ではプロフィール画像の変更ができません。'),
              const Divider(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );

    // ProfileEditViewModel.read(context).selectIconImage();
  }
}
