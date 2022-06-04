import 'dart:io';

import 'package:fripo/domain/alias/request.dart';

abstract class PickImageUseCase {
  Response<File> call();
}
