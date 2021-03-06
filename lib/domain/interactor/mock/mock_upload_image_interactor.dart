import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/use_case/upload_image_use_case.dart';

class MockUploadImageInteractor implements UploadImageUseCase {
  @override
  Response<String> call({required Uint8List image}) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return const Right('uploaded URL');
  }
}
