import 'package:fripo/domain/alias/request.dart';

abstract class JoinRoomUseCase {
  Response<String> call({required String roomId});
}
