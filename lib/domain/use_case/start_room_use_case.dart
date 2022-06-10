import 'package:fripo/define/alias.dart';

abstract class StartRoomUseCase {
  Response<void> call({required String roomId});
}
