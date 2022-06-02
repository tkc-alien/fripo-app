import 'package:flutter/material.dart';
import 'package:fripo/view/component/total_result/go_to_home_button.dart';
import 'package:fripo/view/component/total_result/turn_list.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/member_info.dart';
import '../../domain/entity/turn_info.dart';
import '../../view_model/total_result_view_model.dart';
import '../component/total_result/member_rank_list.dart';

class TotalResultScreen extends StatelessWidget {
  const TotalResultScreen({
    Key? key,
    required this.members,
    required this.turns,
  }) : super(key: key);

  final Map<String, MemberInfo> members;
  final List<TurnInfo> turns;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TotalResultViewModel(
        members: members,
        turns: turns,
      ),
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
