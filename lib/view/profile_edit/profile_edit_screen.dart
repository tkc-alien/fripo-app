import 'package:flutter/material.dart';
import 'package:fripo/view/profile_edit/component/update_profile_button.dart';
import 'package:fripo/view_model/profile_edit_view_model.dart';
import 'package:provider/provider.dart';

import 'component/icon_pick_button.dart';
import 'component/icon_selector.dart';
import 'component/name_field.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileEditViewModel(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("プロフィール編集"),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  IconPreview(),
                  IconPickButton(),
                  NameField(),
                  UpdateProfileButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
