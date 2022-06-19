import 'package:flutter/material.dart';
import 'package:fripo/view_model/room_id_input_view_model.dart';

import 'enter_button.dart';
import 'room_id_field.dart';

class RoomIdForm extends StatefulWidget {
  const RoomIdForm({Key? key}) : super(key: key);

  @override
  State<RoomIdForm> createState() => _RoomIdFormState();
}

class _RoomIdFormState extends State<RoomIdForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = RoomIdInputViewModel.read(context);
      vm.validateFunc = _formKey.currentState?.validate;
      vm.saveFunc = _formKey.currentState?.save;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('ルームIDを入力'),
          Divider(height: 8),
          RoomIdField(),
          Divider(height: 8),
          EnterButton(),
        ],
      ),
    );
  }
}
