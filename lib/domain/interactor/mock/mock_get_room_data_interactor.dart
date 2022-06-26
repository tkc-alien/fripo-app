import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/entity/room_info.dart';
import 'package:fripo/domain/use_case/get_room_data_use_case.dart';

class MockGetRoomDataInteractor implements GetRoomDataUseCase {
  @override
  Response<RoomInfo> call() async {
    return Right(RoomInfo(
      state: MockRoom.state,
      members: MockRoom.members,
      turns: MockRoom.turns,
      defaultLife: 100,
      currentTurn: MockRoom.currentTurn,
      hostUserId: MockRoom.hostUserId,
    ));
  }
}
