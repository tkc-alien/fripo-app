import 'package:flutter/material.dart';
import 'package:fripo/domain/enum/room_state.dart';
import 'package:fripo/util/ads/ads_util.dart';
import 'package:fripo/view/app_common/provider_initializer.dart';
import 'package:fripo/view/error_notification/error_notification_modal.dart';
import 'package:fripo/view/game/component/current_turn_label.dart';
import 'package:fripo/view/game/component/game_life_cycle_observer.dart';
import 'package:fripo/view/game/component/member_list.dart';
import 'package:fripo/view/game/component/pause_button.dart';
import 'package:fripo/view/total_result/total_result_screen.dart';
import 'package:fripo/view_model/game_view_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'component/game_fragment_container.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key, required this.roomId}) : super(key: key);

  final String roomId;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _ad = AdsUtil.banner;

  double? height;

  @override
  void initState() {
    super.initState();
    _ad.load();
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameViewModel(),
      builder: (context, child) {
        return ProviderInitializer(
          didChangeDependencies: () {
            final vm = GameViewModel.read(context);
            vm.errorMessageController.stream.listen(showError);
            vm.finishEventController.stream.listen(
              (state) => pushToTotalResult(context, state),
            );
          },
          child: GameLifeCycleObserver(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: WillPopScope(
                onWillPop: () => onWillPop(context),
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: SafeArea(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        height ??= constraints.maxHeight;
                        return SingleChildScrollView(
                          child: SizedBox(
                            height: height,
                            child: _buildContent(context),
                          ),
                        );
                      },
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

  /// build???????????????????????????????????????????????????????????????????????????
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              CurrentTurnLabel(),
              VerticalDivider(width: 16),
              Expanded(child: MemberList()),
              VerticalDivider(width: 16),
              PauseButton(),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  height: 250,
                  right: 0,
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset('assets/image/fripo_touch.png'),
                  ),
                ),
                const GameFragmentContainer(),
              ],
            ),
          ),
          SizedBox(
            width: AdsUtil.width.toDouble(),
            height: AdsUtil.height.toDouble(),
            child: AdWidget(ad: _ad),
          ),
        ],
      ),
    );
  }

  Future<bool> onWillPop(BuildContext context) {
    GameViewModel.read(context).exitRoom();
    Navigator.popUntil(context, (route) => route.isFirst);
    return Future.value(false);
  }

  void showError(String error) {
    showDialog(
      context: context,
      builder: (_) => ErrorNotificationModal(message: error),
    );
  }

  void pushToTotalResult(BuildContext context, RoomState state) async {
    // VM????????????
    GameViewModel.read(context).close();

    // State??????
    final error = state.errorMessage;
    if (error == null) {
      //????????????
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TotalResultScreen(),
        ),
      );
    } else {
      // ????????????
      await showDialog(
        context: context,
        builder: (_) => ErrorNotificationModal(
          title: '??????????????????????????????',
          message: error,
          buttonLabel: '????????????????????????',
        ),
        barrierDismissible: false,
      );
      if (!mounted) return;
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }
}
