import 'package:flutter/material.dart';
import 'package:fripo/view_model/game_view_model.dart';
import 'package:provider/provider.dart';

import 'component/exit_button.dart';
import 'component/game_fragment_container.dart';
import 'component/open_help_modal_button.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key, required this.roomId}) : super(key: key);

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameViewModel(),
      builder: (context, child) {
        return WillPopScope(
          onWillPop: () => onWillPop(context),
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
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
                  ],
                ),
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
