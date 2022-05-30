import 'package:fripo/domain/alias/request.dart';

abstract class NotifyActiveUseCase {
  Response<void> call({required bool isActive});
}
