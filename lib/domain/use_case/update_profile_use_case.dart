import 'package:fripo/define/alias.dart';

abstract class UpdateProfileUseCase {
  Response<void> call({
    required String? name,
    required String? iconUrl,
  });
}
