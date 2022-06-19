import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fripo/view_model/room_id_input_view_model.dart';

class RoomIdField extends StatelessWidget {
  const RoomIdField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: RoomIdInputViewModel.read(context).validateRoomId,
      onSaved: RoomIdInputViewModel.read(context).setRoomId,
    );
  }
}
