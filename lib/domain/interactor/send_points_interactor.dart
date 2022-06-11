import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/send_points_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

class SendPointsInteractor implements SendPointsUseCase {
  @override
  Response<void> call({required Map<String, int> points}) async {
    final res = await ApiClient().call(
      endPoint: ApiConst.setPoints,
      parameters: {
        'roomId': AppData.roomId,
        'points': points,
      },
    );
    return res.map((r) => null);
  }
}
