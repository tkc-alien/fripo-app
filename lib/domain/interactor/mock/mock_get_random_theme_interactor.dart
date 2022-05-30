import 'package:dartz/dartz.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/use_case/get_random_theme_use_case.dart';

class MockGetRandomThemeInteractor implements GetRandomThemeUseCase {
  @override
  Response<String> call() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return const Right('Generated Theme');
  }
}
