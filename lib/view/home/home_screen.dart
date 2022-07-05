import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fripo/view/app_common/profile_icon.dart';
import 'package:fripo/view/app_common/provider_initializer.dart';
import 'package:fripo/view/home/component/go_to_profile_edit_button.dart';
import 'package:fripo/view/home/component/logo_widget.dart';
import 'package:fripo/view/home/component/open_help_button.dart';
import 'package:fripo/view/home/component/open_how_to_play_button.dart';
import 'package:fripo/view/home/component/profile_name_label.dart';
import 'package:fripo/view_model/home_view_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../util/ads/ads_util.dart';
import 'component/any_label.dart';
import 'component/create_room_button.dart';
import 'component/join_room_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _ad = AdsUtil.banner;

  @override
  void didChangeDependencies() {
    _ad.load();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      builder: (context, child) {
        return ProviderInitializer(
          didChangeDependencies: () {
            final vm = HomeViewModel.read(context);
            vm.errorMessageController.stream.listen(showError);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        ProfileIcon(
                          url: HomeViewModel.select(
                            context,
                            (vm) => vm.user?.iconUrl ?? '',
                          ),
                        ),
                        const VerticalDivider(width: 12),
                        const Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ProfileNameLabel(),
                          ),
                        ),
                        const VerticalDivider(width: 6),
                        const OpenHelpButton(),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: GoToProfileEditButton(),
                    ),
                    const Expanded(flex: 2, child: LogoWidget()),
                    const AnyLabel(),
                    const Divider(height: 16),
                    const Align(child: OpenHowToPlayButton()),
                    const Spacer(),
                    const Align(child: CreateRoomButton()),
                    const Divider(height: 16),
                    const Align(child: JoinRoomButton()),
                    const Spacer(),
                    SizedBox(
                      width: AdsUtil.width.toDouble(),
                      height: AdsUtil.height.toDouble(),
                      child: AdWidget(ad: _ad),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showError(String error) {
    Fluttertoast.showToast(msg: error);
  }
}
