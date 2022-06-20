import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/entity/room_info.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/get_room_data_use_case.dart';

class GetRoomDataInteractor implements GetRoomDataUseCase {
  @override
  Response<RoomInfo> call() async {
    try {
      final data =
          await FirebaseDatabase.instance.ref('rooms/${AppData.roomId}').once();

      return Right(
        RoomInfo.fromMap(
          data.snapshot.value as Map<dynamic, dynamic>,
        ),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
