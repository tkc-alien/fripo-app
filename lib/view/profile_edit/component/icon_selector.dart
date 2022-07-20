import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/view_model/profile_edit_view_model.dart';

class IconPreview extends StatelessWidget {
  const IconPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUrl = AppData.userInfo?.iconUrl;
    final image = ProfileEditViewModel.select(context, (vm) => vm.iconImage);

    final Widget child;
    if (image != null) {
      child = Image.memory(image);
    } else if (currentUrl?.isNotEmpty == true) {
      child = CachedNetworkImage(
        imageUrl: currentUrl!,
        placeholder: (context, url) => Ink(color: Colors.grey),
      );
    } else {
      child = Container(color: Colors.grey);
    }

    return SizedBox.square(
      dimension: 80,
      child: FittedBox(
        child: ClipOval(child: child),
      ),
    );
  }
}
