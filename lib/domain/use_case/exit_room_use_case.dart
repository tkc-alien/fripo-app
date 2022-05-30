import 'package:fripo/domain/alias/request.dart';

abstract class ExitRoomUseCase {
  Response<void> call({required String roomId});
}
