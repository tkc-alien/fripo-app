import 'package:fripo/domain/alias/request.dart';

abstract class StartRoomUseCase {
  Response<void> call({required String roomId});
}
