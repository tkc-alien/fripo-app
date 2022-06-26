import 'package:flutter/material.dart';
import 'package:fripo/view_model/game_view_model.dart';

class GameLifeCycleObserver extends StatefulWidget {
  const GameLifeCycleObserver({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<GameLifeCycleObserver> createState() => _GameLifeCycleObserverState();
}

class _GameLifeCycleObserverState extends State<GameLifeCycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('LifeCycle did changed: $state');
    switch (state) {
      case AppLifecycleState.resumed:
        GameViewModel.read(context).notifyActive(true);
        break;
      case AppLifecycleState.paused:
        GameViewModel.read(context).notifyActive(false);
        break;
      case AppLifecycleState.detached:
        GameViewModel.read(context).close();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
