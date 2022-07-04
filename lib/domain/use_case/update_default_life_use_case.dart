import 'package:fripo/define/alias.dart';

abstract class UpdateDefaultLifeUseCase {
  Response<void> call({required int defaultLife});
}
