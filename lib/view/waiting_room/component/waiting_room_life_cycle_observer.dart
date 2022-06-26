import 'package:flutter/cupertino.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class WaitingRoomLifeCycleObserver extends StatefulWidget {
  const WaitingRoomLifeCycleObserver({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<WaitingRoomLifeCycleObserver> createState() =>
      _WaitingRoomLifeCycleObserverState();
}

class _WaitingRoomLifeCycleObserverState
    extends State<WaitingRoomLifeCycleObserver> with WidgetsBindingObserver {
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
    print('WaitingRoomLifeCycleObserver: state= $state}');
    switch (state) {
      case AppLifecycleState.resumed:
        WaitingRoomViewModel.read(context).notifyActive(true);
        break;
      case AppLifecycleState.paused:
        WaitingRoomViewModel.read(context).notifyActive(false);
        break;
      case AppLifecycleState.detached:
        WaitingRoomViewModel.read(context).close();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
