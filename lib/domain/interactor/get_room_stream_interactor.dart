import 'package:firebase_database/firebase_database.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/domain/entity/room_info.dart';
import 'package:fripo/domain/use_case/get_room_stream_use_case.dart';

class GetRoomStreamInteractor implements GetRoomStreamUseCase {
  @override
  Stream<RoomInfo> call() {
    final database = FirebaseDatabase.instance;
    final roomRef = database.ref('rooms/${AppData.roomId}');
    final activeRef = roomRef.child('members/${AppData.userId}/isActive');

    database.ref('.info/connected').onValue.listen((event) {
      print('connected listen: ${event.snapshot.value}');
      if (event.snapshot.value == false) {
        return;
      }
      activeRef.onDisconnect().set(false).then((_) {
        print('connection false, completed');
        activeRef.set(true);
      });
    });

    return roomRef.onValue.map((event) {
      print(event.snapshot.value);
      return RoomInfo.fromMap(event.snapshot.value as Map<dynamic, dynamic>);
    });
  }
}
