import 'package:flutter/material.dart';
import 'package:fripo/view_model/image_pick_view_model.dart';
import 'package:provider/provider.dart';

import 'component/image_list.dart';

class ImageCropModal extends StatelessWidget {
  const ImageCropModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImagePickViewModel(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('画像を選択'),
          ),
          body: const ImageList(),
        );
      },
    );
  }
}
