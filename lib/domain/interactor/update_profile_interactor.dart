import 'package:fripo/define/alias.dart';
import 'package:fripo/define/api_const.dart';
import 'package:fripo/domain/use_case/update_profile_use_case.dart';
import 'package:fripo/util/api/api_client.dart';

class UpdateProfileInteractor implements UpdateProfileUseCase {
  @override
  Response<void> call({
    required String? name,
    required String? iconUrl,
  }) async {
    final res = await ApiClient().call(
      endPoint: ApiConst.editUser,
      parameters: {
        'name': name,
        'iconUrl': iconUrl,
      },
    );
    return res.map((r) => null);
  }
}
