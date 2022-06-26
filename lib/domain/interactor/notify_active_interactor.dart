import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/notify_active_use_case.dart';

class NotifyActiveInteractor implements NotifyActiveUseCase {
  @override
  Response<void> call({required bool isActive}) async {
    try {
      await FirebaseDatabase.instance
          .ref('rooms/${AppData.roomId}/members/${AppData.userId}/isActive')
          .set(isActive);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
