import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/end_turn_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

class EndTurnInteractor implements EndTurnUseCase {
  @override
  Response<void> call() async {
    final res = await ApiClient().call(
      endPoint: ApiConst.endTurn,
      parameters: {'roomId': AppData.roomId},
    );
    return res.map((r) => null);
  }
}
