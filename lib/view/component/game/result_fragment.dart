import 'package:flutter/cupertino.dart';
import 'package:fripo/view/component/game/result/go_to_next_turn_button.dart';
import 'package:fripo/view/component/game/result/result_list.dart';
import 'package:fripo/view_model/result_view_model.dart';
import 'package:provider/provider.dart';

class ResultFragment extends StatelessWidget {
  const ResultFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResultViewModel(),
      builder: (context, child) {
        return Column(
          children: const [
            Expanded(child: ResultList()),
            GoToNextTurnButton(),
          ],
        );
      },
    );
  }
}
