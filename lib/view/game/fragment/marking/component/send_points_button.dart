import 'package:flutter/material.dart';
import 'package:fripo/view_model/marking_view_model.dart';

class SendPointsButton extends StatelessWidget {
  const SendPointsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('確定する'),
    );
  }

  void onPressed(BuildContext context) {
    MarkingViewModel.read(context).sendPoints();
  }
}
