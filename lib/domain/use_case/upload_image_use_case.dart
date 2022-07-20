import 'dart:typed_data';

import 'package:fripo/define/alias.dart';

abstract class UploadImageUseCase {
  Response<String> call({required Uint8List image});
}
