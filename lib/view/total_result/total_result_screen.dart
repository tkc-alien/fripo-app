import 'package:flutter/material.dart';
import 'package:fripo/view/total_result/component/go_to_home_button.dart';
import 'package:fripo/view/total_result/component/member_rank_list.dart';
import 'package:fripo/view/total_result/component/open_log_button.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../util/ads/ads_util.dart';
import '../../view_model/total_result_view_model.dart';

class TotalResultScreen extends StatefulWidget {
  const TotalResultScreen({Key? key}) : super(key: key);

  @override
  State<TotalResultScreen> createState() => _TotalResultScreenState();
}

class _TotalResultScreenState extends State<TotalResultScreen> {
  final _ad = AdsUtil.banner;

  @override
  void initState() {
    super.initState();
    _ad.load();
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TotalResultViewModel(),
      builder: (context, child) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '最終結果',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 64,
                      ),
                    ),
                    const Divider(height: 16),
                    const Expanded(child: MemberRankList()),
                    const Divider(height: 8),
                    const Align(child: OpenLogButton()),
                    const Divider(height: 16),
                    const Align(child: GoToHomeButton()),
                    const Divider(height: 12),
                    SizedBox(
                      width: AdsUtil.width.toDouble(),
                      height: AdsUtil.height.toDouble(),
                      child: AdWidget(ad: _ad),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
