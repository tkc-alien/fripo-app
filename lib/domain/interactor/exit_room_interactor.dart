import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/exit_room_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

import '../../data/app_data.dart';

class ExitRoomInteractor implements ExitRoomUseCase {
  @override
  Response<void> call() async {
    final res = await ApiClient().call(
      endPoint: ApiConst.exitGame,
      parameters: {'roomId': AppData.roomId},
    );
    AppData.roomId = res.fold(
      (failure) => AppData.roomId,
      (data) => '',
    );
    return res.map((_) => null);
  }
}
