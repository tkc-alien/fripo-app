import 'package:fripo/domain/alias/request.dart';

abstract class GetRandomThemeUseCase {
  Response<String> call();
}
