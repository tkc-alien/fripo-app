import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/notify_ready_for_next_turn_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

class NotifyReadyForNextTurnInteractor
    implements NotifyReadyForNextTurnUseCase {
  @override
  Response<void> call() async {
    final res = await ApiClient().call(
      endPoint: ApiConst.readyForNextTurn,
      parameters: {'roomId': AppData.roomId},
    );
    return res.map((r) => null);
  }
}
