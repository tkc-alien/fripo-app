import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/cancel_join_room_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

class CancelJoinRoomInteractor implements CancelJoinRoomUseCase {
  @override
  Response<void> call() async {
    final res = await ApiClient().call(
      endPoint: ApiConst.cancelJoinRoom,
      parameters: {'roomId': AppData.roomId},
    );
    return res.map((r) => null);
  }
}
