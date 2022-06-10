import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/register_user_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

class RegisterUserInteractor implements RegisterUserUseCase {
  @override
  Response<void> call({required String name}) async {
    final res = await ApiClient().call(
      endPoint: ApiConst.registerUser,
      parameters: {
        'name': name,
      },
    );
    return res.map((r) => null);
  }
}
