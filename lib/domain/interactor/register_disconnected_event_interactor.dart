import 'package:firebase_database/firebase_database.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/domain/use_case/register_disconnected_event_use_case.dart';

class RegisterDisconnectedEventInteractor
    implements RegisterDisconnectedEventUseCase {
  @override
  void call() {
    final ref = FirebaseDatabase.instance
        .ref('rooms/${AppData.roomId}/members/${AppData.userId}/isActive');
    ref.onDisconnect().set(false).then((value) {
      ref.set(true);
    });
  }
}
