import 'package:fripo/define/alias.dart';

import '../entity/room_info.dart';

abstract class GetRoomDataUseCase {
  Response<RoomInfo> call();
}
