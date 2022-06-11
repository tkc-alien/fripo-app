import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/send_answer_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

class SendAnswerInteractor implements SendAnswerUseCase {
  @override
  Response<void> call({required String answer}) async {
    final res = await ApiClient().call(
      endPoint: ApiConst.setAnswer,
      parameters: {
        'roomId': AppData.roomId,
        'answer': answer,
      },
    );
    return res.map((r) => null);
  }
}
