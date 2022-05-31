import 'package:fripo/domain/alias/request.dart';

abstract class SendAnswerUseCase {
  Response<void> call({required String answer});
}
