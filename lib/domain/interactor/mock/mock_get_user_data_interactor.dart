import 'package:dartz/dartz.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/entity/user_info.dart';
import 'package:fripo/domain/use_case/get_user_data_use_case.dart';

class MockGetUserDataInteractor implements GetUserDataUseCase {
  @override
  Response<UserInfo> call() async {
    return const Right(UserInfo(name: 'モック', iconUrl: '...'));
  }
}
