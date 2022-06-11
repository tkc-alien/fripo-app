import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';

class RoomIdLabel extends StatelessWidget {
  const RoomIdLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'RoomID is ${AppData.roomId}',
    );
  }
}
