import 'package:flutter/material.dart';
import 'package:fripo/view_model/profile_edit_view_model.dart';

import '../../loading_indicator/loading_indicator_modal.dart';

class UpdateProfileButton extends StatefulWidget {
  const UpdateProfileButton({Key? key}) : super(key: key);

  @override
  State<UpdateProfileButton> createState() => _UpdateProfileButtonState();
}

class _UpdateProfileButtonState extends State<UpdateProfileButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('変更を保存する'),
    );
  }

  void onPressed(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => const LoadingIndicatorModal(),
      barrierDismissible: false,
    );
    await ProfileEditViewModel.read(context).updateProfile();
    if (!mounted) return;
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
