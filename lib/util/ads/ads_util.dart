import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsUtil {
  AdsUtil._();

  static late BannerAd banner;

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
    final bannerId = platformData['bannerId'];

    // Adオブジェクトを初期化
    banner = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerId,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    );
  }

  static Future<void> loadBannerAd() => banner.load();

  static Future<void> disposeBanner() => banner.dispose();
}
