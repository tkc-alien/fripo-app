import 'package:fripo/define/alias.dart';

abstract class SendPointsUseCase {
  Response<void> call({required Map<String, int> points});
}
