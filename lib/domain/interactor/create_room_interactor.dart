import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/create_room_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

import '../alias/request.dart';

class CreateRoomInteractor implements CreateRoomUseCase {
  @override
  Response<String> call() async {
    final res = await ApiClient().call(endPoint: ApiConst.createRoom);
    return res.map((data) => data['roomId']);
  }
}
