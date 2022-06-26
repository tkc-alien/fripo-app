import 'package:firebase_database/firebase_database.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/domain/use_case/cancel_disconnected_event_use_case.dart';

class CancelDisconnectedEventInteractor
    implements CancelDisconnectedEventUseCase {
  @override
  void call() {
    FirebaseDatabase.instance
        .ref('rooms/${AppData.roomId}/members/${AppData.userId}/isActive')
        .onDisconnect()
        .cancel();
  }
}
