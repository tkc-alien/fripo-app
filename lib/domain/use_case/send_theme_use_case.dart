import 'package:fripo/define/alias.dart';

abstract class SendThemeUseCase {
  Response<void> call({required String theme});
}
