import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fripo/define/app_const.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("プライバシーポリシー"),
      ),
      body: const WebView(
        initialUrl: AppConst.policyUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
