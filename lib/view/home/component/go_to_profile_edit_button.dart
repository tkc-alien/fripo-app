import 'package:flutter/material.dart';
import 'package:fripo/view_model/home_view_model.dart';

import '../../profile_edit/profile_edit_screen.dart';

class GoToProfileEditButton extends StatefulWidget {
  const GoToProfileEditButton({Key? key}) : super(key: key);

  @override
  State<GoToProfileEditButton> createState() => _GoToProfileEditButtonState();
}

class _GoToProfileEditButtonState extends State<GoToProfileEditButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(context),
      child: const Text("プロフィール編集"),
    );
  }

  void onPressed(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileEditScreen(),
      ),
    );
    if (!mounted) return;
    HomeViewModel.read(context).fetchUserData();
  }
}
