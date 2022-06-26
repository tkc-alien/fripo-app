import 'package:flutter/material.dart';
import 'package:fripo/define/app_const.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewRequestModal extends StatefulWidget {
  const ReviewRequestModal({Key? key}) : super(key: key);

  @override
  State<ReviewRequestModal> createState() => _ReviewRequestModalState();
}

class _ReviewRequestModalState extends State<ReviewRequestModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(AppConst.reviewRequestText),
          const Divider(height: 16),
          ElevatedButton(
            onPressed: onPositivePressed,
            child: const Text('アンケートに答える'),
          ),
          const Divider(height: 8),
          OutlinedButton(
            onPressed: onNegativePressed,
            child: const Text('後にする'),
          ),
        ],
      ),
    );
  }

  void onPositivePressed() async {
    await launchUrl(Uri.parse(AppConst.googleFormUrl));
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  void onNegativePressed() {
    Navigator.pop(context, false);
  }
}
