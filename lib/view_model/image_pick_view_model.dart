import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class ImagePickViewModel with ChangeNotifier {
  ImagePickViewModel() {
    fetch();
  }

  List<AssetEntity>? _images;

  int _page = 0;
  bool _fetching = false;
  bool _hasMoreData = true;

  Future<void> fetch() async {
    if (_fetching || !_hasMoreData) return;
    _fetching = true;
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final assets = await albums.first.getAssetListPaged(
      page: _page,
      size: 20,
    );
    if (assets.isEmpty) _hasMoreData = false;
    _images = [...?_images, ...assets];
    _page++;
    _fetching = false;
    notifyListeners();
  }

  static ImagePickViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(ImagePickViewModel vm) select,
  ) {
    return context.select(select);
  }
}

extension Getters on ImagePickViewModel {
  List<AssetEntity>? get images => _images;
}
