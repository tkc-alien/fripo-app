import 'package:fripo/domain/alias/request.dart';

abstract class SendThemeUseCase {
  Response<void> call({required String theme});
}
