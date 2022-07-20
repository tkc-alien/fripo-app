import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/upload_image_use_case.dart';

class UploadImageInteractor implements UploadImageUseCase {
  @override
  Response<String> call({required Uint8List image}) async {
    try {
      final snapshot = await FirebaseStorage.instance
          .ref('users/${AppData.userId}/profile.png')
          .putData(image);
      final url = await snapshot.ref.getDownloadURL();
      return Right(url);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
