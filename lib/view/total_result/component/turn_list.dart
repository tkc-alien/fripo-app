import 'package:flutter/cupertino.dart';
import 'package:fripo/domain/entity/turn_info.dart';
import 'package:fripo/view_model/total_result_view_model.dart';

class TurnList extends StatelessWidget {
  const TurnList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final turns = TotalResultViewModel.select(context, (vm) => vm.turns);

    return ListView.builder(
      itemCount: turns.length,
      itemBuilder: (context, index) => _TurnTile(index, turns[index]),
    );
  }
}

class _TurnTile extends StatelessWidget {
  const _TurnTile(this.index, this.info, {Key? key}) : super(key: key);

  final int index;
  final TurnInfo info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('turn: ${index + 1}'),
          Text('theme: ${info.theme}'),
        ],
      ),
    );
  }
}
