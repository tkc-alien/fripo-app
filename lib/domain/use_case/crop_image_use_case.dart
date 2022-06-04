import 'dart:io';

import 'package:fripo/domain/alias/request.dart';

abstract class CropImageUseCase {
  Response<File> call({required String sourcePath});
}
