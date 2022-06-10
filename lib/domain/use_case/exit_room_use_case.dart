import 'package:fripo/define/alias.dart';

abstract class ExitRoomUseCase {
  Response<void> call({required String roomId});
}
