import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    required this.url,
    this.dimension = 48,
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
        placeholder: (context, url) => _placeholder,
        errorWidget: (context, url, error) => _placeholder,
      ),
    );
  }

  Widget get _placeholder => Container(color: AppColors.profileIconBack);
}
