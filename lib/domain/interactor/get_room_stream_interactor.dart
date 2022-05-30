import 'package:firebase_database/firebase_database.dart';
import 'package:fripo/domain/entity/room_info.dart';
import 'package:fripo/domain/use_case/get_room_stream_use_case.dart';

class GetRoomStreamInteractor implements GetRoomStreamUseCase {
  @override
  Stream<RoomInfo> call({required String roomId}) {
    return FirebaseDatabase.instance
        .ref('rooms')
        .child(roomId)
        .onValue
        .map(_convertDataToInfo);
  }

  RoomInfo _convertDataToInfo(DatabaseEvent event) {
    final data = event.snapshot.value;
    final map = (data as Map<dynamic, dynamic>);
    return RoomInfo.fromMap(map);
  }
}
