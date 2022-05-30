import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fripo/view/app.dart';

import 'injector.dart' as injector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  injector.init(injector.Env.mock);

  await Firebase.initializeApp();

  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

  runApp(const App());
}
