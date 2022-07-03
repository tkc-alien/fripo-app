import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fripo/domain/use_case/register_user_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class AppIntroductionViewModel with ChangeNotifier {
  AppIntroductionViewModel() : _registerUserUseCase = sl();

  final RegisterUserUseCase _registerUserUseCase;

  String Function()? getNameText;

  Future<String?> register() async {
    final name = getNameText?.call();
    if (name == null) return 'getNameText is null';
    await FirebaseAuth.instance.signInAnonymously();
    final res = await _registerUserUseCase.call(name: name);
    return res.fold(
      (failure) => failure.toString(),
      (_) => null,
    );
  }

  static AppIntroductionViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(AppIntroductionViewModel vm) select,
  ) {
    return context.select(select);
  }
}
