import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/send_theme_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

import '../../data/app_data.dart';

class SendThemeInteractor implements SendThemeUseCase {
  @override
  Response<void> call({required String theme}) async {
    final res = await ApiClient().call(
      endPoint: ApiConst.setTheme,
      parameters: {
        'roomId': AppData.roomId,
        'theme': theme,
      },
    );
    return res.map((_) => null);
  }
}
