import 'package:flutter/material.dart';
import 'package:fripo/domain/use_case/get_random_theme_use_case.dart';
import 'package:fripo/domain/use_case/send_theme_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class ThemeSettingViewModel with ChangeNotifier {
  ThemeSettingViewModel()
      : _sendThemeUseCase = sl(),
        _getRandomThemeUseCase = sl();

  final SendThemeUseCase _sendThemeUseCase;
  final GetRandomThemeUseCase _getRandomThemeUseCase;

  void Function(String text)? setText;
  String Function()? getText;

  Future<void> sendTheme() async {
    final theme = getText?.call();
    if (theme == null) {
      print('No Input Theme.');
      return;
    }
    final res = await _sendThemeUseCase.call(theme: theme);
    res.fold(
      (failure) => print(failure),
      (_) => print('SendTheme succeed.'),
    );
  }

  Future<void> generateRandomTheme() async {
    final res = await _getRandomThemeUseCase.call();
    res.fold(
      (failure) => print(failure),
      (data) => setText?.call(data),
    );
  }

  static ThemeSettingViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(ThemeSettingViewModel vm) select,
  ) {
    return context.select(select);
  }
}
