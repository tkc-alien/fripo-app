import 'package:firebase_database/firebase_database.dart';
import 'package:fripo/domain/entity/room_info.dart';
import 'package:fripo/domain/use_case/get_room_stream_use_case.dart';

class GetRoomStreamInteractor implements GetRoomStreamUseCase {
  @override
  Stream<RoomInfo> call({required String roomId}) {
    return FirebaseDatabase.instance.ref('rooms/$roomId').onValue.map((event) {
      print(event.snapshot.value);
      return RoomInfo.fromMap(event.snapshot.value as Map<dynamic, dynamic>);
    });
  }
}
