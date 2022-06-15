import 'package:flutter/material.dart';
import 'package:fripo/view/waiting_room/component/turn_count_selector.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';
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
  @override
  void didChangeDependencies() {
    //AdsUtil.loadBannerAd();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //AdsUtil.disposeBanner();
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
                  children: const [
                    Align(
                      alignment: Alignment.topLeft,
                      child: ExitButton(),
                    ),
                    Divider(height: 12),
                    RoomIdLabel(),
                    Divider(height: 24),
                    StartRoomButton(),
                    Divider(height: 16),
                    TurnCountSelector(),
                    Divider(height: 16),
                    Expanded(child: MemberListView()),
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
