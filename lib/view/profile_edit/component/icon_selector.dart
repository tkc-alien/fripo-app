import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/view_model/profile_edit_view_model.dart';

class IconPreview extends StatelessWidget {
  const IconPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final file = ProfileEditViewModel.select(context, (vm) => vm.iconFile);

    final ImageProvider<Object> provider;
    if (file != null) {
      provider = FileImage(file);
    } else {
      provider = CachedNetworkImageProvider(AppData.userInfo?.iconUrl ?? '');
    }

    return SizedBox.square(
      dimension: 80,
      child: FittedBox(
        child: ClipOval(
          child: Image(
            image: provider,
          ),
        ),
      ),
    );
  }
}
