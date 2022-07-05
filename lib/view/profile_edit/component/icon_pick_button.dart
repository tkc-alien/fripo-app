import 'package:flutter/material.dart';
import 'package:fripo/view_model/profile_edit_view_model.dart';

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
    ProfileEditViewModel.read(context).selectIconImage();
  }
}
