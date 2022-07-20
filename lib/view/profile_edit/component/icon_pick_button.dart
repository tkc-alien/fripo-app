import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../view_model/profile_edit_view_model.dart';
import '../../image_pick/image_pick_modal.dart';

class IconPickButton extends StatefulWidget {
  const IconPickButton({Key? key}) : super(key: key);

  @override
  State<IconPickButton> createState() => _IconPickButtonState();
}

class _IconPickButtonState extends State<IconPickButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => onPressed(context),
      icon: const Icon(Icons.image_outlined),
      label: const Text('画像を選択'),
    );
  }

  void onPressed(BuildContext context) async {
    final picked = await Navigator.push<Uint8List>(
      context,
      MaterialPageRoute(
        builder: (_) => const ImageCropModal(),
        fullscreenDialog: true,
      ),
    );

    if (picked == null || !mounted) return;

    ProfileEditViewModel.read(context).setIconImage(picked);
  }
}
