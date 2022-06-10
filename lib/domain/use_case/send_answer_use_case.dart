import 'package:fripo/define/alias.dart';

abstract class SendAnswerUseCase {
  Response<void> call({required String answer});
}
