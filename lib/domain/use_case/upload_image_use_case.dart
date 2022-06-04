import 'dart:io';

import 'package:fripo/domain/alias/request.dart';

abstract class UploadImageUseCase {
  Response<String> call({required File image});
}
