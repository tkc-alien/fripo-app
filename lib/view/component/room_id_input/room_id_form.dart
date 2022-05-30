import 'package:flutter/material.dart';
import 'package:fripo/view/component/room_id_input/enter_button.dart';
import 'package:fripo/view/component/room_id_input/room_id_field.dart';
import 'package:fripo/view_model/room_id_input_view_model.dart';

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
          RoomIdField(),
          EnterButton(),
        ],
      ),
    );
  }
}
