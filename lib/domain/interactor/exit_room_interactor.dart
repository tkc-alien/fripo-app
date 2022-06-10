import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/exit_room_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

class ExitRoomInteractor implements ExitRoomUseCase {
  @override
  Response<void> call({required String roomId}) async {
    final res = await ApiClient().call(
      endPoint: ApiConst.exitRoom,
      parameters: {'roomId': roomId},
    );
    return res.map((_) => null);
  }
}
