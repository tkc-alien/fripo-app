import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/app_styles.dart';

import 'copy_room_id_button.dart';

class RoomIdLabel extends StatelessWidget {
  const RoomIdLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.borderedContainerDecoration,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'ルームID',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            AppData.roomId,
            style: const TextStyle(
              fontFamily: 'BlackHanSans',
              fontSize: 64,
              letterSpacing: 8,
            ),
          ),
          const CopyRoomIdButton(),
        ],
      ),
    );
  }
}
