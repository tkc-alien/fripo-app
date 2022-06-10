import 'dart:io';

import 'package:fripo/define/alias.dart';

abstract class CropImageUseCase {
  Response<File> call({required String sourcePath});
}
