import 'package:dartz/dartz.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/use_case/update_profile_use_case.dart';

class MockUpdateProfileInteractor implements UpdateProfileUseCase {
  @override
  Response<void> call({
    required String? name,
    required String? iconUrl,
  }) async {
    return const Right(null);
  }
}
