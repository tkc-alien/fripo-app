import 'package:flutter/material.dart';
import 'package:fripo/util/ads/ads_util.dart';
import 'package:fripo/view/waiting_room/component/default_life_selector.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../game/game_screen.dart';
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
        // ゲーム開始フラグをSelectして画面遷移
        if (WaitingRoomViewModel.select(context, (vm) => vm.startFlg)) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => pushToGame(context),
          );
        }
        return WillPopScope(
          onWillPop: () => onWillPop(context),
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: ExitButton(),
                    ),
                    const Divider(height: 12),
                    const RoomIdLabel(),
                    const Divider(height: 24),
                    const StartRoomButton(),
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
        );
      },
    );
  }

  void pushToGame(BuildContext context) {
    WaitingRoomViewModel.read(context).cancelSubscriptions();
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
    vm.cancelSubscriptions();
    return true;
  }
}
