import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fripo/define/app_const.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
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
        title: const Text("利用規約"),
      ),
      body: const WebView(
        initialUrl: AppConst.termsUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
