import 'package:fripo/define/alias.dart';

abstract class RegisterUserUseCase {
  Response<void> call({required String name});
}
