import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/create_room_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

import '../../define/alias.dart';

class CreateRoomInteractor implements CreateRoomUseCase {
  @override
  Response<String> call() async {
    final res = await ApiClient().call(endPoint: ApiConst.createRoom);
    AppData.roomId = res.fold(
      (failure) => '',
      (data) => data['roomId'],
    );
    return res.map((data) => data['roomId']);
  }
}
