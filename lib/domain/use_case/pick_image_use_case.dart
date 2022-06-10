import 'dart:io';

import 'package:fripo/define/alias.dart';

abstract class PickImageUseCase {
  Response<File> call();
}
