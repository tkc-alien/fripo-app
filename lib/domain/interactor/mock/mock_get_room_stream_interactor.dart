import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/domain/use_case/get_room_stream_use_case.dart';

import '../../entity/room_info.dart';

class MockGetRoomStreamInteractor implements GetRoomStreamUseCase {
  @override
  Stream<RoomInfo> call({required String roomId}) {
    MockRoom.newStream();
    return MockRoom.stream;
  }
}
