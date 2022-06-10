import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/start_room_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

class StartRoomInteractor implements StartRoomUseCase {
  @override
  Response<void> call({required String roomId}) async {
    final res = await ApiClient().call(
      endPoint: ApiConst.startGame,
      parameters: {'roomId': roomId},
    );
    return res.map((_) => null);
  }
}
