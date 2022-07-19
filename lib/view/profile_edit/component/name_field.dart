import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/app_const.dart';
import 'package:fripo/view_model/profile_edit_view_model.dart';

class NameField extends StatefulWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  final controller = TextEditingController(text: AppData.userInfo?.name ?? '');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ProfileEditViewModel.read(context).getName = () => controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: AppConst.userNameMaxLength,
      controller: controller,
      decoration: InputDecoration(
        hintText: AppData.userInfo?.name ?? '',
      ),
    );
  }
}
