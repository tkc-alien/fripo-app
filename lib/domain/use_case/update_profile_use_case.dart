import 'package:fripo/domain/alias/request.dart';

abstract class UpdateProfileUseCase {
  Response<void> call({
    required String? name,
    required String? iconUrl,
  });
}
