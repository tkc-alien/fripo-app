import '../entity/room_info.dart';

abstract class GetRoomStreamUseCase {
  Stream<RoomInfo> call({required String roomId});
}
