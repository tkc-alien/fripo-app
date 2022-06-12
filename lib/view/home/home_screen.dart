import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/view/app_common/profile_icon.dart';
import 'package:fripo/view/home/component/go_to_profile_edit_button.dart';
import 'package:fripo/view/home/component/join_room_button.dart';
import 'package:fripo/view/home/component/logo_widget.dart';
import 'package:fripo/view/home/component/profile_name_label.dart';
import 'package:fripo/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import 'component/any_label.dart';
import 'component/create_room_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      ProfileIcon(url: AppData.userIconUrl),
                      const Expanded(child: ProfileNameLabel()),
                      const GoToProfileEditButton(),
                    ],
                  ),
                  const Expanded(flex: 2, child: LogoWidget()),
                  const AnyLabel(),
                  const Spacer(),
                  _wrapHorizontalSpace(const CreateRoomButton()),
                  const Divider(
                    color: Colors.transparent,
                    height: 16,
                  ),
                  _wrapHorizontalSpace(const JoinRoomButton()),
                  const Spacer(),
                  // CreateRoomButton(),
                  // JoinRoomButton(),
                  // Divider(),
                  // GoToProfileEditButton(),
                  // GoToPrivacyPolicyButton(),
                  // GoToTermsButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _wrapHorizontalSpace(Widget widget) {
    return Row(
      children: [
        const Spacer(),
        Expanded(flex: 3, child: widget),
        const Spacer(),
      ],
    );
  }
}
