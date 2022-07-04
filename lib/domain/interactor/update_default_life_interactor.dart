import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/update_default_life_use_case.dart';

class UpdateDefaultLifeInteractor implements UpdateDefaultLifeUseCase {
  @override
  Response<void> call({required int defaultLife}) async {
    try {
      await FirebaseDatabase.instance
          .ref('rooms/${AppData.roomId}/defaultLife')
          .set(defaultLife);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
