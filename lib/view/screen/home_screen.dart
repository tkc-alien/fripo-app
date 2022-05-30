import 'package:flutter/material.dart';
import 'package:fripo/view/component/home/create_room_button.dart';
import 'package:fripo/view/component/home/join_room_button.dart';
import 'package:fripo/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../component/home/go_to_help_button.dart';
import '../component/home/go_to_privacy_policy_button.dart';
import '../component/home/go_to_profile_edit_button.dart';
import '../component/home/go_to_terms_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                CreateRoomButton(),
                JoinRoomButton(),
                Divider(),
                GoToProfileEditButton(),
                GoToPrivacyPolicyButton(),
                GoToTermsButton(),
                GoToHelpButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
