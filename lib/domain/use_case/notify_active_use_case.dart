import 'package:fripo/define/alias.dart';

abstract class NotifyActiveUseCase {
  Response<void> call({required bool isActive});
}
