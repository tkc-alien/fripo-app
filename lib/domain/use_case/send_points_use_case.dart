import 'package:fripo/domain/alias/request.dart';

abstract class SendPointsUseCase {
  Response<void> call({required Map<String, int> points});
}
