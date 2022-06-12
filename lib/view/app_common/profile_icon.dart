import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    required this.url,
    this.dimension = 60,
    Key? key,
  }) : super(key: key);

  final String url;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: dimension,
        height: dimension,
        fit: BoxFit.contain,
      ),
    );
  }
}
