import 'package:flutter/material.dart';
import 'package:fripo/domain/entity/answer_info.dart';
import 'package:fripo/view_model/game_view_model.dart';
import 'package:fripo/view_model/marking_view_model.dart';

class AnswerList extends StatelessWidget {
  const AnswerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final answers = GameViewModel.select(
      context,
      (vm) => vm.currentTurnInfo?.answers,
    );

    return ListView(
      children: answers!.entries
          .map((entry) => _AnswerTile(entry.key, entry.value))
          .toList(),
    );
  }
}

class _AnswerTile extends StatefulWidget {
  const _AnswerTile(
    this.userId,
    this.info, {
    Key? key,
  }) : super(key: key);

  final String userId;
  final AnswerInfo info;

  @override
  State<_AnswerTile> createState() => _AnswerTileState();
}

class _AnswerTileState extends State<_AnswerTile> {
  double _point = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.info.answer),
        Slider(
          value: _point,
          min: 0,
          max: 1,
          onChanged: (value) {
            setState(() => _point = value);
          },
          onChangeEnd: (value) {
            final point = (value * 100).round();
            print('Answer \'${widget.info.answer}\' was marked $point.');
            MarkingViewModel.read(context).setPoint(widget.userId, point);
          },
        ),
      ],
    );
  }
}
