import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/use_case/exit_room_use_case.dart';

class MockExitRoomInteractor implements ExitRoomUseCase {
  @override
  Response<void> call() async {
    await Future.delayed(const Duration(milliseconds: 500));

    MockRoom.members.remove(MockRoom.userId);
    MockRoom.addSink();

    return const Right(null);
  }
}
