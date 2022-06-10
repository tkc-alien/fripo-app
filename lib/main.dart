import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/view/app.dart';

import 'injector.dart' as injector;

void main() async {
  // ensureInitialized
  WidgetsFlutterBinding.ensureInitialized();

  // 環境
  const env = injector.Env.develop;
  bool shouldShowIntroduction;

  // DI注入
  final diResult = injector.init(env);
  print(
      'DI injection for ${diResult.env.name} result: ${diResult.notRegisteredUseCaseList}');

  // Firebase
  await Firebase.initializeApp();
  if (env != injector.Env.mock) {
    shouldShowIntroduction = FirebaseAuth.instance.currentUser == null;
    await FirebaseAuth.instance.signInAnonymously();
  } else {
    shouldShowIntroduction = true;
  }

  // AppData
  if (env != injector.Env.mock) {
    AppData.userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  } else {
    AppData.userId = MockRoom.userId;
  }

  // runApp
  runApp(
    App(
      shouldShowIntroduction: shouldShowIntroduction,
    ),
  );
}
