import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/app_colors.dart';

class CopyRoomIdButton extends StatelessWidget {
  const CopyRoomIdButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ElevatedButton.styleFrom(
        primary: AppColors.onPrimary,
        onPrimary: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        textStyle: const TextStyle(
          fontSize: 12,
        ),
      ),
      child: const Text('IDをコピー'),
    );
  }

  void onPressed(BuildContext context) async {
    final roomId = AppData.roomId;
    await Clipboard.setData(ClipboardData(text: roomId));
  }
}
