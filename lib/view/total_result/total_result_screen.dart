import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/total_result_view_model.dart';
import 'component/go_to_home_button.dart';
import 'component/member_rank_list.dart';
import 'component/turn_list.dart';

class TotalResultScreen extends StatelessWidget {
  const TotalResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TotalResultViewModel(),
      builder: (context, child) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('TotalResult'),
            ),
            body: SafeArea(
              child: Column(
                children: const [
                  Expanded(child: MemberRankList()),
                  Divider(),
                  Expanded(child: TurnList()),
                  GoToHomeButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
