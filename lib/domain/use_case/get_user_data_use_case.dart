import 'package:fripo/define/alias.dart';

import '../entity/user_info.dart';

abstract class GetUserDataUseCase {
  Response<UserInfo> call();
}
