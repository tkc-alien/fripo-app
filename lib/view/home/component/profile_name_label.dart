import 'package:flutter/material.dart';
import 'package:fripo/view_model/home_view_model.dart';

class ProfileNameLabel extends StatelessWidget {
  const ProfileNameLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      HomeViewModel.select(context, (vm) => vm.user?.name ?? ''),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
