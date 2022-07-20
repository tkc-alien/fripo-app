import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fripo/view/image_crop/image_crop_modal.dart';
import 'package:fripo/view_model/image_pick_view_model.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageList extends StatefulWidget {
  const ImageList({Key? key}) : super(key: key);

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 80) {
        ImagePickViewModel.read(context).fetch();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ImagePickViewModel.select(context, (vm) => vm.images);

    if (data == null) return const Center(child: CircularProgressIndicator());

    return GridView.builder(
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        crossAxisCount: 3,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final asset = data[index];
        return FutureBuilder<Uint8List?>(
          future: asset.thumbnailDataWithSize(
            const ThumbnailSize.square(200),
          ),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (data != null) {
              return GestureDetector(
                onTap: () => onTap(context, asset),
                child: Image.memory(
                  data,
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }

  void onTap(BuildContext context, AssetEntity asset) async {
    final cropped = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImageCropModal(asset),
      ),
    );
    if (cropped == null || !mounted) return;
    Navigator.pop(context, cropped);
  }
}
