import 'package:flutter/material.dart';
import 'package:fripo/view_model/room_id_input_view_model.dart';
import 'package:provider/provider.dart';

import '../component/room_id_input/room_id_form.dart';

class RoomIdInputModal extends StatelessWidget {
  const RoomIdInputModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoomIdInputViewModel(),
      builder: (context, child) {
        return const AlertDialog(
          content: RoomIdForm(),
        );
      },
    );
  }
}
