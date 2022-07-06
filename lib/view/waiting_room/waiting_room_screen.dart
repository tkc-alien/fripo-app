import 'package:flutter/material.dart';
import 'package:fripo/view/waiting_room/component/waiting_room_life_cycle_observer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../util/ads/ads_util.dart';
import '../../view_model/waiting_room_view_model.dart';
import '../app_common/provider_initializer.dart';
import '../error_notification/error_notification_modal.dart';
import '../game/game_screen.dart';
import 'component/default_life_selector.dart';
import 'component/exit_button.dart';
import 'component/member_list_view.dart';
import 'component/room_id_label.dart';
import 'component/start_room_button.dart';

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({
    Key? key,
    required this.roomId,
  }) : super(key: key);

  final String roomId;

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
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
      create: (_) => WaitingRoomViewModel(),
      builder: (context, child) {
        // return
        return WaitingRoomLifeCycleObserver(
          child: ProviderInitializer(
            didChangeDependencies: () {
              final vm = WaitingRoomViewModel.read(context);
              vm.errorMessageController.stream.listen(showError);
              vm.startFlag.stream.listen((_) => pushToGame(context));
              vm.forceExitFlag.stream.listen(
                (_) => Navigator.popUntil(context, (route) => route.isFirst),
              );
            },
            child: WillPopScope(
              onWillPop: () => onWillPop(context),
              child: Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: ExitButton(),
                        ),
                        const Divider(height: 12),
                        const RoomIdLabel(),
                        const Divider(height: 24),
                        const Align(child: StartRoomButton()),
                        const Divider(height: 16),
                        const DefaultLifeSelector(),
                        const Divider(height: 16),
                        const Expanded(child: MemberListView()),
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
            ),
          ),
        );
      },
    );
  }

  void pushToGame(BuildContext context) {
    WaitingRoomViewModel.read(context).close();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(roomId: widget.roomId),
      ),
    );
  }

  Future<bool> onWillPop(BuildContext context) async {
    final vm = WaitingRoomViewModel.read(context);
    await vm.exitRoom();
    vm.close();
    return true;
  }

  void showError(String error) {
    showDialog(
      context: context,
      builder: (_) => ErrorNotificationModal(message: error),
    );
  }
}
