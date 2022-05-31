import 'package:dartz/dartz.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/use_case/register_user_use_case.dart';

class MockRegisterUserInteractor implements RegisterUserUseCase {
  @override
  Response<void> call() async {
    return const Right(null);
  }
}
