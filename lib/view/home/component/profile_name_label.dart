import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';

class ProfileNameLabel extends StatelessWidget {
  const ProfileNameLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppData.userName,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
