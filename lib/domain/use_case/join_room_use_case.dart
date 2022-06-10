import 'package:fripo/define/alias.dart';

abstract class JoinRoomUseCase {
  Response<String> call({required String roomId});
}
