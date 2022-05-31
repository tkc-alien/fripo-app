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
  const env = injector.Env.mock;

  // DI注入
  injector.init(env);

  // Firebase
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

  // AppData
  if (env == injector.Env.mock) {
    AppData.userId = MockRoom.userId;
  } else {
    AppData.userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  // runApp
  runApp(const App());
}
