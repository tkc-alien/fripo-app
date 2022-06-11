import 'package:flutter/material.dart';
import 'package:fripo/view/component/game/exit_button.dart';
import 'package:fripo/view/component/game/game_fragment_container.dart';
import 'package:fripo/view/component/game/open_help_modal_button.dart';
import 'package:fripo/view_model/game_view_model.dart';
import 'package:provider/provider.dart';

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
            appBar: AppBar(
              title: const Text('Game'),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    ExitButton(),
                    OpenHelpModalButton(),
                    Expanded(child: GameFragmentContainer()),
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
