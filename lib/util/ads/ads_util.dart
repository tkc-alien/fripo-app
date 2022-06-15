import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsUtil {
  AdsUtil._();

  static String _bannerId = '';

  static int width = 320;
  static int height = 50;

  /// Ads用のパラメータをプラットフォームに合わせて初期化
  static Future<void> initialize() async {
    // プラットフォーム名を取得
    final String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else if (Platform.isAndroid) {
      platform = 'Android';
    } else {
      platform = 'else';
    }

    // アセットからAdmobデータを取得
    final json = await rootBundle.loadString('assets/protected/admob.json');
    final data = jsonDecode(json) as Map<dynamic, dynamic>;
    final platformData = data[platform] as Map<dynamic, dynamic>;

    // データを解析してIDを取得
    _bannerId = platformData['bannerId'];
  }

  static BannerAd get banner {
    return BannerAd(
      size: AdSize(width: width, height: height),
      adUnitId: _bannerId,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    );
  }
}
