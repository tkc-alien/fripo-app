import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageCropModal extends StatelessWidget {
  ImageCropModal(this.asset, {Key? key}) : super(key: key);

  final AssetEntity asset;
  final controller = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('画像を切り抜き'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey,
                padding: const EdgeInsets.all(24),
                child: FutureBuilder<Uint8List?>(
                  future: asset.originBytes,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Crop(
                        controller: controller,
                        image: snapshot.data!,
                        aspectRatio: 1,
                        initialSize: 0.7,
                        withCircleUi: true,
                        onCropped: (image) {
                          Navigator.pop(context, image);
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => onPressed(context),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  void onPressed(BuildContext context) {
    controller.crop();
  }
}
