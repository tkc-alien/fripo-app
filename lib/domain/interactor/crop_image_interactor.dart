import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/crop_image_use_case.dart';
import 'package:image_cropper/image_cropper.dart';

class CropImageInteractor implements CropImageUseCase {
  @override
  Response<File> call({required String sourcePath}) async {
    final cropped = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      cropStyle: CropStyle.circle,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (cropped != null) {
      return Right(File(cropped.path));
    } else {
      return const Left(Failure('No File cropped.'));
    }
  }
}
