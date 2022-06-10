import 'package:flutter/material.dart';
import 'package:fripo/view/component/waiting_room/copy_room_id_button.dart';
import 'package:fripo/view/component/waiting_room/exit_button.dart';
import 'package:fripo/view/component/waiting_room/member_list_view.dart';
import 'package:fripo/view/component/waiting_room/room_id_label.dart';
import 'package:fripo/view/component/waiting_room/start_room_button.dart';
import 'package:fripo/view/screen/game_screen.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';
import 'package:provider/provider.dart';

class WaitingRoomScreen extends StatelessWidget {
  const WaitingRoomScreen({
    Key? key,
    required this.roomId,
  }) : super(key: key);

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WaitingRoomViewModel(roomId: roomId),
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
            appBar: AppBar(
              title: const Text("WaitingScreen"),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const RoomIdLabel(),
                    const CopyRoomIdButton(),
                    const Expanded(child: MemberListView()),
                    const ExitButton(),
                    if (WaitingRoomViewModel.select(
                        context, (vm) => vm.isUserHost))
                      const StartRoomButton(),
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
        builder: (_) => GameScreen(roomId: roomId),
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
