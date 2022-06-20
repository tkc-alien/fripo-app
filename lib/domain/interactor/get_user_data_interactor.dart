import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/entity/user_info.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/get_user_data_use_case.dart';

class GetUserDataInteractor implements GetUserDataUseCase {
  @override
  Response<UserInfo> call() async {
    try {
      final event =
          await FirebaseDatabase.instance.ref('users/${AppData.userId}').once();

      return Right(
        UserInfo.fromMap(
          event.snapshot.value as Map<dynamic, dynamic>,
        ),
      );
    } catch (e) {
      return const Left(Failure('ユーザ情報の取得に失敗しました。'));
    }
  }
}
