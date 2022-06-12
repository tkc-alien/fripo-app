import 'package:flutter/material.dart';

import '../../profile_edit/profile_edit_screen.dart';

class GoToProfileEditButton extends StatelessWidget {
  const GoToProfileEditButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(context),
      child: const Text("Go to ProfileEdit"),
    );
  }

  void onPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileEditScreen(),
      ),
    );
  }
}
