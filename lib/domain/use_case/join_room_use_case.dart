import 'package:fripo/define/alias.dart';

abstract class JoinRoomUseCase {
  Response<void> call({required String roomId});
}
