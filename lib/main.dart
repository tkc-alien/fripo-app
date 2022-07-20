import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/util/ads/ads_util.dart';
import 'package:fripo/view/app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'injector.dart' as injector;

const env = injector.Env.product;
bool _shouldShowIntroduction = true;

void main() async {
  // ensureInitialized
  WidgetsFlutterBinding.ensureInitialized();

  // システムのUIを上書き
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light, // for iOS
      statusBarIconBrightness: Brightness.dark, // for Android
    ),
  );

  // 画面の向きを固定
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // DI注入
  injector.init(env);

  // 各種初期化処理
  await Future.wait([
    _setupFirebase(),
    _setupMobileAds(),
  ]);

  // AppData
  if (env != injector.Env.mock) {
    AppData.userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  } else {
    AppData.userId = MockRoom.userId;
  }

  // runApp
  runApp(
    App(
      shouldShowIntroduction: _shouldShowIntroduction,
    ),
  );
}

Future<void> _setupFirebase() async {
  await Firebase.initializeApp();
  if (env != injector.Env.mock) {
    _shouldShowIntroduction = FirebaseAuth.instance.currentUser == null;
  } else {
    _shouldShowIntroduction = false;
  }
}

Future<void> _setupMobileAds() async {
  await MobileAds.instance.initialize();
  await AdsUtil.initialize(env: env);
}
