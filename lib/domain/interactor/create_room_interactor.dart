import 'package:dartz/dartz.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/use_case/create_room_use_case.dart';

class CreateRoomInteractor implements CreateRoomUseCase {
  @override
  Response<String> call() async {
    await Future.delayed(const Duration(microseconds: 3000));
    return const Right('12345');
  }
}
