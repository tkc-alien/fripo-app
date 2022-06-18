import 'package:flutter/material.dart';
import 'package:fripo/util/ads/ads_util.dart';
import 'package:fripo/view_model/game_view_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'component/exit_button.dart';
import 'component/game_fragment_container.dart';
import 'component/open_help_modal_button.dart';

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
      create: (_) => GameViewModel(),
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: WillPopScope(
            onWillPop: () => onWillPop(context),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: LayoutBuilder(builder: (context, constraints) {
                  height ??= constraints.maxHeight;
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: height,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                ExitButton(),
                                OpenHelpModalButton(),
                              ],
                            ),
                            const Expanded(child: GameFragmentContainer()),
                            SizedBox(
                              width: AdsUtil.width.toDouble(),
                              height: AdsUtil.height.toDouble(),
                              child: AdWidget(ad: _ad),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> onWillPop(BuildContext context) {
    GameViewModel.read(context).exitRoom();
    Navigator.popUntil(context, (route) => route.isFirst);
    return Future.value(false);
  }
}
