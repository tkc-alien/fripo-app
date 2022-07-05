import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/pick_image_use_case.dart';
import 'package:image_picker/image_picker.dart';

class PickImageInteractor implements PickImageUseCase {
  final _picker = ImagePicker();

  @override
  Response<File> call() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    print(picked);
    if (picked != null) {
      return Right(File(picked.path));
    } else {
      return const Left(Failure('No file picked.'));
    }
  }
}
