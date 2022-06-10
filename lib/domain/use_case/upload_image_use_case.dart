import 'dart:io';

import 'package:fripo/define/alias.dart';

abstract class UploadImageUseCase {
  Response<String> call({required File image});
}
