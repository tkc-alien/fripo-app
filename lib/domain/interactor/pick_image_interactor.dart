import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/pick_image_use_case.dart';
import 'package:image_picker/image_picker.dart';

class PickImageInteractor implements PickImageUseCase {
  @override
  Response<File> call() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      return Right(File(picked.path));
    } else {
      return const Left(Failure('No file picked.'));
    }
  }
}
