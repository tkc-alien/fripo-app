import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/join_room_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

import '../../data/app_data.dart';

class JoinRoomInteractor implements JoinRoomUseCase {
  @override
  Response<void> call({required String roomId}) async {
    final res = await ApiClient().call(
      endPoint: ApiConst.joinRoom,
      parameters: {'roomId': roomId},
    );
    AppData.roomId = res.fold(
      (failure) => '',
      (data) => roomId,
    );
    return res.map((data) => null);
  }
}
